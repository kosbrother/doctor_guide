require 'rails_helper'

RSpec.describe DoctorsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #recommend" do
    it "returns http success" do
      get :recommend
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #area_recommend" do
    it "returns http success" do
      get :area_recommend
      expect(response).to have_http_status(:success)
    end
  end

end
