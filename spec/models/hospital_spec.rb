require 'rails_helper'

RSpec.describe Hospital, type: :model do
  # it{ is_expected.to have_and_belong_to_many(:doctors)}

  it { should validate_presence_of :name }
  it { should have_db_column :name }
  it { should have_db_column :phone }
  it { should have_db_column :address }
  it { should have_db_column :grade }
  it { should have_db_column :assess }
  it { should have_db_column :nhiUrl }
  it { should have_db_column :code }
  it { should have_db_column :coUrl }
  it { should have_db_column :on }
  it { should have_db_column :cHours }
  it { should have_db_column :divs }
  it { should have_db_column :ss }
  
  it { should have_db_index :name }
end
