class UserlocationsController < ApplicationController
	
	def location
		if !cookies[:address].nil? && !cookies[:distance].nil?
			if Club.near(cookies[:address], cookies[:distance]).empty?
				@clubs = Club.find(2).to_gmaps4rails do |club, marker| # shows Kamppi as default location
					marker.infowindow render_to_string(:partial => "clubs/my_template", :locals => { :club => club }).gsub(/\n/, '').gsub(/"/, '\"')
					marker.title   "#{club.name}"
					marker.json    "\"id\": #{club.id}"
					end
				@message = "No clubs found within specified distance."
			else
				@clubs = Club.near(cookies[:address], cookies[:distance]).to_gmaps4rails  do |club, marker|
					marker.infowindow render_to_string(:partial => "clubs/my_template", :locals => { :club => club }).gsub(/\n/, '').gsub(/"/, '\"')
					marker.title   "#{club.name}"
					marker.json    "\"id\": #{club.id}"
					end
				@message = "Found clubs nearby your location!"
			end
		else
			@clubs = Club.find(2).to_gmaps4rails do |club, marker| # shows Kamppi as default location
					marker.infowindow render_to_string(:partial => "clubs/my_template", :locals => { :club => club }).gsub(/\n/, '').gsub(/"/, '\"')
					marker.title   "#{club.name}"
					marker.json    "\"id\": #{club.id}"
					end
			@message = "Enter your address and maximum distance you'd like to travel."
		end
	end
	
	def do_location
		cookies[:address] = params[:address]
		cookies[:distance] = params[:distance].to_f/1.609344 # conversion to miles
		redirect_to root_path
	end
end
