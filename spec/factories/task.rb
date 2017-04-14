# This will guess the Task class
FactoryGirl.define do
  factory :task do
    title "ValidTitle"
    content "Valid Content"
    association :book
    association :category
  end
end
