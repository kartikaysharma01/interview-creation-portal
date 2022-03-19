class Interview < ApplicationRecord
  validates :start_time, presence: true
  validates :end_time, presence: true, comparison: { greater_than: :start_time }
  validates :interview_participant_mappings, length: { minimum: 2, message: " are required. Please add at least two." }
  has_many :interview_participant_mappings, class_name: 'InterviewParticipantMapping', foreign_key: 'interviews_id', autosave: true,
           dependent: :destroy
end