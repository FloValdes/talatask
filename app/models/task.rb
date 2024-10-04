# == Schema Information
#
# Table name: tasks
#
#  id         :bigint           not null, primary key
#  date       :datetime
#  duration   :float
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Task < ApplicationRecord
  has_many :task_abilities, dependent: :destroy
  has_many :abilities, through: :task_abilities
  has_many :assignments, dependent: :destroy
end
