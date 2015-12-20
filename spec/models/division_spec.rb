require 'rails_helper'

describe Division do
  it { should have_many(:doctors) }
  it { should have_many(:hospitals) }
  it { should have_db_column :name }
  it { should have_db_column :category_id }
  
  it { should have_db_index :category_id }
end