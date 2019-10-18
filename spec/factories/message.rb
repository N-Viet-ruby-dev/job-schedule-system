# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    body { Faker::Lorem.sentence }
    association :user, factory: :user
    association :chatroom, factory: :chatroom
  end
end
