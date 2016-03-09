require 'rails_helper'

RSpec.describe InformationController, type: :controller do

  describe "GET #hospital" do
    it "returns http success" do
      get :hospital
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #category" do
    it "returns http success" do
      get :category
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #doctor" do
    it "returns http success" do
      get :doctor
      expect(response).to have_http_status(:success)
    end
  end

end
