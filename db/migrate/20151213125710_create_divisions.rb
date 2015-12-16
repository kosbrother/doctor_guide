class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.string :name
      t.integer :doctor_id
      t.integer :hospital_id
      t.integer :category_id

      t.timestamps null: false
    end
    add_index :divisions, :doctor_id
    add_index :divisions, :hospital_id
    add_index :divisions, :category_id
  end
end
