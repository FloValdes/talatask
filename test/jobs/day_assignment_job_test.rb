require "test_helper"
require "minitest/mock"

class DayAssignmentJobTest < ActiveJob::TestCase
  setup do
    @date = Date.today

    # Creating test data for employees and tasks
    @employee1 = Employee.create!(name: "Alice", work_hours_per_day: 8, available_days: [ @date.wday ], abilities: [ abilities(:one) ])
    @task1 = Task.create!(title: "Task 1", duration: 3, abilities: [ abilities(:one) ], date: @date)
  end

  test "should call backtracking assignment algorithm" do
    mock = Minitest::Mock.new
    mock.expect(:call, [], [ @date ])

    DayAssignmentService.stub(:backtracking_assignment_algorithm, mock) do
      DayAssignmentJob.perform_now(@date)
    end

    assert_mock mock
  end

  test "should always create a DayAssignment" do
    assert_difference "DayAssignment.count", 1 do
      DayAssignmentJob.perform_now(@date)
    end

    day_assignment = DayAssignment.last
    assert_equal @date, day_assignment.date
    assert_not_nil day_assignment.hash_value
    assert day_assignment.assignments.present?
  end
end
