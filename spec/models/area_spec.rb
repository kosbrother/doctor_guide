require 'rails_helper'

describe Area do
  it { should have_many(:hospitals) }
  it { should have_db_column :name }
end
