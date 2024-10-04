require "test_helper"

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employee = employees(:one)
  end

  test "should get index" do
    get employees_url, as: :json
    assert_response :success
  end

  test "should create employee" do
    assert_difference("Employee.count") do
      post employees_url, params: { employee: { available_days: @employee.available_days, name: @employee.name, work_hours_per_day: @employee.work_hours_per_day } }, as: :json
    end

    assert_response :created
  end

  test "should show employee" do
    get employee_url(@employee), as: :json
    assert_response :success
  end

  test "should update employee" do
    patch employee_url(@employee), params: { employee: { available_days: @employee.available_days, name: @employee.name, work_hours_per_day: @employee.work_hours_per_day } }, as: :json
    assert_response :success
  end

  test "should destroy employee" do
    assert_difference("Employee.count", -1) do
      delete employee_url(@employee), as: :json
    end

    assert_response :no_content
  end
end
