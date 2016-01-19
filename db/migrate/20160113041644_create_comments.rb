class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|

      t.integer :dr_friendly
      t.integer :dr_speciality
      t.integer :div_equipment
      t.integer :div_environment
      t.integer :div_speciality
      t.integer :div_friendly
      t.integer :doctor_id
      t.integer :hospital_id
      t.integer :division_id
      t.text :div_comment
      t.text :dr_comment
      t.timestamps null: false
    end
    add_index :comments, :doctor_id
    add_index :comments, :hospital_id
    add_index :comments, :division_id
  end
end
