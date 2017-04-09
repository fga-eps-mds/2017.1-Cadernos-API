require 'rails_helper'

RSpec.describe BooksController, type: :controller do

  before(:all) do
    @user = User.create! :name => "ValidName",
                         :email => "validEmail@mail.com",
                         :email_confirmation => "validEmail@mail.com",
                         :password => "validpassword",
                         :password_confirmation => "validpassword"
  end
  
  before(:each) do
    @book = Book.new :title => "first", :user => @user
  end
  
  describe "GET #index" do
    it "assigns all books as @books" do
      expect(@book.save).to be(true)
      
      get :index
      expect(assigns(:books)).to eq([@book])
    end
  end
  
  describe "GET #show" do
    it "assings book as @book" do
      expect(@book.save).to be(true)
      get :show, :params => {id: @book.id}
      expect(assigns(:book)).to eq(@book)
    end
  end
end
