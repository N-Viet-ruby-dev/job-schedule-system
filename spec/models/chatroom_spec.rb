# frozen_string_literal: true

require "rails_helper"

RSpec.describe Chatroom, type: :model do
  describe "Associations" do
    it { should have_many(:chatroom_users) }
    it { should have_many(:users).through(:chatroom_users) }
    it { should have_many(:messages) }
  end

  describe "Validations" do
    subject { FactoryBot.create(:chatroom) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_length_of(:name), maximum: 50 }
  end

  describe "Scope" do
    it "will show the chatroom with direct_message return false" do
      expect(Chatroom.public_channels.to_sql).to eq "SELECT `chatrooms`.* FROM `chatrooms` WHERE `chatrooms`.`direct_message` = FALSE"
    end

    it "will show the chatroom with direct_message return true" do
      expect(Chatroom.direct_messages.to_sql).to eq "SELECT `chatrooms`.* FROM `chatrooms` WHERE `chatrooms`.`direct_message` = TRUE"
    end
  end

  describe "#search" do
    it "return a chatroom with name like the key_search" do
      expect(Chatroom.search("example").to_sql).to eq "SELECT DISTINCT `chatrooms`.* FROM `chatrooms` WHERE (lower(chatrooms.name) LIKE '%example%')"
    end
  end
end
