class DevsInEachMonth < ActiveRecord::Base

  def self.devs_on_month_begin(year, month)
    DevsInEachMonth.where({year: year, month: month}).devs_in_end.to_a.count
  end

  def self.devs_on_month_end(year, month)
    DevsInEachMonth.where({year: year, month: month}).devs_in_end.to_a.count
  end

end
