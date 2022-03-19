class CreateInterviewParticipantMappings < ActiveRecord::Migration[7.0]
  def change
    create_table :interview_participant_mappings do |t|
      t.references :participants, null: false, foreign_key: true
      t.references :interviews, null: false, foreign_key: true

      t.timestamps
    end
  end
end
