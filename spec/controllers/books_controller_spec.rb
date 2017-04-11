require 'rails_helper'

RSpec.describe BooksController, type: :controller do

  let(:user) {
    create :user
  }

  let(:book) {
    create :book, title: 'first', user: user
  }

  describe "GET #index" do
    it "assigns all books as @books" do
      expect(book.save).to be(true)

      get :index
      expect(assigns(:books)).to eq([book])
    end
  end

  describe "GET #show" do
    it "assings book as @book" do
      expect(book.save).to be(true)
      get :show, :params => {id: book.id}
      expect(assigns(:book)).to eq(book)
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested @books" do
      delete :destroy, params: {id: book.id}
      expect(Book.find_by_id(book.id)).to be(nil)
    end
  end



end
