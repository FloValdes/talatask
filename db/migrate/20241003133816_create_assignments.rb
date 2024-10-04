class CreateAssignments < ActiveRecord::Migration[7.2]
  def change
    create_table :assignments do |t|
      t.references :task, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true
      t.references :day_assignment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
