class RelationshipsController < ApplicationController
  require "relationship.rb"

	def create
		current_user.follow(params[:user_id])
		redirect_back(fallback_location:root_path)
	end

	def destroy
		current_user.unfollow(params[:user_id])
		redirect_back(fallback_location:root_path)
	end

	def follows
		user = User.find(params[:user_id])
		@users = user.following_user
	end

	def followers
		user = User.find(params[:user_id])
    	@users = user.follower_user
	end
end
