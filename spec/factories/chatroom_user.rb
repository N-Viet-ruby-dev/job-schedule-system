# frozen_string_literal: true

FactoryBot.define do
  factory :chatroom_user do
    association :user, factory: :user
    association :chatroom, factory: :chatroom
  end
end