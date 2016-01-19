require "rails_helper"

RSpec.describe DivisionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/divisions").to route_to("divisions#index")
    end

    it "routes to #new" do
      expect(:get => "/divisions/new").to route_to("divisions#new")
    end

    it "routes to #show" do
      expect(:get => "/divisions/1").to route_to("divisions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/divisions/1/edit").to route_to("divisions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/divisions").to route_to("divisions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/divisions/1").to route_to("divisions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/divisions/1").to route_to("divisions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/divisions/1").to route_to("divisions#destroy", :id => "1")
    end

  end
end
