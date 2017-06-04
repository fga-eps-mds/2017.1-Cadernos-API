require 'rails_helper'

RSpec.describe "Memberships", type: :request do
  describe "GET /memberships" do
    it "works! (now write some real specs)" do
      get memberships_path
      expect(response).to have_http_status(401) #due to no authentication, the response status to GET /memberships will be 401
    end
  end
end
