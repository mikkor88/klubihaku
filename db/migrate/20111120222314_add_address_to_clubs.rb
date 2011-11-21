class AddAddressToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :address, :string
    add_column :clubs, :lat, :float
    add_column :clubs, :lng, :float
    add_column :clubs, :gmaps, :boolean
    add_column :clubs, :distance, :float
  end
end
