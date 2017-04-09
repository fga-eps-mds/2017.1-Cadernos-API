require 'rails_helper'

RSpec.describe Book, type: :model do

  before(:each) do
   		@user = User.create :name => "usuario",
                          :password => "validpassword",
                          :email => "valid@email.com",
                          :email_confirmation => "valid@email.com"

      @book = Book.new

  end

 	describe "user_id validations" do

    it "shouldnt save if theres no user" do
      @book.title = "validtitle"
 			expect(@book.save).to be(false)
 			expect(@book.errors[:user]).to include("must exist")
 			@book.user = @user
 			expect(@book.save).to be(true)
 		end

 	end

  describe "book title validations" do

    it "shouldnt save if theres no title" do
      @book.user = @user
      expect(@book.save).to be(false)
      expect(@book.errors[:title]).to include("can't be blank")
      @book.title = "validtitle"
      expect(@book.save).to be(true)
    end

    it "shouldnt save if title is too short or too long" do
      @book.title = "abc"
      @book.user = @user
      expect(@book.save).to be(false)
      expect(@book.errors[:title]).to include("is too short (minimum is 5 characters)")
      @book.title = "abc"* 80
      expect(@book.save).to be(false)
      expect(@book.errors[:title]).to include("is too long (maximum is 70 characters)")
      @book.title = "valid book title"
      expect(@book.save).to be(true)
    end

  end
end
