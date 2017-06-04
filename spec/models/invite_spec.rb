require 'rails_helper'

RSpec.describe Invite, type: :model do
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

    @invite = Invite.new
  end

  describe "envolved users validations" do
    it "won't save without a recipient" do
      @invite.sender = @user
      @invite.book = @book

      expect(@invite.save).to be(false)

      @invite.recipient = @user_numbertwo
      expect(@invite.save).to be(true)
    end

    it "won't save without a sender" do
      @invite.recipient = @user_numbertwo
      @invite.book = @book

      expect(@invite.save).to be(false)

      @invite.sender = @user
      expect(@invite.save).to be(true)
    end

    it "won't save with same user as recipient and sender" do
      @invite.recipient = @user
      @invite.sender = @user
      @invite.book = @book

      expect(@invite.save).to be(false)

      @invite.recipient = @user_numbertwo
      expect(@invite.save).to be(true)
    end
  end

  describe "book presence validations" do
    it "won't save without valid book" do
      @invite.recipient = @user_numbertwo
      @invite.sender = @user

      expect(@invite.save).to be(false)

      @invite.book = @book
      expect(@invite.save).to be(true)
    end
  end
end
