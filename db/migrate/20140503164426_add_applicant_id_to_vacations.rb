class AddApplicantIdToVacations < ActiveRecord::Migration
  def change
    add_column :vacations, :applicant_id, :integer
  end
end
