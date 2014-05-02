class Vacation < ActiveRecord::Base
  VACATION_TYPES = %w[annual medical]

  validates_presence_of :vacation_type, :start_date, :end_date
end
