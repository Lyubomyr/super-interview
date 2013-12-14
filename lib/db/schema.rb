require 'active_record'

ActiveRecord::Base.logger = Logger.new(STDERR)
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ":memory:")

ActiveRecord::Schema.define do
  create_table :jobs do |table|
    table.column :company,    :string
    table.column :developer,  :string
    table.column :started_on, :date
    table.column :ended_on,   :date
    table.column :status,     :string
  end

 create_table :devs_in_each_month do |table|
    table.column :year,    :integer
    table.column :month,    :integer
    table.column :devs_in_end,    :integer, default: 0
  end
end
