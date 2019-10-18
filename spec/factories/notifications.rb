# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    association :user, factory: :user
    association :suggest, factory: :suggest
    status { 0 }
  end
end
