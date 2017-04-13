require 'rails_helper'


RSpec.describe TasksController, type: :controller do

  let(:user) {
    create :user
  }

  let(:book) {
    create :book, title: 'first', user: user
  }

  let(:task) {
    create :task, title: 'first', book:book
  }

  let(:valid_attributes){
    {
    :title => "ValidTitle",
    :book => book,
    :user => user
    }
  }

  let(:valid_session){ {} }

  describe "GET #index" do
    it "assigns all books as @books" do
      expect(task.save).to be(true)

      @token = AuthenticateUser.call(book.user.email, book.user.password)
      request.headers["Authorization"] = @token.result

      get :index
      expect(assigns(:task)).to eq([task])
    end
  end

  describe "GET #show" do
    it "assigns task as @task" do
      expect(task.save).to be(true)

      @token = AuthenticateUser.call(book.user.email, book.user.password)
      request.headers["Authorization"] = @token.result

      get :show, :params => {id_task: task.id, id_book: book.id, id: user.id}
      expect(assigns(:task)).to eq(task)
    end
  end

  describe "POST #create" do
    it "creates a valid task" do

      @token = AuthenticateUser.call(book.user.email, book.user.password)
      request.headers["Authorization"] = @token.result

      expect {
        post :create, params: {task: {title: "NewValidTitle",id_book: book.id, user_id: user.id}}, session: valid_session
      }.to change(Task, :count).by(1)
    end

    it "won't create a task with invalid attributes" do

      @token = AuthenticateUser.call(book.user.email, book.user.password)
      request.headers["Authorization"] = @token.result

      expect {
        post :create, params: {task: {title: "nope",id_book: book.id, user_id: user.id}}, session: valid_session
      }.to change(Task, :count).by(0)
    end
  end
  end
