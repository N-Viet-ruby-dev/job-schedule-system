# frozen_string_literal: true

FactoryBot.define do
  factory :chatroom do
    name { Faker::Name.name }
  end
end
