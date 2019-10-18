# frozen_string_literal: true

require "rails_helper"

RSpec.describe Message, type: :model do
  describe "Associations" do
    it { should belong_to(:chatroom) }
    it { should belong_to(:user) }
  end

  describe "Validations" do
    subject { FactoryBot.create(:message) }

    it { should validate_presence_of(:body) }
  end

  describe "#delegate" do
    subject { FactoryBot.create(:message) }

    after { subject.username }

    it "delegates to user name" do
      expect(subject.user).to receive(:username)
    end
  end
end
