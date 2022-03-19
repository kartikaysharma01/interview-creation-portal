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

    unless interview_params[:participants]
      @interview.errors.add('Participants', ' missing. Atleast 2 required.')
      response_error(:bad_request) and return
    end
    participants = Participant.find(interview_params[:participants])

    participants&.each do |participant|
      @interview.interview_participant_mappings.build(interview: @interview, participant:)
    end

    if @interview.save
      response_success
    else
      response_error(:unprocessable_entity)
    end
  end

  # PATCH/PUT /interviews/1 or /interviews/1.json
  def update

    unless interview_params[:participants]
      @interview.errors.add('Participants', ' missing. Atleast 2 required.')
      response_error(:bad_request) and return
    end

    existing_participant_ids = @interview.interview_participant_mappings.pluck(:participants_id)
    updated_participant_ids = interview_params[:participants]

    participants_to_delete = existing_participant_ids - updated_participant_ids
    participants_to_add = updated_participant_ids - existing_participant_ids

    participants_to_delete.each do |x|

      z = @interview.interview_participant_mappings.find_by(participants_id: x)
      @interview.interview_participant_mappings.delete(z)
    end

    unless participants_to_add.blank?
      participants = Participant.find(participants_to_add)

      participants&.each do |participant|
        @interview.interview_participant_mappings.build(interview: @interview, participant:)
      end
    end

    if @interview.update(start_time: interview_params[:start_time], end_time: interview_params[:end_time])
      response_success
    else
      response_error(:unprocessable_entity)
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
end
