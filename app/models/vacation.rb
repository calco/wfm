class Vacation < ActiveRecord::Base
  
  # Relations
  belongs_to :employee

  # Vacation types ...
  VACATION_TYPES = %w[annual medical]

  # Validations
  validates_presence_of :vacation_type, :start_date, :end_date
  validate :start_end_date_validation
  
  # private

  def start_end_date_validation
    if self[:end_date] && self[:start_date]
      unless self[:end_date] > self[:start_date]
        self.errors.add(:base, "A vacation's \"End date\" has to be after its \"Start date\".")
        return false
      else
        return true
      end
    else
      return false
    end
  end
end
