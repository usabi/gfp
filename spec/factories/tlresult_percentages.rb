# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tlresult_percentage do
    association :tlresult
    association :profile
  end
end
