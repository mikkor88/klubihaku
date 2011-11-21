class UserlocationsController < ApplicationController
	
	def location
	end
	
	def do_location
		cookies[:address] = params[:address]
		cookies[:distance] = params[:distance].to_f
		redirect_to map_path
	end
end
