require 'rails_helper'

RSpec.describe Inspiration, type: :model do
  before(:each) do
    @inspiration = Inspiration.new

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

    @book_one = Book.new
    @book_one.title = "oiiiii"
    @book_one.user = @user
    @book_one.save

    @book_two = Book.new
    @book_two.title = "oiiiii de novo"
    @book_two.user = @user_numbertwo
    @book_two.save

    @inspiration.primary = @book_one
    @inspiration.inspirational = @book_two
  end

  describe "valid attributes" do
    it "Saves a inspiration with valid attributes" do
      expect(@inspiration.save).to be(true)
    end

    it "Saves a primary-inspiration and inspiration-primary" do
      expect(@inspiration.save).to be(true)
      @inspiration_two = Inspiration.new
      @inspiration_two.primary = @book_two
      @inspiration_two.inspirational = @book_one
      expect(@inspiration_two.save).to be(true)
    end
  end

  describe "invalid attributes" do
    it "wont save a inspiration that have the same inspiration" do
      @inspiration.primary = @book_one
      @inspiration.inspirational = @book_one
      expect(@inspiration.save).to be(false)
      expect(@inspiration.errors[:primary_id]).to include("primary can't be same as inspirational")
      @inspiration.inspirational = @book_two
      expect(@inspiration.save).to be(true)
    end

    it "wont save a inspiration that already is a inspiration" do
      expect(@inspiration.save).to be(true)
      @inspiration_two = Inspiration.new
      @inspiration_two.primary = @book_one
      @inspiration_two.inspirational = @book_two
      expect(@inspiration_two.save).to be(false)
      expect(@inspiration_two.errors[:primary_id]).to include("has already been taken")
    end

    it "wont save a inspiration without primary or inspirational" do
      @test = Inspiration.new
      expect(@test.save).to be(false)
      expect(@test.errors[:primary]).to include("must exist")
      expect(@test.errors[:primary]).to include("can't be blank")
      expect(@test.errors[:inspirational]).to include("must exist")
      expect(@test.errors[:inspirational]).to include("can't be blank")
      @test.primary = @book_one
      expect(@test.errors[:inspirational]).to include("must exist")
      expect(@test.errors[:inspirational]).to include("can't be blank")
      @test.inspirational = @book_two
      expect(@test.save).to be(true)

    end
  end

end
