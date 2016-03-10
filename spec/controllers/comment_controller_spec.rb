require 'rails_helper'

RSpec.describe CommentController, type: :controller do

  describe "GET #doctor" do
    it "returns http success" do
      get :doctor
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #hospital" do
    it "returns http success" do
      get :hospital
      expect(response).to have_http_status(:success)
    end
  end

end
