class AddIntroToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :intro, :text
  end
end
