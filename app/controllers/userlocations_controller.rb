class UserlocationsController < ApplicationController
	
	def location
		if cookies[:address].nil? && cookies[:distance].nil?
			@clubs = []
			@message = "Enter your address and the maximum distance you'd like to travel."
			if !current_user.nil?
				@own_location = [{"lng" => current_user.lng, "lat" => current_user.lat, "radius" => 20}].to_json
			else
				@own_location = [{"lng" => request.location.longitude, "lat" => request.location.latitude, 
													"radius" => 20}].to_json
			end
		elsif Club.near(cookies[:address], cookies[:distance]).empty?
			@clubs = []
			user_coords = Geocoder.coordinates(cookies[:address])
			@own_location = [{"lng" => user_coords[1], "lat" => user_coords[0], "radius" => 20}].to_json
			@message = "No clubs found within specified distance."
		else
			@clubs = Club.near(cookies[:address], cookies[:distance]).to_gmaps4rails  do |club, marker|
				marker.infowindow render_to_string(:partial => "clubs/my_template",
																						:locals => { :club => club }).gsub(/\n/, '').gsub(/"/, '\"')
				marker.json    "\"id\": #{club.id}"
				end
			user_coords = Geocoder.coordinates(cookies[:address])
			@own_location = [{"lng" => user_coords[1], "lat" => user_coords[0], "radius" => 20}].to_json
			@message = "Found clubs nearby your location!"
		end
	end
	
	def do_location
		if params[:address].empty? || params[:distance].empty?
			redirect_to root_path
		else
			cookies[:address] = params[:address]
			cookies[:distance] = params[:distance].to_f/1.609344 # conversion to miles
			redirect_to root_path
		end
	end
end