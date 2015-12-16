class DropHospitalDoctorhip < ActiveRecord::Migration
  def change
    drop_table :hospital_doctorships
  end
end
