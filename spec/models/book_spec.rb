require 'rails_helper'
require Rails.root.join('spec', 'test_helpers', 'encode_image.rb')

RSpec.describe Book, type: :model do

	before(:each) do
		@user = User.create :name => "usuario", :password => "123456"
	end

	describe "user_id validations" do
		it "shouldnt save if theres no user" do
			@book = Book.new :title => "ValidTitle"
			expect(@book.save).to be(false)
			expect(@book.errors[:user]).to include("must exist")
			@book.user = @user
			expect(@book.save).to be(true)
		end
	end

  before(:each) do
   		@user = FactoryGirl.create :user
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

		it "shouldnt save if title has already been taken" do
      @book.title = "New Book Name"
      @book.user = @user
			@book.save

			@book2 = Book.new
			@book2.user = @user
			@book2.title = @book.title

			expect(@book2.save).to be(false)
			expect(@book2.errors[:title]).to include("has already been taken")

			@book2.title = "Another different title"
			expect(@book2.save).to be(true)
    end
  end

  describe "book cover" do
    it "gives a missing image as default when there is no cover setted to the book" do
      expect(@book.cover.url).to eq("/images/medium/missing.jpg")
    end

    it "gives the original cover image" do
      expect(@book.cover_original).to eq("/images/original/missing.jpg")
    end

    it "gives the medium cover image" do
      expect(@book.cover_medium).to eq("/images/medium/missing.jpg")
    end

    it "gives the thumb cover image" do
      expect(@book.cover_thumb).to eq("/images/thumb/missing.jpg")
    end

    it "decode and generates medium and thumb sizes of a given base64 encoded image" do
      base64_image = encode_image_to_base64(test_image, "jpg")

      expect(@book.cover.url).to eq("/images/medium/missing.jpg")
      @book.title = "book with cover"
      @book.user = @user
      @book.cover_base = base64_image

      expect(@book.save).to be(true)
      expect(@book.cover.url).not_to eq("/images/medium/missing.jpg")
    end
  end
end
