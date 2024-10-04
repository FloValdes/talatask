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
require "test_helper"

class EmployeeTest < ActiveSupport::TestCase
  test "should not save employee without name" do
    employee = Employee.new
    assert_not employee.save
  end

  test "should not save employee without work_hours_per_day" do
    employee = Employee.new(name: "John")
    assert_not employee.save
  end

  test "should not save employee with work_hours_per_day less than 0" do
    employee = Employee.new(name: "John", work_hours_per_day: -1)
    assert_not employee.save
  end

  test "should not save employee with work_hours_per_day greater than 24" do
    employee = Employee.new(name: "John", work_hours_per_day: 25)
    assert_not employee.save
  end

  test "should save employee with name and work_hours_per_day" do
    employee = Employee.new(name: "John", work_hours_per_day: 8)
    assert employee.save
  end

  test "should not save employee with available_days not an array" do
    employee = Employee.new(name: "John", work_hours_per_day: 8, available_days: 0)
    assert_not employee.save
  end

  test "should not save employee with available_days not an array of integers between 0 and 6" do
    employee = Employee.new(name: "John", work_hours_per_day: 8, available_days: [ 0, 1, 7 ])
    assert_not employee.save
  end

  test "should save employee with name, work_hours_per_day and available_days" do
    employee = Employee.new(name: "John", work_hours_per_day: 8, available_days: [ 0, 1, 2 ])
    assert employee.save
  end
end
