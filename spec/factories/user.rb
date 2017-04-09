# This will guess the User class
FactoryGirl.define do
  factory :user do
    name  "ValidName"
    email  "validEmail@mail.com"
    email_confirmation  "validEmail@mail.com"
    password  "validpassword"
    password_confirmation  "validpassword"
  end

  factory :update_user, class: User do
    name  "newValid Name"
    email  "newValidEmail@mail.com"
    email_confirmation  "newValidEmail@mail.com"
    password  "validpassword"
    password_confirmation  "validpassword"
  end
end
