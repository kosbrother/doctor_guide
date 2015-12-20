class ChangeHospExpToText < ActiveRecord::Migration
  def change
    change_column :doctors, :exp, :text
  end
end
