class DevsInEachMonth < ActiveRecord::Base
  before_save :update_month_delta

  def update_month_delta
    if hired_changed? || left_changed?
      self.delta = hired + left
    end
  end

  def self.increment_devs(date)
    self.find_or_create_by({year: date.year, month: date.month}).increment!(:hired)
  end

  def self.decrement_devs(date)
    self.find_or_create_by({year: date.year, month: date.month}).decrement!(:left)
  end

  def self.devs_on_month_end(date)
    previous_month = where("year <= ? AND month <= ?", date.year, date.month).to_a
    working_devs = 0
    previous_month.each do |month|
      working_devs += month.delta
    end
    working_devs
  end

end
