class Api::FollowersController < ApplicationController

	def index
		render :json => getFollowers(params["twitterHandleA"], params["twitterHandleB"])
	end
end
