class Club < ActiveRecord::Base
	geocoded_by :address, :latitude  => :lat, :longitude => :lng 
	after_validation :geocode, :if => :address_changed?
	
	acts_as_gmappable :lat => 'lat', :lng => 'lng', :check_process => :prevent_geocoding,
                  :address => "address", :normalized_address => "address",
                  :msg => "Sorry, not even Google could figure out where that is"

	def prevent_geocoding
		address.blank? || (!lat.blank? && !lng.blank?) 
	end
end
