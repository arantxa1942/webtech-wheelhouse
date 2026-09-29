class RepairsController < ApplicationController
  def index
    @repairs = Repair.includes(bike: :customer).order(received_at: :desc)
  end

  def show
    @repair = Repair.find(params[:id])
  end
  def new
    
    @repair = Repair.new(bike_id: params[:bike_id], received_at: Time.current)
    build_blank_lines(3)
  end

  def edit
    build_blank_lines(2)
  end

  def create
    @repair = Repair.new(repair_params)
    if @repair.save
      redirect_to @repair, notice: "Repair ##{@repair.id} was created."
    else
      build_blank_lines(3)
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @repair.update(repair_params)
      redirect_to @repair, notice: "Repair ##{@repair.id} was updated."
    else
      build_blank_lines(2)
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    if @repair.destroy
      redirect_to repairs_path, status: :see_other,
                  notice: "Repair ##{@repair.id} was deleted."
    else
      redirect_to @repair, status: :see_other,
                  alert: @repair.errors.full_messages.to_sentence
    end
  end

  private

  def set_repair
    @repair = Repair.find(params[:id])
  end

  
  def build_blank_lines(count)
    count.times { @repair.repair_services.build }
  end

  def repair_params
    params.expect(repair: [
      :bike_id, :staff_member_id, :status, :received_at, :quoted_at,
      :promised_on, :returned_at, :customer_response, :customer_responded_at,
      repair_services_attributes: [[:id, :service_id, :charged_price, :_destroy]]
    ])
  end
end