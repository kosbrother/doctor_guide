class AddIsRecommendToComments < ActiveRecord::Migration
  def change
    add_column :comments, :is_recommend, :boolean
  end
end
