class InterviewsController < ApplicationController
  before_action :set_interview, only: %i[ show edit update destroy ]

  # GET /interviews or /interviews.json
  def index
    @interviews = Interview.all
  end

  # GET /interviews/1 or /interviews/1.json
  def show
  end

  # GET /interviews/new
  def new
    @interview = Interview.new
  end

  # GET /interviews/1/edit
  def edit
  end

  # POST /interviews or /interviews.json
  def create
    # binding.break
    @interview = Interview.new(start_time: interview_params[:start_time], end_time: interview_params[:end_time])

    if interview_params[:start_time].blank?
      @interview.errors.add(:start_time,"missing")
      response_error(:bad_request) and return
    end

    if interview_params[:end_time].blank?
      @interview.errors.add(:end_time,"missing")
      response_error(:bad_request) and return
    end

    if interview_params[:end_time] < interview_params[:start_time]
      @interview.errors.add(:end_time,"should be after start time")
      response_error(:bad_request) and return
    end

    participant_ids = interview_params[:participants]
    if !participant_ids || participant_ids.size < 2
      @interview.errors.add(:participants, "minimum 2 are required")
      response_error(:bad_request) and return
    end

    participants = []

    participant_ids.each { |participant_id|
      participant = Participant.find(participant_id)
      unless participant
        @interview.errors.add(:participants, "not found")
        response_error(:bad_request) and return
      end
      participant.interview_participant_mappings.each { |interview_participant_mapping|
        interview = interview_participant_mapping.interview
        if time_overlap(interview[:start_time], interview[:end_time], interview_params[:start_time], interview_params[:end_time])
          @interview.errors.add(:participants, "Interview clash for participant" + participant[:name] + "with interview id" + interview[:id])
          response_error(:conflict) and return
        end
      }
      participants.append(participant)
    }

    @interview.save
    # binding.break
    participants.each { |participant|
      binding.break
      InterviewParticipantMapping.create(participant: participant, interview: @interview)
    }

    response_success
  end

  # PATCH/PUT /interviews/1 or /interviews/1.json
  def update
    respond_to do |format|
      if @interview.update(interview_params)
        format.html { redirect_to interview_url(@interview), notice: "Interview was successfully updated." }
        format.json { render :show, status: :ok, location: @interview }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interviews/1 or /interviews/1.json
  def destroy
    @interview.destroy

    respond_to do |format|
      format.html { redirect_to interviews_url, notice: "Interview was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interview
      @interview = Interview.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def interview_params
      params.require(:interview).permit(:start_time, :end_time, participants: [])
    end

    def response_success
      respond_to do |format|
        format.html { redirect_to interview_url(@interview), notice: "Interview was successfully created." }
        format.json { render :show, status: :created, location: @interview }
      end
    end

    def response_error(status)
      respond_to do |format|
        format.html { render :new, status: status }
        format.json { render json: @interview.errors, status: status }
      end
    end

  def time_overlap(range_a_begin, range_a_end, range_b_begin, range_b_end)
    range_b_begin <= range_a_end && range_a_begin <= range_b_end
  end
end
