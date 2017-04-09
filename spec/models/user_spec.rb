require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
    @user = FactoryGirl.create :user
  end

  it "Saves a user with valid attributes" do
    expect(@user.save).to be(true)
  end

  describe "Name validations" do

    it "Won't save a user without a name" do
      @user.name = ""
      expect(@user.save).not_to be(true)
      expect(@user.errors[:name]).to include("can't be blank")
      @user.name = "Valid Name"
      expect(@user.save).to be(true)
    end

    it "Won't save a user with invalid name length" do
      @user.name = "Test"
      expect(@user.save).not_to be(true)
      expect(@user.errors[:name]).to include("is too short (minimum is 5 characters)")

      @user.name = "a"*81
      expect(@user.save).not_to be(true)
      expect(@user.errors[:name]).to include("is too long (maximum is 80 characters)")

      @user.name = "Valid Name"
      expect(@user.save).to be(true)
    end

  end

  describe "Email validations" do
    it "Won't save a user without an email" do
      @user.email = ""
      @user.email_confirmation = ""
      expect(@user.save).not_to be(true)
      expect(@user.errors[:email]).to include("can't be blank")

      @user.email = "email@email.com"
      @user.email_confirmation = "email@email.com"
      expect(@user.save).to be(true)
    end

    it "Won't save a user with an invalid email" do
      @user.email = "email.com"
      @user.email_confirmation = "email.com"
      expect(@user.save).not_to be(true)
      expect(@user.errors[:email]).to include("is invalid")

      @user.email = "email@email.com"
      @user.email_confirmation = "email@email.com"
      expect(@user.save).to be(true)
    end

    it "Won't save a user without email confirmation" do
      @user.email = "email@email.com"
      @user.email_confirmation = ""
      expect(@user.save).not_to be(true)
      expect(@user.errors[:email_confirmation]).to include("can't be blank")

      @user.email = "email@email.com"
      @user.email_confirmation = "email@email.com"
      expect(@user.save).to be(true)
    end

    it "Won't save a user with invalid email confirmation" do
      @user.email = "email@email.com"
      @user.email_confirmation = "email.com"
      expect(@user.save).not_to be(true)
      expect(@user.errors[:email_confirmation]).to include("doesn't match Email")

      @user.email = "email@email.com"
      @user.email_confirmation = "email@email.com"
      expect(@user.save).to be(true)
    end

    it "Won't save a user with an already used email" do
      @user.save!
      @newUser = User.new
      @newUser.name = "Valid Name"
      @newUser.email = @user.email
      @newUser.email_confirmation = @user.email_confirmation
      @newUser.password = "validPass"
      @newUser.password_confirmation = "validPass"

      expect(@newUser.save).not_to be(true)
      expect(@newUser.errors[:email]).to include("has already been taken")

      @newUser.email = "anotheremail@email.com"
      @newUser.email_confirmation = "anotheremail@email.com"

      expect(@newUser.save).to be(true)
    end

  end

  describe "Password validations" do

    it "Won't save a user without a password" do
      @newUser = User.new
      @newUser.name = @user.name
      @newUser.email = @user.email
      @newUser.email_confirmation = @user.email_confirmation
      @newUser.password = ""
      @newUser.password_confirmation = ""
      expect(@newUser.save).not_to be(true)
      expect(@newUser.errors[:password]).to include("can't be blank")

      @newUser.password = "validPassword"
      @newUser.password_confirmation = "validPassword"
      expect(@newUser.save).to be(true)
    end

    it "Won't save a user with an invalid password confirmation" do
      @user.password = "validPassword"
      @user.password_confirmation = ""
      expect(@user.save).not_to be(true)
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")

      @user.password_confirmation = "validPassword"
      expect(@user.save).to be(true)
    end

  end
end
