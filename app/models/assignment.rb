# == Schema Information
#
# Table name: assignments
#
#  id                :bigint           not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  day_assignment_id :bigint           not null
#  employee_id       :bigint           not null
#  task_id           :bigint           not null
#
# Indexes
#
#  index_assignments_on_day_assignment_id  (day_assignment_id)
#  index_assignments_on_employee_id        (employee_id)
#  index_assignments_on_task_id            (task_id)
#
# Foreign Keys
#
#  fk_rails_...  (day_assignment_id => day_assignments.id)
#  fk_rails_...  (employee_id => employees.id)
#  fk_rails_...  (task_id => tasks.id)
#
class Assignment < ApplicationRecord
  belongs_to :task
  belongs_to :employee
  belongs_to :day_assignment
end
