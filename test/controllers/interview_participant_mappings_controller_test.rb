require "test_helper"

class InterviewParticipantMappingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @interview_participant_mapping = interview_participant_mappings(:one)
  end

  test "should get index" do
    get interview_participant_mappings_url
    assert_response :success
  end

  test "should get new" do
    get new_interview_participant_mapping_url
    assert_response :success
  end

  test "should create interview_participant_mapping" do
    assert_difference("InterviewParticipantMapping.count") do
      post interview_participant_mappings_url, params: { interview_participant_mapping: { interviews_id: @interview_participant_mapping.interviews_id, participants_id: @interview_participant_mapping.participants_id } }
    end

    assert_redirected_to interview_participant_mapping_url(InterviewParticipantMapping.last)
  end

  test "should show interview_participant_mapping" do
    get interview_participant_mapping_url(@interview_participant_mapping)
    assert_response :success
  end

  test "should get edit" do
    get edit_interview_participant_mapping_url(@interview_participant_mapping)
    assert_response :success
  end

  test "should update interview_participant_mapping" do
    patch interview_participant_mapping_url(@interview_participant_mapping), params: { interview_participant_mapping: { interviews_id: @interview_participant_mapping.interviews_id, participants_id: @interview_participant_mapping.participants_id } }
    assert_redirected_to interview_participant_mapping_url(@interview_participant_mapping)
  end

  test "should destroy interview_participant_mapping" do
    assert_difference("InterviewParticipantMapping.count", -1) do
      delete interview_participant_mapping_url(@interview_participant_mapping)
    end

    assert_redirected_to interview_participant_mappings_url
  end
end
