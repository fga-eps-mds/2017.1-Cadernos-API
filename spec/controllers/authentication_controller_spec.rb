require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do

  describe "POST #authenticate" do
    it "verify user login" do
      @user = User.create! name: 'teste user',
                        email: 'test-user@mail.com',
                        email_confirmation: 'test-user@mail.com',
                        password: 'test-user'

      post :authenticate, params: {email: "test-user@mail.com", password: "test-user"}

      body = JSON.parse response.body
      expect(body["user"]["id"]).to eq(@user.id)
    end
  end

end
