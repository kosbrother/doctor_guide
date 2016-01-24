class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :pic_url
      t.timestamps null: false
    end
    add_index :users, :email
    add_column :comments, :user_id, :integer
    add_index :comments, :user_id
  end
end
