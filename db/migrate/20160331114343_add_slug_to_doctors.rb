class AddSlugToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :slug, :string
    add_index :doctors, :slug, unique: true
  end
end
