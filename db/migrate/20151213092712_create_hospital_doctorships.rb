class CreateHospitalDoctorships < ActiveRecord::Migration
  def change
    create_table :hospital_doctorships do |t|
      t.integer :doctor_id
      t.integer :hospital_id

      t.timestamps null: false
    end
  end
end
