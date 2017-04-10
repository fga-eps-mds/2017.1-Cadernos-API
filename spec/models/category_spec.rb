require 'rails_helper'

RSpec.describe Category, type: :model do

  before(:each) do
    @category = Category.new
    @category.name = "ValidTest"
    @category.description = "ValidDescription"
  end

  it "Saves a category with valid attributes" do
    expect(@category.save).to be(true)
  end

  describe "Name validations" do

    it "Won't save a category without a name" do
      @category.name = ""
      expect(@category.save).not_to be(true)
      expect(@category.errors[:name]).to include("can't be blank")
      @category.name = "Valid Test"
      expect(@category.save).to be(true)
    end
    it "Won't save a category with invalid name length" do
      @category.name = "test"
      expect(@category.save).not_to be(true)
      expect(@category.errors[:name]).to include("is too short (minimum is 5 characters)")

      @category.name ="a"*31
      expect(@category.save).not_to be(true)
      expect(@category.errors[:name]).to include("is too long (maximum is 30 characters)")

      @category.name = "Valid Test"
      expect(@category.save).to be(true)
    end
    it "Won't save a category with an already used name" do
      @category.save!
      @newCategory = Category.new
      @newCategory.name = @category.name
      @newCategory.description = @category.description
      expect(@newCategory.save).not_to be(true)
      expect(@newCategory.errors[:name]).to include("has already been taken")

      @newCategory.name = "another valid test"
      expect(@newCategory.save).to be(true)
    end
  end

  describe "Description validations" do

    it "Won't save a category without a description" do
      @category.description = ""
      expect(@category.save).not_to be(true)
      expect(@category.errors[:description]).to include("can't be blank")
      @category.description = "Valid Test"
      expect(@category.save).to be(true)
    end
    it "Won't save a category with invalid description length" do
      @category.description = "test"
      expect(@category.save).not_to be(true)
      expect(@category.errors[:description]).to include("is too short (minimum is 5 characters)")

      @category.description ="a"*201
      expect(@category.save).not_to be(true)
      expect(@category.errors[:description]).to include("is too long (maximum is 200 characters)")

      @category.description = "Valid Test"
      expect(@category.save).to be(true)
    end
  end



end
