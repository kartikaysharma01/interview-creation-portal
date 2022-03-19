class Participant < ApplicationRecord
  has_many :interview_participant_mappings, class_name: 'InterviewParticipantMapping', foreign_key: 'participants_id', autosave: true
end
