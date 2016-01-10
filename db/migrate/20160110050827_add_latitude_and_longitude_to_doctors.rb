class AddLatitudeAndLongitudeToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :latitude, :decimal, {:precision=>10, :scale=>6}
    add_column :doctors, :longitude, :decimal, {:precision=>10, :scale=>6}
  end
end
