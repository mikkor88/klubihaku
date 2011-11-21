class UserlocationsController < ApplicationController
	
	def location
		@clubs = Club.near(cookies[:address], cookies[:distance]).to_gmaps4rails
	end
	
	def do_location
		cookies[:address] = params[:address]
		cookies[:distance] = params[:distance].to_f/1.609344 # conversion to miles
		redirect_to root_path
	end
end
