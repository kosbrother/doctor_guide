class AddAreaIdToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :area_id, :integer
    add_index :doctors, :area_id
  end
end
