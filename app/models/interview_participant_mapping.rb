class InterviewParticipantMapping < ApplicationRecord
  belongs_to :participants
  belongs_to :interviews
end
