# == Schema Information
#
# Table name: employee_abilities
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  ability_id  :bigint           not null
#  employee_id :bigint           not null
#
# Indexes
#
#  index_employee_abilities_on_ability_id   (ability_id)
#  index_employee_abilities_on_employee_id  (employee_id)
#
# Foreign Keys
#
#  fk_rails_...  (ability_id => abilities.id)
#  fk_rails_...  (employee_id => employees.id)
#
class EmployeeAbility < ApplicationRecord
  belongs_to :employee
  belongs_to :ability
end
