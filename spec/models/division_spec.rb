require 'rails_helper'

describe Division do
  it { should have_db_column :name }
  it { should have_db_column :doctor_id }
  it { should have_db_column :hospital_id }
  it { should have_db_column :category_id }
  it { should have_db_index :doctor_id }
  it { should have_db_index :hospital_id }
  it { should have_db_index :category_id }
end