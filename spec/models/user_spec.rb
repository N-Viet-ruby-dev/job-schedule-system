# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  describe "associations" do
    it { expect(user).to have_many(:tasks).dependent :destroy }
    it { expect(user).to have_many(:recurring_tasks).dependent :destroy }
    it { expect(user).to have_many(:reports).dependent :destroy }
    it { expect(user).to have_many(:workings).dependent :destroy }
    it { expect(user).to have_many(:chatroom_users) }
    it { expect(user).to have_many(:chatrooms) }
    it { expect(user).to have_many(:messages) }
    it { expect(user).to have_many(:suggests).dependent :destroy }
    it { expect(user).to have_many(:notifications).dependent :destroy }
  end

  describe "Validations" do
    it { expect(user).to validate_presence_of(:email) }
    it { expect(user).to validate_uniqueness_of(:email).case_insensitive }
    it { expect(user).to validate_presence_of(:password) }
    it { expect(user).to validate_presence_of(:password_confirmation) }

    it "is a valid within valid attributes" do
      expect(user).to be_valid
    end

    it "is not a valid without email" do
      user.email = nil
      expect(user).to_not be_valid
    end

    it "is not a valid with wrong email format" do
      user.email = "wrong_email_format"
      expect(user).to_not be_valid
    end

    it "is not a valid with used email" do
      user_copy = FactoryBot.build(:user)
      user_copy.email = user.email
      expect(user_copy).to_not be_valid
    end

    it "when password is too short" do
      user.password = "11111"
      user.valid?
      expect(user.errors.messages[:password].first).to eq(
        I18n.t("activerecord.errors.models.user.attributes.password.too_short",
        count: Settings.user.min_password))
    end

    it "when password is too long" do
      user.password = "1111111111111111"
      user.valid?
      expect(user.errors.messages[:password].first).to eq(
        I18n.t("activerecord.errors.models.user.attributes.password.too_long",
        count: Settings.user.max_password))
    end

    it "is not a valid with different password confirnmation" do
      user.password_confirmation = "password_confirmation"
      expect(user).to_not be_valid
    end
  end

  describe "Enum" do
    it "are user or admin" do
      expect(user).to define_enum_for(:role).with_values(
        user: 0,
        leader: 1,
        admin: 2
      )
    end
    it "permission close open" do
      expect(user).to define_enum_for(:permission).with_values(
        close: 0,
        open: 1
      )
    end
  end

  describe "Scope" do
    it "order user newest" do
      expect(User.newest.to_sql)
        .to eq "SELECT `users`.* FROM `users` ORDER BY `users`.`created_at` DESC"
    end

    it "search user" do
      expect(User.search_user("example").to_sql)
        .to eq "SELECT DISTINCT `users`.* FROM `users` WHERE (lower(users.username) LIKE '%example%')"
    end
  end
end
