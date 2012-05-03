# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :plan do
    stripe_id "MyString"
    amount "9.99"
    name "MyString"
    interval "MyString"
  end
end
