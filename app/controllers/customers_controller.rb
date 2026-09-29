class CustomersController < ApplicationController
  def index
    @customers = Customer.order(:name)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new
    @customer = Customer.new
  end

  def edit
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to @customer, notice: "Customer #{@customer.name} was created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @customer.update(customer_params)
      redirect_to @customer, notice: "Customer #{@customer.name} was updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    if @customer.destroy
      redirect_to customers_path, status: :see_other,
                  notice: "Customer #{@customer.name} was deleted."
    else
      redirect_to @customer, status: :see_other,
                  alert: @customer.errors.full_messages.to_sentence
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.expect(customer: [:name, :phone])
  end
end