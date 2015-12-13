class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :name
      t.string :hosp
      t.string :phone
      t.string :address
      t.string :div
      t.string :exp
      t.string :spe
      t.string :coUrl
      t.string :bUrl


      t.timestamps null: false
    end
    add_index :doctors, :coUrl
    add_index :doctors, :bUrl
    add_index :doctors, :name
  end
end
