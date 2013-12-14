class Job < ActiveRecord::Base
  validates :started_on, presence: true
  before_save :update_month_count

  def self.devs_started_this_month(year, month)
    Job.where({:started_on =>month_range(year, month)}).to_a.count
  end

  def self.devs_ended_this_month(year, month)
    Job.where({:ended_on =>month_range(year, month)}).to_a.count
  end

  def update_month_count
    if started_on_changed?
      old_started, new_started = started_on_change[0], started_on_change[1]
      DevsInEachMonth.increment_devs(new_started) if new_started
      DevsInEachMonth.decrement_devs(old_started) if old_started
    end

    if ended_on_changed?
      old_ended, new_ended = ended_on_change[0], ended_on_change[1]
      DevsInEachMonth.decrement_devs(new_ended) if new_ended
      DevsInEachMonth.increment_devs(old_ended) if old_ended
    end
  end

  def self.churn(date)
    average = (devs_started_this_month(year, month).count+devs_ended_this_month(year, month).count)/2
  end

  private
  def self.month_range(year, month)
    last_day = Time.days_in_month(month, year)
    Date.new(year, month, 01)..Date.new(year, month, last_day)
  end
end
