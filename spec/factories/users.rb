# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { Faker::Name.name }
    email { Faker::Internet.email }
    password { "111111" }
    password_confirmation { "111111" }
  end

  factory :invalid_users, parent: :user do
    username { nil }
    email { nil }
    password { "" }
    password_confirmation { "" }
  end
end

FactoryBot.define do
  factory :invalid_user, class: User do
    username { "CuongTanPhu" }
    email { "lqcuong.qt@gmail.com" }
    password { "111111" }
    password_confirmation { "111111" }
  end
end
