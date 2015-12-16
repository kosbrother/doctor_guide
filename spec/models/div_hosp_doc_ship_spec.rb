require 'rails_helper'

describe DivHospDocShip do
  it { should have_db_column :doctor_id }
  it { should have_db_column :hospital_id }
  it { should have_db_column :division_id }
  
  it { should have_db_index :doctor_id }
  it { should have_db_index :hospital_id }
  it { should have_db_index :division_id }
end