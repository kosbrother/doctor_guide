require 'rails_helper'

RSpec.describe SearchController, type: :controller do

  describe "GET #byArea" do
    it "returns http success" do
      get :byArea
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #byCategory" do
    it "returns http success" do
      get :byCategory
      expect(response).to have_http_status(:success)
    end
  end

end
