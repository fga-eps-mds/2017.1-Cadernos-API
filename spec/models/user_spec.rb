require 'rails_helper'
require Rails.root.join('spec', 'test_helpers', 'encode_image.rb')

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
      @newUser.email = "sometest@email.com"
      @newUser.email_confirmation = "sometest@email.com"
      @newUser.password = ""
      @newUser.password_confirmation = ""
      expect(@newUser.save).not_to be(true)
      expect(@newUser.errors[:password]).to include("can't be blank")

      @newUser.password = "validPassword"
      @newUser.password_confirmation = "validPassword"
      @newUser.valid?
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

  describe "user avatar" do
    it "gives a missing image as default when there is no cover setted to the book" do
      expect(@user.avatar.url).to eq("/images/medium/default-avatar.jpg")
    end

    it "gives the original avatar image" do
      expect(@user.avatar_original).to eq("/images/original/default-avatar.jpg")
    end

    it "gives the medium avatar image" do
      expect(@user.avatar_medium).to eq("/images/medium/default-avatar.jpg")
    end

    it "gives the thumb avatar image" do
      expect(@user.avatar_thumb).to eq("/images/thumb/default-avatar.jpg")
    end

    it "decode and generates medium and thumb sizes of a given base64 encoded image" do
      expect(@user.save).to be(true)

      base64_image = encode_image_to_base64(test_image, "jpg")

      expect(@user.avatar.url).to eq("/images/medium/default-avatar.jpg")
      @user.email_confirmation = @user.email
      @user.avatar_base = base64_image

      expect(@user.save).to be(true)
      expect(@user.avatar.url).not_to eq("/images/medium/default-avatar.jpg")
    end
  end
end
