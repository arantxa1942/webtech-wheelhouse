class RepairsController < ApplicationController
  before_action :set_repair, only: %i[show edit update destroy]

  def index
    authorize Repair
    @repairs = policy_scope(Repair).for_list.newest_first
    @repairs = @repairs.where(status: params[:status]) if Repair.statuses.key?(params[:status].to_s)
    @repairs = @repairs.overdue if params[:overdue].present?
  end

  def show
    @lines = @repair.repair_services.includes(:service)
  end

  def new
    @repair = Repair.new(bike_id: params[:bike_id], received_at: Time.current)
    authorize @repair
    build_blank_lines(3)
  end

  def edit
    build_blank_lines(2)
  end

  def create
    @repair = Repair.new(repair_params.except(:intake_photos))
    authorize @repair
    @repair.taken_in_by = Current.user   
    @repair.new_photos = repair_params[:intake_photos]

    if save_with_photos
      redirect_to @repair, notice: "Repair ##{@repair.id} was created."
    else
      build_blank_lines(3)
      render :new, status: :unprocessable_content
    end
  end

  def update
    @repair.assign_attributes(repair_params.except(:intake_photos))
    @repair.new_photos = repair_params[:intake_photos]

    if save_with_photos
      redirect_to @repair, notice: "Repair ##{@repair.id} was updated."
    else
      build_blank_lines(2)
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    if @repair.destroy
      redirect_to repairs_path, status: :see_other, notice: "Repair ##{@repair.id} was deleted."
    else
      redirect_to @repair, status: :see_other, alert: @repair.errors.full_messages.to_sentence
    end
  end

  private

  def set_repair
    @repair = Repair.find(params[:id])
    authorize @repair   
  end

  def repair_params
    permitted_attributes(@repair || Repair)
  end

  def save_with_photos
    return false unless @repair.save

    @repair.intake_photos.attach(@repair.new_photos) if @repair.new_photos.any?
    true
  end

  def build_blank_lines(count)
    unsaved = @repair.repair_services.select(&:new_record?).size
    (count - unsaved).times { @repair.repair_services.build }
  end
end
 