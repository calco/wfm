class AddColumnsToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :employee_role, :string
    add_column :employees, :manager_id, :integer
  end
end
