require "application_system_test_case"

class InterviewParticipantMappingsTest < ApplicationSystemTestCase
  setup do
    @interview_participant_mapping = interview_participant_mappings(:one)
  end

  test "visiting the index" do
    visit interview_participant_mappings_url
    assert_selector "h1", text: "Interview participant mappings"
  end

  test "should create interview participant mapping" do
    visit interview_participant_mappings_url
    click_on "New interview participant mapping"

    fill_in "Interviews", with: @interview_participant_mapping.interviews_id
    fill_in "Participants", with: @interview_participant_mapping.participants_id
    click_on "Create Interview participant mapping"

    assert_text "Interview participant mapping was successfully created"
    click_on "Back"
  end

  test "should update Interview participant mapping" do
    visit interview_participant_mapping_url(@interview_participant_mapping)
    click_on "Edit this interview participant mapping", match: :first

    fill_in "Interviews", with: @interview_participant_mapping.interviews_id
    fill_in "Participants", with: @interview_participant_mapping.participants_id
    click_on "Update Interview participant mapping"

    assert_text "Interview participant mapping was successfully updated"
    click_on "Back"
  end

  test "should destroy Interview participant mapping" do
    visit interview_participant_mapping_url(@interview_participant_mapping)
    click_on "Destroy this interview participant mapping", match: :first

    assert_text "Interview participant mapping was successfully destroyed"
  end
end
