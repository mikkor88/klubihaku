class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name
      t.string :type

      t.timestamps
    end
  end
end
