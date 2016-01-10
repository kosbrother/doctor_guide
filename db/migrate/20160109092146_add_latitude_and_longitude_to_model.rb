class AddLatitudeAndLongitudeToModel < ActiveRecord::Migration
  def change
    add_column :hospitals, :latitude, :decimal, {:precision=>10, :scale=>6}
    add_column :hospitals, :longitude, :decimal, {:precision=>10, :scale=>6}
  end
end
