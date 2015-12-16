require 'rails_helper'

describe Category do
  it { should have_many(:hospitals) }
  it { should have_db_column :name }
end