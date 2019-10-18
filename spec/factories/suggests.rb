# frozen_string_literal: true

FactoryBot.define do
  factory :suggest do
    association :user, factory: :user
    content { "Xin off" }
    status { 0 }
  end
end
