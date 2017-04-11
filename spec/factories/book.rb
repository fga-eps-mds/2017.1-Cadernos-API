# This will guess the User class
FactoryGirl.define do
  factory :book do
    title "Valid Title"
    association :user
  end
end
