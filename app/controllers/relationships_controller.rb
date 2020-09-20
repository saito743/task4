class RelationshipsController < ApplicationController
  require "relationship.rb"

	def create
		current_user.follow(params[:user_id])
		redirect_back(fallback_location:root_path)
	end

	def destroy
		current_user.unfollow(params[:id])
		redirect_back(fallback_location:root_path)
	end
end
