class Interview < ApplicationRecord
  has_many :interview_participant_mappings, class_name: 'InterviewParticipantMapping', foreign_key: 'interviews_id', autosave: true,
           dependent: :destroy
end
