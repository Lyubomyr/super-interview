require 'spec_helper'

describe Job do
  subject { described_class.create(developer: 'John Doe', started_on: started_on) }
  let(:started_on) { Date.today }

  it { should be_valid }
  its(:developer) { should == 'John Doe' }

  context "start date is not set" do
    let(:started_on) { nil }
    it { should_not be_valid }
  end

  describe ".devs_started_this_month" do
    Job.create(started_on: Date.new(2001, 02, 01), ended_on: Date.new(2001, 03, 01))
    Job.create(started_on: Date.new(2001, 02, 02), ended_on: Date.new(2001, 03, 02))

    correct_month = Job.devs_started_this_month(2001, 02)
    it 'returns dates within the month' do
      correct_month.should be_equal 2
    end

    incorrect_month = Job.devs_started_this_month(2001, 03)
    it 'not returns dates out of the month' do
      incorrect_month.should be_equal 0
    end
  end

  describe ".devs_ended_this_month" do
    correct_month = Job.devs_ended_this_month(2001, 03)

    it 'returns dates within the month' do
     correct_month.should be_equal 2
    end

    incorrect_month = Job.devs_ended_this_month(2001, 04)
    it 'not returns dates out of the month' do
      incorrect_month.should be_equal 0
    end
  end

  describe ".update_month_count" do
    date = Date.new(2001, 02, 01)
    Job.create(started_on: date)
    count_in_2001_02 = DevsInEachMonth.devs_on_month_end(date)

    it 'update amount of devs in proper month' do
     count_in_2001_02.should be_equal 3
    end
  end

end
