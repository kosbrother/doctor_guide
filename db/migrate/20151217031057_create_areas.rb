class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
    end
    add_column :hospitals, :area_id, :integer
    add_index :hospitals, :area_id
  end
end
