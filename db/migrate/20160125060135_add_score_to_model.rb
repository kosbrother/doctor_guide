class AddScoreToModel < ActiveRecord::Migration
  def change
    add_column :hospitals, :comment_num, :integer
    add_column :hospitals, :recommend_num, :integer
    add_column :hospitals, :avg, :decimal, {:precision=>10, :scale=>6}

    add_column :doctors, :comment_num, :integer
    add_column :doctors, :recommend_num, :integer
    add_column :doctors, :avg, :decimal, {:precision=>10, :scale=>6}

    add_index :doctors, :comment_num
    add_index :doctors, :recommend_num
    add_index :doctors, :avg
    add_index :hospitals, :comment_num
    add_index :hospitals, :recommend_num
    add_index :hospitals, :avg
  end
end
