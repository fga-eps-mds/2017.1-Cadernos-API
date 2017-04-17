require 'rails_helper'

RSpec.describe "Categories", type: :request do
  describe "GET /categories" do
    it "works! (now write some real specs)" do
      get categories_path
      expect(response).to have_http_status(401) #due to no authentication, the response status to GET /categories will be 401
    end
  end
end
