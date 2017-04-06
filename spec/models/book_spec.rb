require 'rails_helper'

RSpec.describe Book, type: :model do
  	before(:each) do
  		@user = User.create :name => "usuario", :password => "123456"

  	end
	describe "user_id validations" do 
		it "shouldnt save if theres no user" do
			@book = Book.new
			expect(@book.save).to be(false)
			expect(@book.errors[:user]).to include("can't be blank")
			@book.user = @user
			expect(@book.save).to be(true)
		end
	end

end
