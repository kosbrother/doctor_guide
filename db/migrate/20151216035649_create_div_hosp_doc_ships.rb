class CreateDivHospDocShips < ActiveRecord::Migration
  def change
    create_table :div_hosp_doc_ships do |t|
      t.integer :doctor_id
      t.integer :hospital_id
      t.integer :division_id

      t.timestamps null: false
    end
    add_index :div_hosp_doc_ships, :doctor_id
    add_index :div_hosp_doc_ships, :hospital_id
    add_index :div_hosp_doc_ships, :division_id
  end
end
