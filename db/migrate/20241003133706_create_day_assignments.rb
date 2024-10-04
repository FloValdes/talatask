class CreateDayAssignments < ActiveRecord::Migration[7.2]
  def change
    create_table :day_assignments do |t|
      t.string :hash_value
      t.date :date

      t.timestamps
    end
  end
end
