require "rails_helper"

RSpec.describe BooksController, type: :routing do
  describe "routing" do

    it "routes to #destroy" do
      expect(:delete => "/books/1").to route_to("books#destroy", :id => "1")
    end

  end
end
