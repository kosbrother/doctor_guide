class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.string :name
      t.integer :category_id

      t.timestamps null: false
    end
    add_index :divisions, :category_id
  end
end
