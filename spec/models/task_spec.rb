# frozen_string_literal: true

require "rails_helper"

RSpec.describe Task, type: :model do
  let(:task) { FactoryBot.create(:task) }

  describe "associations" do
    it { expect(task).to belong_to(:user) }
    it { expect(task).to have_many(:reports) }
  end

  describe "Validations" do
    it { expect(task).to validate_presence_of(:title) }
    it { expect(task).to validate_presence_of(:start) }
    it { expect(task).to validate_presence_of(:end) }
    it { expect(task).to validate_presence_of(:color) }

    it "is a valid within valid attributes" do
      expect(task).to be_valid
    end

    it "is not a valid without title" do
      task.title = nil
      expect(task).to_not be_valid
    end

    it "is not a valid without start" do
      task.start = nil
      expect(task).to_not be_valid
    end

    it "is not a valid without end" do
      task.end = nil
      expect(task).to_not be_valid
    end

    it "is not a valid without color" do
      task.color = nil
      expect(task).to_not be_valid
    end
  end

  describe "instance method" do

    it "all day task respond_to" do
      expect(task).to respond_to(:all_day_task?)
    end

    it "all day task true" do
      expect(task.all_day_task?).to eq true
    end

    it "all day task false" do
      expect(task.all_day_task?).to_not eq false
    end
  end

  describe "Scope" do
    it "task of month" do
      start_date = Date.current.beginning_of_month
      end_date = Date.current.end_of_month
      expect(Task.tasks_of_months(start_date, end_date)).to eq Task.where(start: start_date..end_date)
    end
  end

  describe "status" do
    it "task open or done" do
      expect(task).to define_enum_for(:status).with_values(
        open: 0,
        done: 1
      )
    end
  end
end
