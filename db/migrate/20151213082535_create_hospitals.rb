class CreateHospitals < ActiveRecord::Migration
  def change
    create_table :hospitals do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.string :grade
      t.string :assess
      t.string :nhiUrl
      t.string :code
      t.string :coUrl
      t.boolean :on
      t.text :cHours
      t.text :divs
      t.text :ss

      t.timestamps null: false
    end
    add_index :hospitals, :name
  end
end
