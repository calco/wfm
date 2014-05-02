class CreateVacations < ActiveRecord::Migration
  def change
    create_table :vacations do |t|
      t.string :vacation_type
      t.date :start_date
      t.date :end_date
      t.string :vacation_status

      t.timestamps
    end
  end
end
