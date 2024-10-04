class CreateEmployees < ActiveRecord::Migration[7.2]
  def change
    create_table :employees do |t|
      t.string :name
      t.float :work_hours_per_day
      t.integer :available_days, array: true, default: []

      t.timestamps
    end
  end
end
