class CrateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :subject
      t.string :content

      t.timestamps null: false
    end
  end
end
