class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.text :content
      t.integer :doctor_id
      t.integer :hospital_id
      t.integer :division_id

      t.timestamps null: false
    end
  end
end
