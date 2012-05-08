# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription do
    start_date "2012-05-03"
    end_date "2012-05-03"
    status "MyString"
  end
end
