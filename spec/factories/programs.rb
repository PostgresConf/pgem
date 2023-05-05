# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :program do
    schedule_public false
    schedule_fluid false
    conference
  end
end
