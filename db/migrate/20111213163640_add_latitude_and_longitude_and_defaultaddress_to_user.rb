class AddLatitudeAndLongitudeAndDefaultaddressToUser < ActiveRecord::Migration
  def change
    add_column :users, :lat, :float
    add_column :users, :lng, :float
    add_column :users, :defaultaddress, :string
  end
end
