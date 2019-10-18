# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    association :user, factory: :user
    title { Faker::Name.name }
    start { "2019-04-12" }
    self.end { "2019-04-13" }
    color { "color" }
  end
end
