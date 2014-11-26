class Api::TweetsController < ApplicationController

	def index
		render :json => {tweets: getTweets(params["twitterHandle"])}
	end
end
