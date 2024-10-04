# == Schema Information
#
# Table name: task_abilities
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ability_id :bigint           not null
#  task_id    :bigint           not null
#
# Indexes
#
#  index_task_abilities_on_ability_id  (ability_id)
#  index_task_abilities_on_task_id     (task_id)
#
# Foreign Keys
#
#  fk_rails_...  (ability_id => abilities.id)
#  fk_rails_...  (task_id => tasks.id)
#
class TaskAbility < ApplicationRecord
  belongs_to :task
  belongs_to :ability
end
