module ParticipantsHelper
  def get_participant_names(participant_ids)
    participants = Participant.find(participant_ids)
    participants_name = []
    participants.each { |participant|
      participants_name.append(participant.name)
    }
    participants_name
  end
end
