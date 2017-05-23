require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:book){
    create :book
  }

  let(:user){
    create :user, email: "novoemailagoravai@cooooooooom.com", email_confirmation: "novoemailagoravai@cooooooooom.com"
  }

  let(:category){
    create :category, name: 'criacao', description: 'criando ousado'
  }

  let(:task) {
    create :task, book: book, user: user, category: category
  }

  let(:valid_attributes){
    {title: "NewValidTitle", content: "ValidContent", book_id: book.id, user_id: user.id, category_id: category.id}
  }

  let(:invalid_attributes){
    {title: "IvT",id_book: book.id, content: "", user_id: user.id}
  }

  let(:valid_session){ {} }

  describe "GET #index" do
    it "assigns all tasks as @tasks" do
      expect(task.save).to be(true)
      @token = AuthenticateUser.call(task.book.user.email, task.book.user.password)
      request.headers["Authorization"] = @token.result
      get :index, params: {}, session: valid_session
      expect(assigns(:tasks)).to eq([task])
    end
  end

  describe "GET #show" do
    it "assigns task as @task" do
      expect(task.save).to be(true)
      @token = AuthenticateUser.call(task.book.user.email, task.book.user.password)
      request.headers["Authorization"] = @token.result
      get :show, :params => {id: task.id}
      expect(assigns(:task)).to eq(task)
    end
  end

  describe "POST #create" do
    it "creates a valid task" do
      @token = AuthenticateUser.call(task.book.user.email, task.book.user.password)
      request.headers["Authorization"] = @token.result
      expect {
        post :create, params: {task: valid_attributes}, session: valid_session
      }.to change(Task, :count).by(1)
    end

    it "won't create a task with invalid attributes" do
      @token = AuthenticateUser.call(task.book.user.email, task.book.user.password)
      request.headers["Authorization"] = @token.result
      expect {
        post :create, params: {task: invalid_attributes}, session: valid_session
      }.to change(Task, :count).by(0)
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested @tasks" do
      expect(task.save).to be(true)
      @token = AuthenticateUser.call(task.book.user.email, task.book.user.password)
      request.headers["Authorization"] = @token.result
      expect {
        delete :destroy, params: {id: task.id}
      }.to change(Task, :count).by(-1)
      expect(Task.find_by_id(task.id)).to be(nil)
    end
  end

  describe "PUT #update" do

    let(:new_attributes) {
      {:title => "newValid Title"}
    }

    context "with valid params" do

      it "updates the requested @task" do
        expect(task.save).to be(true)
        @token = AuthenticateUser.call(task.book.user.email, task.book.user.password)
        request.headers["Authorization"] = @token.result
        put :update, params: {id: task.id, task: new_attributes}, session: valid_session
        task.reload
        expect(task.title).to eq(new_attributes[:title])
      end
    end

    context "with invalid params" do

      let(:invalid_attributes) {
        {:title => "ivT"}
      }

      it "won't update the task" do
        expect(task.save).to be(true)
        @token = AuthenticateUser.call(task.book.user.email, task.book.user.password)
        request.headers["Authorization"] = @token.result
        put :update, params: {id: task.id, task: invalid_attributes}, session: valid_session
        task.reload
        expect(task.title).not_to eq(invalid_attributes[:title])
      end
    end
  end

end
