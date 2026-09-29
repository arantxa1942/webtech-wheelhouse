class BikesController < ApplicationController
  def index
    @bikes = Bike.includes(:customer).order(:make, :model)
  end

  def show
    @bike = Bike.find(params[:id])
  end
  def new
    
    @bike = Bike.new(customer_id: params[:customer_id])
  end

  def edit
  end

  def create
    @bike = Bike.new(bike_params)
    if @bike.save
      redirect_to @bike, notice: "Bike #{@bike.serial_number} was created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @bike.update(bike_params)
      redirect_to @bike, notice: "Bike #{@bike.serial_number} was updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    if @bike.destroy
      redirect_to bikes_path, status: :see_other,
                  notice: "Bike #{@bike.serial_number} was deleted."
    else
      redirect_to @bike, status: :see_other,
                  alert: @bike.errors.full_messages.to_sentence
    end
  end

  private

  def set_bike
    @bike = Bike.find(params[:id])
  end

  def bike_params
    params.expect(bike: [:customer_id, :make, :model, :color, :serial_number])
  end
end