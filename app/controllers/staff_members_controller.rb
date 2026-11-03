class StaffMembersController < ApplicationController
  before_action :set_staff_member, only: %i[show edit update destroy]

  def index
    authorize StaffMember
    @staff_members = policy_scope(StaffMember).order(:name)  
  end

  def show
    @repairs = policy_scope(@staff_member.repairs).for_list
  end
   def new
    @staff_member = StaffMember.new
    authorize @staff_member
  end

  def edit
  end

  def create
    @staff_member = StaffMember.new(staff_member_params)
    authorize @staff_member
    if @staff_member.save
      redirect_to @staff_member, notice: "Staff member #{@staff_member.name} was created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @staff_member.update(staff_member_params)
      redirect_to @staff_member, notice: "Staff member #{@staff_member.name} was updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    if @staff_member.destroy
      redirect_to staff_members_path, status: :see_other,
                  notice: "Staff member #{@staff_member.name} was deleted."
    else
      redirect_to @staff_member, status: :see_other,
                  alert: @staff_member.errors.full_messages.to_sentence
    end
  end

  private

  def set_staff_member
    @staff_member = StaffMember.find(params[:id])
    authorize @staff_member
  end

  def staff_member_params
    params.expect(staff_member: [:name, :role])
  end
end