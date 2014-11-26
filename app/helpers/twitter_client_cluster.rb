class TwitterClientCluster

	CONSUMER_KEYS_SECRET_PAIRS = [
		{consumer_key: "uR8zjaGX24MtqPYfVLanw8HBi", consumer_secret: "jLxDcL9SQLreeoMEN4ctb3FVHZPstjDCoJfSDl3UEDDG2vHa9Y"},
    {consumer_key: "lNgq9uoUjPgRoObAKSeBS0z5K", consumer_secret: "42JQopHXyMOtP8vdddSlALnDxnFL7374w7DWAhpw1T1wOQq9hU"},
    {consumer_key: "fc6sIQOZRuDHy6BYgBuKUAmax", consumer_secret: "vsZwKjkb9MtL1Ui1OdHcXWYPkV18nMp411nm5zla0NaQDPdE0h"},
    {consumer_key: "t8bqtlIaYebzYmvuij0joMGmJ", consumer_secret: "V2EioPL6IApDaQtT1o50f7uzfCTGzH33udGVgD1NNjeOxQmJKM"},
    {consumer_key: "bvEp3LsKqnsaJHW9JALBqTINh", consumer_secret: "AjlPx8d76rH5Wh5aekNQ7I0fvcrI3oGnhkcSVLA8jek5GVgjup"},
    {consumer_key: "T2QWLg7OIIHt7TsNt2rWhpDOK", consumer_secret: "prOEvmLNmTNfpKrE25ILwP3ANRML71Li8GutfdkiAGwGkOrcRE"},
    {consumer_key: "Gw4T2DxM1PyIihJ1broVgrKeF", consumer_secret: "P1VPlCrHptsWXB0ASXAD0PDTMuhP7NNWDtxD55SUFQgZzIppMY"}
  ]

  def initialize
    @clients = []
    instatiateClients()
  end

  def getClient
    TwitterClient.getRandomClient(@clients)
  end

  private
  def instatiateClients
    CONSUMER_KEYS_SECRET_PAIRS.each do |key_secret_pair|
     @clients << TwitterClient.new(key_secret_pair[:consumer_key], key_secret_pair[:consumer_secret])
    end
  end
end