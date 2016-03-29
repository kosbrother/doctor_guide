class AddIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :app_id, :string
    add_index :users, :app_id
  end
end
