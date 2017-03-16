require 'test_helper'

class AggregatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @aggregate = aggregates(:one)
  end

  test "should get index" do
    get aggregates_url
    assert_response :success
  end

  test "should get new" do
    get new_aggregate_url
    assert_response :success
  end

  test "should create aggregate" do
    assert_difference('Aggregate.count') do
      post aggregates_url, params: { aggregate: { file_name: @aggregate.file_name, file_type: @aggregate.file_type } }
    end

    assert_redirected_to aggregate_url(Aggregate.last)
  end

  test "should show aggregate" do
    get aggregate_url(@aggregate)
    assert_response :success
  end

  test "should get edit" do
    get edit_aggregate_url(@aggregate)
    assert_response :success
  end

  test "should update aggregate" do
    patch aggregate_url(@aggregate), params: { aggregate: { file_name: @aggregate.file_name, file_type: @aggregate.file_type } }
    assert_redirected_to aggregate_url(@aggregate)
  end

  test "should destroy aggregate" do
    assert_difference('Aggregate.count', -1) do
      delete aggregate_url(@aggregate)
    end

    assert_redirected_to aggregates_url
  end
end
