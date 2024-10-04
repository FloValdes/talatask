class CreateTaskAbilities < ActiveRecord::Migration[7.2]
  def change
    create_table :task_abilities do |t|
      t.references :task, null: false, foreign_key: true
      t.references :ability, null: false, foreign_key: true

      t.timestamps
    end
  end
end
