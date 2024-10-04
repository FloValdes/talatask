class CreateEmployeeAbilities < ActiveRecord::Migration[7.2]
  def change
    create_table :employee_abilities do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :ability, null: false, foreign_key: true

      t.timestamps
    end
  end
end
