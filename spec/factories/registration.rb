# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :registration do
    user
    conference
  end
end
