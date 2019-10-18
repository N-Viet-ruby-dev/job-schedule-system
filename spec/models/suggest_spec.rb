# frozen_string_literal: true

require "rails_helper"

RSpec.describe Suggest, type: :model do
  let(:suggest) { FactoryBot.create(:suggest) }

  describe "associations" do
    it { expect(suggest).to belong_to(:user) }
    it { expect(suggest).to have_many(:notifications) }
  end

  describe "Validations" do
    it { expect(suggest).to validate_presence_of(:content) }

    it "is a valid within valid attributes" do
      expect(suggest).to be_valid
    end

    it "is not a valid without content" do
      suggest.content = nil
      expect(suggest).to_not be_valid
    end
  end

  describe "Enum" do
    it "Status waiting, approved, rejected" do
      should define_enum_for(:status).with_values(
        waiting: 0,
        approved: 1,
        rejected: 2
      )
    end
  end

  describe "Scope" do
    it "order user newest" do
      expect(Suggest.newest.to_sql)
        .to eq "SELECT `suggests`.* FROM `suggests` ORDER BY `suggests`.`created_at` DESC"
    end
  end
end
