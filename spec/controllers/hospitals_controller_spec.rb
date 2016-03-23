require 'rails_helper'

RSpec.describe HospitalsController, type: :controller do

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
