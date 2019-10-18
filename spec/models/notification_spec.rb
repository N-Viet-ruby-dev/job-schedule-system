# frozen_string_literal: true

require "rails_helper"

RSpec.describe Notification, type: :model do
  let(:notification) { FactoryBot.create(:notification) }
  describe "associations" do
    it { expect(notification).to belong_to(:user) }
    it { expect(notification).to belong_to(:suggest) }
  end

  describe "Enum" do
    it "Status waiting, approved, rejected" do
      expect(notification).to define_enum_for(:status).with_values(
        not_seen: 0,
        seen: 1
      )
    end
  end

  describe "Scope" do
    it "order by status" do
      expect(Notification.by_status.to_sql)
        .to eq "SELECT `notifications`.* FROM `notifications` ORDER BY `notifications`.`status` ASC"
    end
    it "newest notifications" do
      expect(Notification.newest.to_sql)
        .to eq "SELECT `notifications`.* FROM `notifications` ORDER BY `notifications`.`created_at` DESC"
    end
  end
end
