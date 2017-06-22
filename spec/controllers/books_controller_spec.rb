require 'rails_helper'

RSpec.describe BooksController, type: :controller do

  let(:user) {
    create :user
  }

  let(:book) {
    create :book, title: 'first', user: user
  }

  let(:category){
    create :category, name: 'criacao', description: 'criando ousado'
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

  describe "GET #all" do
    it "assigns all books as @books" do
      expect(book.save).to be(true)

      get :all
      expect(assigns(:books)).to eq([book])
    end
  end

  describe "GET #search" do
      it "assigns all found books as @books" do
      pending "works only in postgres, these tests runs into SQLite"
      expect(book.save).to be(true)

      get :search, :params => {keyword: 'fir'}
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

  describe "GET #tasks" do
    it "displays the tasks of a given book" do
      tasks = []
      tasks << Task.create(title: "task 1", content: "tast 1", user: user, book: book, category: category)
      tasks << Task.create(title: "task 2", content: "tast 2", user: user, book: book, category: category)


      @token = AuthenticateUser.call(user.email, user.password)
      request.headers["Authorization"] = @token.result

      get :tasks, params: {id: book.id}

      expect(
        assigns(:tasks)
      ).to eq(tasks)
    end
  end

  describe "GET #full_detail" do
    it "displays the book with it's tasks and the categories of the tasks" do
      Task.destroy_all

      tasks = []
      tasks << Task.create(title: "task 1", content: "tast 1", user: user, book: book, category: category)
      tasks << Task.create(title: "task 2", content: "tast 2", user: user, book: book, category: category)

      get :full_detail, params: {id: book.id}

      expect(assigns(:book)).to eq(book)
      expect(assigns(:tasks)).to eq(tasks)
      expect(assigns(:categories)).to eq([category])
    end
  end

  describe "GET #inspirations" do
    it "displays a inspiration of a book" do
      book_one = Book.create(title: "oiiiiii", user: user)
      book_two = Book.create(title: "alooooo", user: user)
      inspiration = Inspiration.create(primary_id: book_one.id, inspirational_id: book_two.id)
      expect(inspiration.save).to be(true)

      @token = AuthenticateUser.call(user.email, user.password)
      request.headers["Authorization"] = @token.result

      get :inspirations, :params => {id: book_one.id}
      expect(assigns(:inspirations)).to include(inspiration)
    end

    it "displays all inspirations of a book" do
      book_one = Book.create(title: "oiiiiii", user: user)
      book_two = Book.create(title: "alooooo", user: user)
      book_three = Book.create(title: "alooo333o", user: user)
      inspirations = []
      inspirations << Inspiration.create(primary_id: book_one.id, inspirational_id: book_two.id)
      inspirations << Inspiration.create(primary_id: book_one.id, inspirational_id: book_three.id)

      @token = AuthenticateUser.call(user.email, user.password)
      request.headers["Authorization"] = @token.result

      get :inspirations, :params => {id: book_one.id}
      expect(assigns(:inspirations)).to eq(inspirations)
    end
  end

end
