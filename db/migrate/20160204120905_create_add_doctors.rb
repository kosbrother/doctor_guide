class CreateAddDoctors < ActiveRecord::Migration
  def change
    create_table :add_doctors do |t|
      t.string :name
      t.string :hospital_name
      t.string :division_name
      t.string :spe
      t.string :exp
      t.integer :hospital_id
      t.integer :division_id
      t.boolean :is_checked, default: false

      t.timestamps null: false
    end
  end
end
