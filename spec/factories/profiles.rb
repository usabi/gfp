# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    association :teacher
    association :institute
    association :trainercycle
    association :matter
    association :group
  end
end
