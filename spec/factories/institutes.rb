# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :institute do
    name          { Faker::Name.first_name }
    institut_code { Faker::Code.isbn }
  end
end

