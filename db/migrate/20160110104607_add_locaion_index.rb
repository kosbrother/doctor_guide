class AddLocaionIndex < ActiveRecord::Migration
  def change
    add_index :doctors, :latitude
    add_index :doctors, :longitude
    add_index :hospitals, :latitude
    add_index :hospitals, :longitude
  end
end
