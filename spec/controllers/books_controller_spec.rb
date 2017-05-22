require 'rails_helper'

RSpec.describe BooksController, type: :controller do

  let(:user){
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

      get :index
      expect(assigns(:books)).to eq([book])
    end

    it "will paginate book" do
      6.times do |n|
        Book.create! title: "Test book #{n}", user: user
      end

      get :index, params: {page: 1, per_page: 5}

      expect(Book.count > 5).to eq(true)

      expect(
        assigns(:books).length
      ).to eq(5)

      get :index, params: {page: 1, per_page: 2}

      expect(
        assigns(:books).length
      ).to eq(2)
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

    let(:new_attributes) {
      {:title => "newValid Title"}
    }

    let(:invalid_attributes) {
      {:title => "ivT"}
    }

    context "with valid params" do

      it "updates the requested @book" do
        book = FactoryGirl.create :book
        @token = AuthenticateUser.call(book.user.email, book.user.password)
        request.headers["Authorization"] = @token.result
        put :update, params: {id: book.id, book: new_attributes}, session: valid_session
        book.reload
        expect(book.title).to eq(new_attributes[:title])
      end
    end

    context "with invalid params" do
      it "won't update the book" do
        book = FactoryGirl.create :book
        @token = AuthenticateUser.call(book.user.email, book.user.password)
        request.headers["Authorization"] = @token.result
        put :update, params: {id: book.id, book: invalid_attributes}, session: valid_session
        book.reload
        expect(assigns(book.title)).not_to eq(invalid_attributes[:title])
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
  
  describe "GET tasks" do
    it "displays the tasks of a given book" do
      tasks = []
      tasks << Task.create(title: "task 1", content: "tast 1", user: user, book: book)
      tasks << Task.create(title: "task 2", content: "tast 2", user: user, book: book)
      
      
      @token = AuthenticateUser.call(user.email, user.password)
      request.headers["Authorization"] = @token.result
      
      get :tasks, params: {id: book.id}
      
      expect(
        assigns(:tasks)
      ).to eq(tasks)
    end
  end
end
