# == Schema Information
#
# Table name: day_assignments
#
#  id         :bigint           not null, primary key
#  date       :date
#  hash_value :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class DayAssignment < ApplicationRecord
  has_many :assignments, dependent: :destroy

  accepts_nested_attributes_for :assignments
end
