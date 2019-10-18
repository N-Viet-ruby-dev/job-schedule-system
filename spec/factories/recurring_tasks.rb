# frozen_string_literal: true

FactoryBot.define do
  factory :recurring_task do
    association :user, factory: :user
    title { Faker::Name.name }
    anchor { Date.current }
    frequency { "weekly" }
    color { "color" }
  end
end
