require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe "GET /books" do
  
    it "gives all books" do
      book = Book.create
      get :index
      expect(assigns(:books)).to eq([book])
    end
  end
end
