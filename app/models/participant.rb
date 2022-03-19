class Participant < ApplicationRecord
  has_many :InterviewParticipantMapping, class_name: 'InterviewParticipantMapping', foreign_key: 'participants_id'
end
