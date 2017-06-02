require "rails_helper"

RSpec.describe InvitesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/invites").to route_to("invites#index")
    end

    it "routes to #new" do
      expect(:get => "/invites/new").to route_to("invites#new")
    end

    it "routes to #show" do
      expect(:get => "/invites/1").to route_to("invites#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/invites/1/edit").to route_to("invites#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/invites").to route_to("invites#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/invites/1").to route_to("invites#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/invites/1").to route_to("invites#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/invites/1").to route_to("invites#destroy", :id => "1")
    end

  end
end
