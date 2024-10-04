# == Schema Information
#
# Table name: abilities
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Ability < ApplicationRecord
  has_many :employee_abilities, dependent: :destroy
  has_many :employees, through: :employee_abilities

  has_many :task_abilities, dependent: :destroy
  has_many :tasks, through: :task_abilities
end
