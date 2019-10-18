# frozen_string_literal: true

require "rails_helper"

RSpec.describe RecurringTask, type: :model do
  let(:recurring_task) { FactoryBot.create(:recurring_task) }
  describe "associations" do
    it { expect(recurring_task).to belong_to(:user) }
  end

  describe "Validations" do
    it { expect(recurring_task).to validate_presence_of(:title) }
    it { expect(recurring_task).to validate_presence_of(:anchor) }
    it { expect(recurring_task).to validate_presence_of(:frequency) }
    it { expect(recurring_task).to validate_presence_of(:color) }

    it "is a valid within valid attributes" do
      expect(recurring_task).to be_valid
    end

    it "is not a valid without title" do
      recurring_task.title = nil
      expect(recurring_task).to_not be_valid
    end

    it "is not a valid without anchor" do
      recurring_task.anchor = nil
      expect(recurring_task).to_not be_valid
    end

    it "is not a valid without frequency" do
      recurring_task.frequency = nil
      expect(recurring_task).to_not be_valid
    end

    it "is not a valid without color" do
      recurring_task.color = nil
      expect(recurring_task).to_not be_valid
    end
  end

  describe "Enum" do
    it "recurring weekly, biweekly, monthly, annually" do
      expect(recurring_task).to define_enum_for(:frequency).with_values(
        weekly: 0,
        biweekly: 1,
        monthly: 2,
        annually: 3
      )
    end
  end

  describe "instance method" do
    it "all day task true" do
      start_date = Date.current.beginning_of_month
      end_date = Date.current.end_of_month
      start_frequency = start_date ? start_date.to_date : Date.today.last_year
      end_frequency = end_date ? end_date.to_date : Date.today.next_year
      expect(recurring_task.tasks(start_date, end_date))
        .to eq recurring_task.schedule.occurrences_between(start_frequency, end_frequency)
    end
  end
end
