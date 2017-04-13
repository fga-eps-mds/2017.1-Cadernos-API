require 'rails_helper'


Spec.describe Category, type: :model do
  
  before(:each) do
    @category = Category.new
    @category.name = "Valid Name"
    @category.description = "validDescription"
  end
  
  it "Saves a category with valid attributes" do
    expect(@category.save).to be(true)
  end
  
  describe "Category validations" do
    it "Won't save a category without a name" do
      @category.name = ""
      expect(@category.save).not_to be(true)
      expect(@category.errors[:name]).to include("can't be blank")
      
      @category.name = "Valid Name"
      expect(@category.save).to be(true)
    end
    
    it "Won't save a category with invalid name length" do
      @category.name = "Test"
      expect(@category.save).not_to be(true)
      expect(@category.errors[:name]).to include("is too short (minimum is 5 characters)")

      @category.name = "a"*81
      expect(@category.save).not_to be(true)
      expect(@category.errors[:name]).to include("is too long (maximum is 80 characters)")

      @category.name = "Valid Name"
      expect(@category.save).to be(true)
    end
    
  end
  
  describe "Description validations" do
    it "Won't save a category without an description" do
      @category.description = ""
      expect(@category.save).not_to be(true)
      expect(@category.errors[:description]).to include("can't be blank")

      @category.description = "Valid Description"
      expect(@category.save).to be(true)
    end

    it "Won't save a description with invalid name length" do
      @category.description = "Test"
      expect(@category.save).not_to be(true)
      expect(@category.errors[:description]).to include("is too short (minimum is 5 characters)")

      @category.name = "a"*81
      expect(@category.save).not_to be(true)
      expect(@category.errors[:description]).to include("is too long (maximum is 80 characters)")

      @category.description = "validDescription"
      expect(@category.save).to be(true)
    end
  end
    