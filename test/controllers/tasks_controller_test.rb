require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:one)
  end

  test "should get index" do
    get tasks_url, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal Task.count, json_response.count
  end

  test "should create task" do
    assert_difference("Task.count") do
      post tasks_url, params: { task: { date: @task.date, duration: @task.duration, title: @task.title } }, as: :json
    end

    assert_response :created
  end

  test "should show task" do
    get task_url(@task), as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @task.title, json_response["title"]
  end

  test "should update task" do
    patch task_url(@task), params: { task: { date: @task.date, duration: @task.duration, title: @task.title } }, as: :json
    assert_response :success
  end

  test "should destroy task" do
    assert_difference("Task.count", -1) do
      delete task_url(@task), as: :json
    end

    assert_response :no_content
  end
end
