class InterviewParticipantMapping < ApplicationRecord
  belongs_to :participant, foreign_key: "participants_id"
  belongs_to :interview, foreign_key: "interviews_id"
end
