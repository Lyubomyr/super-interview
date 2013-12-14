require 'spec_helper'

describe DevsInEachMonth do
  describe ".started_on" do
    Job.create(started_on: Date.new(2001, 02, 01), ended_on: Date.new(2001, 03, 01))
    Job.create(started_on: Date.new(2001, 02, 02), ended_on: Date.new(2001, 03, 02))

    correct_month = Job.devs_started_this_month(2001, 02)
    it 'returns dates within the month' do
      correct_month.should be_equal 2
    end
  end
end
