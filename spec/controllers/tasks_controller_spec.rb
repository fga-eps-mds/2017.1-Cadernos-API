require 'rails_helper'


RSpec.describe TasksController, type: :controller do

  let(:task) {
    create :task
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
    it "assigns all tasks as @tasks" do
      @token = AuthenticateUser.call(task.book.user.email, task.book.user.password)
      request.headers["Authorization"] = @token.result

      get :index, params: {}, session: valid_session
      expect(assigns(:tasks)).to eq([task])
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
  describe "DELETE #destroy" do
    it "destroys the requested @tasks" do
      expect(task.save).to be(true)

      @token = AuthenticateUser.call(book.user.email, book.user.password)
      request.headers["Authorization"] = @token.result

      expect {
        delete :destroy, params: {id: task.id}
      }.to change(Task, :count).by(-1)
      expect(Task.find_by_id(task.id)).to be(nil)
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

      it "updates the requested @task" do
        task = FactoryGirl.create :task
        @token = AuthenticateUser.call(book.user.email, book.user.password)
        request.headers["Authorization"] = @token.result
        put :update, params: {id: task.id, task: new_attributes}, session: valid_session
        task.reload
        expect(task.title).to eq(new_attributes[:title])
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
      @token = AuthenticateUser.call(task.book.user.email, task.book.user.password)
      request.headers["Authorization"] = @token.result

      expect {
        delete :destroy, params: {id: task.id}
      }.to change(Task, :count).by(-1)
      expect(Task.find_by_id(task.id)).to be(nil)
    end
  end
end
