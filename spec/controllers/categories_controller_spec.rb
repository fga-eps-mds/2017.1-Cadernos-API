require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  let(:category){
    create :category
  }

  let(:user){
    create :user
  }

  let(:valid_attributes) {
    {:name => "ValidName",
    :description => "validDescription"}
  }

  let(:invalid_attributes) {
    {:name => "xxx",
    :description => "xxx"}
  }

  let(:valid_session) { {} }

  describe "GET #index" do

    it "assigns all categories as @categories" do
      expect(category.save).to be(true)
      @token = AuthenticateUser.call(user.email, user.password)
      request.headers["Authorization"] = @token.result
      get :index, params: {}, session: valid_session
      expect(assigns(:categories)).to eq([category])
    end

    it "will paginate category" do
      6.times do |n|
        Category.create! name: "Category #{n}", description: "Some test description"
      end

      get :index, params: {page: 1, per_page: 5}

      expect(Category.count > 5).to eq(true)

      expect(
        assigns(:categories).length
      ).to eq(5)

      get :index, params: {page: 1, per_page: 2}

      expect(
        assigns(:categories).length
      ).to eq(2)
    end
  end

  describe "GET #show" do

    it "assigns the requested category as @category" do
      expect(category.save).to be(true)
      @token = AuthenticateUser.call(user.email, user.password)
      request.headers["Authorization"] = @token.result
      get :show, params: {id: category.to_param}, session: valid_session
      expect(assigns(:category)).to eq(category)
    end

  end

  describe "POST #create" do

    context "with valid params" do

      it "creates a new Category" do
        @token = AuthenticateUser.call(user.email, user.password)
        request.headers["Authorization"] = @token.result
        expect {
          post :create, params: {category: valid_attributes}, session: valid_session
        }.to change(Category, :count).by(1)
      end
    end

    context "with invalid params" do

      it "won't create a category" do
        @token = AuthenticateUser.call(user.email, user.password)
        request.headers["Authorization"] = @token.result
        expect {
          post :create, params: {category: invalid_attributes}, session: valid_session
        }.to change(Category, :count).by(0)
        @token = AuthenticateUser.call(user.email, user.password)
        request.headers["Authorization"] = @token.result
        expect {
          post :create, params: {category: valid_attributes}, session: valid_session
        }.to change(Category, :count).by(1)
      end
    end
  end

  describe "PUT #update" do
    let(:new_attributes) {
      {:name => "newValid Name",
       :description => "newValidDescription"}
    }

    context "with valid params" do

      it "updates the requested category" do
        expect(category.save).to be(true)
        @token = AuthenticateUser.call(user.email, user.password)
        request.headers["Authorization"] = @token.result
        put :update, params: {id: category.id, category: new_attributes}, session: valid_session
        category.reload
        expect(category.name).to eq(new_attributes[:name])
      end
    end

    context "with invalid params" do
      it "won't update the category" do
        expect(category.save).to be(true)
        @token = AuthenticateUser.call(user.email, user.password)
        request.headers["Authorization"] = @token.result
        put :update, params: {id: category.id, category: invalid_attributes}, session: valid_session
        category.reload
        expect(category.name).not_to eq(invalid_attributes[:name])
        request.headers["Authorization"] = @token.result
        put :update, params: {id: category.id, category: new_attributes}, session: valid_session
        category.reload
        expect(category.name).to eq(new_attributes[:name])
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested category" do
      expect(category.save).to be(true)
      @token = AuthenticateUser.call(user.email, user.password)
      request.headers["Authorization"] = @token.result
      expect {
        delete :destroy, params: {id: category.id}, session: valid_session
      }.to change(Category, :count).by(-1)
      expect(Category.find_by_id(category.id)).to be(nil)
    end
  end
end
