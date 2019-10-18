# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "Associations" do
    it { should have_many(:tasks) }
    it { should have_many(:recurring_tasks) }
    it { should have_many(:reports) }
    it { should have_many(:workings) }
    it { should have_many(:chatroom_users) }
    it { should have_many(:chatrooms).through(:chatroom_users) }
    it { should have_many(:messages) }
    it { should have_many(:suggests) }
    it { should have_many(:notifications) }
  end

  describe "Validations" do
    subject { FactoryBot.create(:user) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
  end

  describe "enum" do
    it "role of users" do
      should define_enum_for(:role).with(%i[user leader admin])
    end
    it "permission close or open" do
      should define_enum_for(:permission).with(%i[close open])
    end
  end

  describe "scope" do
    it "will return the list of user order by create time" do
      expect(User.newest.to_sql).to eq "SELECT `users`.* FROM `users` ORDER BY `users`.`created_at` DESC"
    end
  end

  describe "#method" do
    it "return a user with username like the key_search" do
      expect(User.search_user("example").to_sql).to eq "SELECT DISTINCT `users`.* FROM `users` WHERE (lower(users.username) LIKE '%example%')"
    end
  end

  describe "#from_omniauth" do
    let(:auth_hash) do
      OmniAuth::AuthHash.new(
        provider: "slack",
        uid: "1234",
        info: {
          email: "user@example.com",
          name: "Justin Bieber"
        }
      )
    end

    subject { User.from_omniauth(auth_hash) }

    it "will result the slack account" do
      expect(subject.email).to eq("user@example.com")
    end
  end
end
