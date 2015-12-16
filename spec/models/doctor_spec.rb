require 'rails_helper'

describe Doctor do
  it { should have_many(:hospitals) }
  it { should have_db_column :name }
  it { should have_db_column :hosp }
  it { should have_db_column :phone }
  it { should have_db_column :address }
  it { should have_db_column :div }
  it { should have_db_column :exp }
  it { should have_db_column :spe }
  it { should have_db_column :coUrl }
  it { should have_db_column :name }
  it { should have_db_column :bUrl }

  it { should have_db_index :name }
end

