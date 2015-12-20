class ChangeHospSpeToText < ActiveRecord::Migration
  def change
    change_column :doctors, :spe, :text
  end
end
