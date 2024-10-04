require "test_helper"

class AbilitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ability = abilities(:one)
  end

  test "should get index" do
    get abilities_url, as: :json
    assert_response :success
  end

  test "should create ability" do
    assert_difference("Ability.count") do
      post abilities_url, params: { ability: { name: @ability.name } }, as: :json
    end

    assert_response :created
  end

  test "should show ability" do
    get ability_url(@ability), as: :json
    assert_response :success
  end

  test "should update ability" do
    patch ability_url(@ability), params: { ability: { name: @ability.name } }, as: :json
    assert_response :success
  end

  test "should destroy ability" do
    assert_difference("Ability.count", -1) do
      delete ability_url(@ability), as: :json
    end

    assert_response :no_content
  end
end
