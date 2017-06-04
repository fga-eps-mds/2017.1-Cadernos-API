require 'rails_helper'

RSpec.describe Membership, type: :model do
  before(:each) do
    @user = User.new
    @user.name = "Valid Name"
    @user.email = "nice@email.com"
    @user.email_confirmation = "nice@email.com"
    @user.password = "nicepassword"
    @user.password_confirmation = "nicepassword"
    @user.save

    @user_numbertwo = User.new
    @user_numbertwo.name = "Valid Name Two"
    @user_numbertwo.email = "nice2@email.com"
    @user_numbertwo.email_confirmation = "nice2@email.com"
    @user_numbertwo.password = "nicepassword2"
    @user_numbertwo.password_confirmation = "nicepassword2"
    @user_numbertwo.save

    @book = @user.books.new
    @book.title = "titulo teste"
    @book.save

    @membership = Membership.new
  end

  describe "member validations" do
    it "won't save without a member" do
      @membership.book = @book

      expect(@membership.save).to be(false)

      @membership.member = @user_numbertwo
      expect(@membership.save).to be(true)
    end
  end

  describe "book validations" do
    it "won't save without a book" do
      @membership.member = @user_numbertwo

      expect(@membership.save).to be(false)

      @membership.book = @book
      expect(@membership.save).to be(true)
    end
  end
end
