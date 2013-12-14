class Job < ActiveRecord::Base
  validates :started_on, presence: true
  after_save :update_month_count

  def self.devs_started_this_month(year, month)
    Job.where({:started_on =>month_range(year, month)}).to_a.count
  end

  def self.devs_ended_this_month(year, month)
    Job.where({:ended_on =>month_range(year, month)}).to_a.count
  end

  def update_month_count
    date = self.ended_on
    DevsInEachMonth.where({year: date.year, month: date.month}).increment!(:devs_in_end) if new_record?
    DevsInEachMonth.where({year: date.year, month: date.month}).increment!(:devs_in_end) if date
  end

  def self.churn
    average = (started_in_month(year, month).count+ender_in_month(year, month).count)/2
    ender_in_month(year, month).count/average
  end

  private
  def self.month_range(year, month)
    last_day = Time.days_in_month(month, year)
    Date.new(year, month, 01)..Date.new(year, month, last_day)
  end
end
