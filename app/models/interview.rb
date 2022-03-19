class Interview < ApplicationRecord
  has_many :articipants, class_name: 'InterviewParticipantMapping', foreign_key: 'interviews_id'
end
