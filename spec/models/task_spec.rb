require 'rails_helper'

RSpec.describe Task, type: :model do
  before(:each) do
    @user = User.new
    @user.name = "Valid Name"
    @user.email = "nice@email.com"
    @user.email_confirmation = "nice@email.com"
    @user.password = "nicepassword"
    @user.password_confirmation = "nicepassword"
    @user.save
    @book = @user.books.new
    @book.title = "titulo teste"
    @book.save
    @category = Category.new
    @category.name = "Criação"
    @category.description = "Espaço reservado para criação"
    @task = Task.new
  end

  describe "book_id validations" do
    it "shouldnt save if theres no book or category correlated" do
      @task.title = "nome de tarefa"
      @task.content = "qualquer coisa aqui serve"
      expect(@task.save).to be(false)
      expect(@task.errors[:book]).to include("must exist")
      expect(@task.errors[:user]).to include("must exist")
      expect(@task.errors[:category]).to include("must exist")
      @task.book = @book
      @task.user = @user
      @task.category = @category
      expect(@task.save).to be(true)
    end
  end

  describe "task title validations" do
    it "shouldnt save if theres no task title" do
      @task.book = @book
      @task.user = @user
      @task.category = @category
      @task.content = "qualquer coisa aqui serve"
      @task.title = nil
      expect(@task.save).to be(false)
      expect(@task.errors[:title]).to include("can't be blank")
      @task.title = "titulo ok"
      expect(@task.save).to be(true)
    end

    it "shouldnt save if task title is too short or too long" do
      @task.book = @book
      @task.user = @user
      @task.category = @category
      @task.content = "qualquer coisa aqui serve"
      @task.title = "abc"
      expect(@task.save).to be(false)
      expect(@task.errors[:title]).to include("is too short (minimum is 5 characters)")
      @task.title = "a" * 100
      expect(@task.save).to be(false)
      expect(@task.errors[:title]).to include("is too long (maximum is 80 characters)")
      @task.title = "a" * 40
      expect(@task.save).to be(true)
    end
  end

  describe "task content validations" do
    it "shouldnt save if theres no content" do
      @task.book = @book
      @task.user = @user
      @task.category = @category
      @task.title = "titulo bem valido"
      @task.content = nil
      expect(@task.save).to be(false)
      expect(@task.errors[:content]).to include("can't be blank")
      @task.content = "ao menos algum conteudo"
      expect(@task.save).to be(true)
    end
  end

end
