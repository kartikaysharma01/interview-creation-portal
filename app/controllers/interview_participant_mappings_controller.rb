class InterviewParticipantMappingsController < ApplicationController
  before_action :set_interview_participant_mapping, only: %i[ show edit update destroy ]

  # GET /interview_participant_mappings or /interview_participant_mappings.json
  def index
    @interview_participant_mappings = InterviewParticipantMapping.all
  end

  # GET /interview_participant_mappings/1 or /interview_participant_mappings/1.json
  def show
  end

  # GET /interview_participant_mappings/new
  def new
    @interview_participant_mapping = InterviewParticipantMapping.new
  end

  # GET /interview_participant_mappings/1/edit
  def edit
  end

  # POST /interview_participant_mappings or /interview_participant_mappings.json
  def create
    @interview_participant_mapping = InterviewParticipantMapping.new(interview_participant_mapping_params)

    respond_to do |format|
      if @interview_participant_mapping.save
        format.html { redirect_to interview_participant_mapping_url(@interview_participant_mapping), notice: "Interview participant mapping was successfully created." }
        format.json { render :show, status: :created, location: @interview_participant_mapping }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @interview_participant_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interview_participant_mappings/1 or /interview_participant_mappings/1.json
  def update
    respond_to do |format|
      if @interview_participant_mapping.update(interview_participant_mapping_params)
        format.html { redirect_to interview_participant_mapping_url(@interview_participant_mapping), notice: "Interview participant mapping was successfully updated." }
        format.json { render :show, status: :ok, location: @interview_participant_mapping }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @interview_participant_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interview_participant_mappings/1 or /interview_participant_mappings/1.json
  def destroy
    @interview_participant_mapping.destroy

    respond_to do |format|
      format.html { redirect_to interview_participant_mappings_url, notice: "Interview participant mapping was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interview_participant_mapping
      @interview_participant_mapping = InterviewParticipantMapping.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def interview_participant_mapping_params
      params.require(:interview_participant_mapping).permit(:participants_id, :interviews_id)
    end
end
