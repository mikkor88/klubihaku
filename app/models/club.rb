class Club < ActiveRecord::Base
	attr_accessible :address, :lat, :lng
	geocoded_by :address, :latitude  => :lat, :longitude => :lng 
	after_validation :geocode, :if => :address_changed?
end
