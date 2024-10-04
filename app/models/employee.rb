# == Schema Information
#
# Table name: employees
#
#  id                 :bigint           not null, primary key
#  available_days     :integer          default([]), is an Array
#  name               :string
#  work_hours_per_day :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Employee < ApplicationRecord
  has_many :employee_abilities, dependent: :destroy
  has_many :abilities, through: :employee_abilities
  has_many :assignments, dependent: :destroy

  validates :work_hours_per_day, numericality: { greater_than: 0, less_than_or_equal_to: 24 }
  validate :available_days_valid

  private

  def available_days_valid
    unless available_days.is_a?(Array) && available_days.all? { |day| day.is_a?(Integer) && day >= 0 && day <= 6 }
      errors.add(:available_days, "must be an array of integers between 0 and 6")
    end
  end
end
