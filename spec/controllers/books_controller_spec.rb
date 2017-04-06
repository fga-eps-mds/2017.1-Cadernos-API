require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe "GET /books" do
  
  
  # let(:valid_attributes) {
  #   {:name => "ValidName",
  #   :email => "validEmail@mail.com",
  #   :password => "validpassword",
  #   :password_confirmation => "validpassword",
  #   :title => "ValidTitle",
  #   :user_id => 2,}
  # }

  it 'should render the show template' do
    book = Book.create
    get :index
    expect(assigns(:books)).to eq([book])
  end
  # describe "GET #index" do
  #   it "assigns all books as @books" do
  #     user = User.create! valid_attributes
  #     book = Book.create! valid_attributes
  #     get :index, params: {}
  #     expect(assigns(:books)).to eq([book])
  #   end
  end
end
