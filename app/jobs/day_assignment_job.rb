class DayAssignmentJob < ApplicationJob
  queue_as :default

  def perform(date)
    assignments = DayAssignmentService.backtracking_assignment_algorithm(date)

    hash_value = DayAssignmentService.calculate_hash(date)

    if assignments
      DayAssignment.create!(date: date, assignments_attributes: assignments, hash_value: hash_value)
    else
      DayAssignment.create!(date: date, hash_value: hash_value, assignments_attributes: [])
    end
  end
end
