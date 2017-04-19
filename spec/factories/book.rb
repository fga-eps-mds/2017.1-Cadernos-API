# This will guess the Book class
FactoryGirl.define do
  factory :book do
    title "Valid Title"
    association :user
  end
end
