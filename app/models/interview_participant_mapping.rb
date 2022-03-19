class InterviewParticipantMapping < ApplicationRecord
  validate :check_clashes
  belongs_to :participant, foreign_key: "participants_id"
  belongs_to :interview, foreign_key: "interviews_id"

  def check_clashes
    # check if any selected participants time clashes
    participant.interview_participant_mappings.each do |interview_participant_mapping|
      existing_interview = interview_participant_mapping.interview
      if existing_interview == interview
        next
      end
      if time_overlap(interview[:start_time], interview[:end_time], existing_interview[:start_time], existing_interview[:end_time])
        errors.add('Interview Clash: ', "Participant #{participant[:name]} has another interview between #{existing_interview[:start_time]} - #{existing_interview[:end_time]} for interview id #{existing_interview[:id]}")
        # response_error(:conflict) and return
      end
    end
  end

  def time_overlap(range_a_begin, range_a_end, range_b_begin, range_b_end)
    if range_a_begin && range_a_end && range_b_begin && range_b_end
      range_b_begin <= range_a_end && range_a_begin <= range_b_end
    end
  end
end