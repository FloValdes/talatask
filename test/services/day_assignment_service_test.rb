require "test_helper"

class DayAssignmentServiceTest < ActiveSupport::TestCase
  setup do
    @date = Date.today

    @employee1 = Employee.create!(name: "Alice", work_hours_per_day: 8, available_days: [ @date.wday ], abilities: [ abilities(:one) ])
    @employee2 = Employee.create!(name: "Bob", work_hours_per_day: 5, available_days: [ @date.wday ], abilities: [ abilities(:two) ])

    @task1 = Task.create!(title: "Task 1", duration: 3, abilities: [ abilities(:one) ], date: @date)
    @task2 = Task.create!(title: "Task 2", duration: 2, abilities: [ abilities(:two) ], date: @date)
  end

  test "should return cached assignment if it exists" do
    hash_value = DayAssignmentService.calculate_hash(@date)
    cached_assignment = DayAssignment.create!(date: @date, hash_value: hash_value, assignments_attributes: [])

    result = DayAssignmentService.fast_assign_tasks(@date)

    assert_equal cached_assignment, result
  end

  test "should create a new assignment if no cache exists" do
    DayAssignment.destroy_all
    assert_difference "DayAssignment.count", 1 do
      result = DayAssignmentService.fast_assign_tasks(@date)
      assert_not_nil result
      assert_equal @date, result.date
    end
  end

  test "should return nil if tasks cannot be assigned" do
    Task.create!(title: "Impossible Task", duration: 20, abilities: [ abilities(:one) ], date: @date)

    result = DayAssignmentService.fast_assign_tasks(@date)

    assert_nil result
  end

  test "should generate different hash values for different task or employee setups" do
    hash_value_1 = DayAssignmentService.calculate_hash(@date)

    Task.create!(title: "New Task", duration: 1, abilities: [ abilities(:two) ], date: @date)
    hash_value_2 = DayAssignmentService.calculate_hash(@date)

    assert_not_equal hash_value_1, hash_value_2
  end

  test "should assign tasks using backtracking algorithm when feasible" do
    assignments = DayAssignmentService.backtracking_assignment_algorithm(@date)

    assert_not_nil assignments
    assert_equal 2, assignments.size

    task_ids = assignments.map { |assignment| assignment[:task].id }
    assert_includes task_ids, @task1.id
    assert_includes task_ids, @task2.id

    assignments.each do |assignment|
      employee = assignment[:employee]
      task = assignment[:task]

      assert_includes employee.available_days, @date.wday
      assert (task.abilities - employee.abilities).empty?
      assert employee.work_hours_per_day >= task.duration
    end
  end

  test "should return nil if tasks cannot be assigned using backtracking algorithm" do
    # Create an impossible task to assign
    Task.create!(title: "Impossible Task", duration: 20, abilities: [ abilities(:one) ], date: @date)

    assignments = DayAssignmentService.backtracking_assignment_algorithm(@date)

    assert_nil assignments
  end

  test "should correctly backtrack when first employee cannot complete all tasks" do
    # Add more employees to create an assignment scenario that requires backtracking
    @employee3 = Employee.create!(name: "Charlie", work_hours_per_day: 10, available_days: [ @date.wday ], abilities: [ abilities(:two) ])

    @task3 = Task.create!(title: "Task 3", duration: 4, abilities: [ abilities(:two) ], date: @date)

    assignments = DayAssignmentService.backtracking_assignment_algorithm(@date)

    assert_not_nil assignments
    assert_equal 3, assignments.size

    task_ids = assignments.map { |assignment| assignment[:task].id }
    assert_includes task_ids, @task1.id
    assert_includes task_ids, @task2.id
    assert_includes task_ids, @task3.id
  end
end
