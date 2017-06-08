require 'rails_helper'

RSpec.describe InspirationsController, type: :controller do
    let(:user){
        create :user
    }

    let(:book){
        create :book, title: 'testBook', user: user
    }
    let(:other_book){
        create :book, title: 'otherBook', user: user
    }

    let(:valid_attributes) {
        {
            primary_id: book.id, inspirational_id: other_book.id
        }
    }
    let(:inspiration){
        create :inspiration, primary_id: book.id, inspirational_id: other_book.id, primary_title: book.title, inspirational_title: other_book.title
    }

    describe "GET #index" do
        it "assigns all inspirations as @inspirations" do
            expect(inspiration.save).to be(true)

            @token = AuthenticateUser.call(user.email, user.password)
            request.headers["Authorization"] = @token.result
            
            get :index
            expect(assigns(:inspirations)).to eq([inspiration])
        end
    end
    
    describe "GET #show" do
        it "assigns inspiration as @inspiration" do
            expect(inspiration.save).to be(true)

            @token = AuthenticateUser.call(user.email, user.password)
            request.headers["Authorization"] = @token.result

            get :show, :params => {id: 1}
            expect(assigns(:inspiration)).to eq(inspiration)
        end  
    end

    describe "POST #create" do
        
        it "creates a valid inspiration" do
            @token = AuthenticateUser.call(user.email, user.password)
            request.headers["Authorization"] = @token.result

            expect {
                post :create, params: {inspiration: {primary_id: book.id, inspirational_id: other_book.id}}
                }.to change(Inspiration, :count).by(1)           
        end
        
        it "won't create an inspiration with the same book in primary and inspirational ids" do

            @token = AuthenticateUser.call(user.email, user.password)
            request.headers["Authorization"] = @token.result
            
            expect {
            post :create, params: {inspiration: {primary_id: book.id, inspirational_id: book.id}}
            }.to change(Inspiration, :count).by(0)
        end
    end

end