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

  describe ".started_on" do
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

  describe ".ended_on" do
    correct_month = Job.devs_ended_this_month(2001, 03)

    it 'returns dates within the month' do
     correct_month.should be_equal 2
    end

    incorrect_month = Job.devs_ended_this_month(2001, 04)
    it 'not returns dates out of the month' do
      incorrect_month.should be_equal 0
    end
  end


end
