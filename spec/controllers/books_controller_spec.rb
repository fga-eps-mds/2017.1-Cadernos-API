require 'rails_helper'

RSpec.describe BooksController, type: :controller do

  let(:user) {
    create :user
  }

  let(:book) {
    create :book, title: 'first', user: user
  }

  let(:valid_attributes) {
    {
      :title => "ValidTitle",
      :user => user
    }
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all books as @books" do
      expect(book.save).to be(true)

      @token = AuthenticateUser.call(user.email, user.password)
      request.headers["Authorization"] = @token.result

      get :index
      expect(assigns(:books)).to eq([book])
    end
  end

  describe "GET #show" do
    it "assigns book as @book" do
      expect(book.save).to be(true)

      @token = AuthenticateUser.call(user.email, user.password)
      request.headers["Authorization"] = @token.result

      get :show, :params => {id_book: book.id, id: user.id}
      expect(assigns(:book)).to eq(book)
    end
  end

  describe "PUT #update" do
    context "with valid params" do

      let(:new_attributes) {
        {:title => "newValid Title"}
      }

      let(:invalid_attributes) {
        {:title => "ivT"}
      }

      it "updates the requested @book" do
        book = FactoryGirl.create :book
        @token = AuthenticateUser.call(book.user.email, book.user.password)
        request.headers["Authorization"] = @token.result
        put :update, params: {id: book.id, book: new_attributes}, session: valid_session
        book.reload
        expect(book.title).to eq(new_attributes[:title])
      end

      context "with invalid params" do
        it "assigns the book as @book" do
          book = FactoryGirl.create :book
          @token = AuthenticateUser.call(book.user.email, book.user.password)
          request.headers["Authorization"] = @token.result
          put :update, params: {id: book.id, book: invalid_attributes}, session: valid_session
          expect(assigns(:book)).to eq(book)
        end
      end

    end

  end

  describe "DELETE #destroy" do
    it "destroys the requested @books" do
      expect(book.save).to be(true)

      @token = AuthenticateUser.call(user.email, user.password)
      request.headers["Authorization"] = @token.result

      expect {
        delete :destroy, params: {id: book.id}
      }.to change(Book, :count).by(-1)
      expect(Book.find_by_id(book.id)).to be(nil)
    end
  end

  describe "POST #create" do
    it "creates a valid book" do

      @token = AuthenticateUser.call(user.email, user.password)
      request.headers["Authorization"] = @token.result

      expect {
        post :create, params: {book: {title: "NewValidTitle", user_id: user.id}}, session: valid_session
      }.to change(Book, :count).by(1)
    end

    it "won't create a book with invalid attributes" do

      @token = AuthenticateUser.call(user.email, user.password)
      request.headers["Authorization"] = @token.result

      expect {
        post :create, params: {book: {title: "nope", user_id: user.id}}, session: valid_session
      }.to change(Book, :count).by(0)
    end
  end
end
