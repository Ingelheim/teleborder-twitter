class TwitterClient
	attr_reader :twitterQuery

	def initialize(consumer_key, consumer_secret)
		@twitterQuery = instantiateClient(consumer_key, consumer_secret)
		@busy = false
	end

	def self.getRandomClient(clients)
		pickRandomClient(getAvailableClients(clients))
	end

	def self.getAvailableClients(clients)
		clients.reject {|client| client.busy? }
	end

	def self.pickRandomClient(clients)
		clients[rand(clients.length)]
	end

	def startWorking
		@busy = true
	end

	def stopWorking
		@busy = false
	end

	def busy?
		@busy
	end

	private
	def instantiateClient(consumer_key, consumer_secret)
        Twitter::REST::Client.new do |config|
            config.consumer_key    = consumer_key
            config.consumer_secret = consumer_secret
        end
    end
end