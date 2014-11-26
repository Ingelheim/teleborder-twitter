module TwitterHelper
  TWITTER_CLIENT_CLUSTER = TwitterClientCluster.new

  def getTweets(twitterHandle)
    options = {count: 200, include_rts: false}
    TWITTER_CLIENT_CLUSTER.getClient().twitterQuery.user_timeline(twitterHandle, options).map{ |tweet| tweet.text }
  end

  def getFollowers(twitterHandleA, twitterHandleB)
    followersDumpQueue = Queue.new

    instantiateIDLookupThread(twitterHandleA, followersDumpQueue)
    instantiateIDLookupThread(twitterHandleB, followersDumpQueue)

    returnCombinedFollowers(followersDumpQueue)
  end

  def instantiateIDLookupThread(twitterHandle, queue)
    thread = Thread.new { startFollowerIDLookupThread(twitterHandle, queue) }
    thread.abort_on_exception = true
    thread.join
  end

  def startFollowerIDLookupThread(twitterHandle, queue)
    twitterClient = getRandomFreeClient()
    twitterQuery = twitterClient.twitterQuery
    twitterClient.startWorking()

    follower_ids = twitterQuery.follower_ids(twitterHandle)
    queue << follower_ids

    twitterClient.stopWorking()
  end

  def returnCombinedFollowers(followerIDQueue)
    slizedIDsToLookup = combineAndSliceAggregatedFollowerIDs(followerIDQueue)
    combinedFollowerNames = []

    combinedFollowerNameQueue = instantiateNameLookupThread(slizedIDsToLookup, Queue.new)

    combineAndFlattenFollowerNameQueue(combinedFollowerNameQueue)
  end

  def combineAndSliceAggregatedFollowerIDs(followerIDQueue)
    combinedTwitterIDs = followerIDQueue.pop.to_a & followerIDQueue.pop.to_a
    lookupsPerThread = (combinedTwitterIDs.length / 4).ceil
    combinedTwitterIDs.each_slice(lookupsPerThread)
  end

  def instantiateNameLookupThread(slizedIDsToLookup, followerNameQueue)
    slizedIDsToLookup.each_with_index do |slice, index|
      startFollowerNameLookupThread(followerNameQueue, slice, index)
    end
    followerNameQueue
  end

  def startFollowerNameLookupThread(queue, slice, index)
    thread = Thread.new { lookupName(slice, queue) }
    thread.abort_on_exception = true
    thread.join
  end

  def lookupName(slice, queue)
    mappedSlice = []

    slice.each do |userId| 
      twitterClient = getRandomFreeClient()
      twitterQuery = twitterClient.twitterQuery
      twitterClient.startWorking()
      user = twitterQuery.user(userId)

      mappedSlice << "@#{user.screen_name} - #{user.name} (#{user.followers_count} followers): #{user.description}"

      twitterClient.stopWorking()
    end

    queue << mappedSlice
  end

  def combineAndFlattenFollowerNameQueue(followerNameQueue)
    combinedFollowerNames = []

    until followerNameQueue.empty? do
      combinedFollowerNames << followerNameQueue.pop
    end

    combinedFollowerNames.flatten
  end

  # HELPER METHOD
  def getRandomFreeClient()
    TWITTER_CLIENT_CLUSTER.getClient()
  end  
end