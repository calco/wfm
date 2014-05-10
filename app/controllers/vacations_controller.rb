class VacationsController < ApplicationController

  before_action :authenticate_employee!

  def index
    @vacations = current_employee.vacations.order(:start_date)
    @subordinate_pending_vacations = Vacation.pending_vacations.order(:start_date).to_a.keep_if{|v| v.applicant.manager_id == current_employee.id }
  end

  def new
    @vacation = Vacation.new
  end

  def create
    @vacation = Vacation.new(vacation_params)
    @vacation.vacation_status = "pending"
    @vacation.applicant_id = current_employee.id
    if @vacation.save
      redirect_to @vacation, notice: "Vacation added successfully."
    else
      render 'new'
    end
  end

  def show
    @vacation = Vacation.find params[:id]
  end

  def edit
    @vacation = Vacation.find params[:id]
  end

  def update
    @vacation = Vacation.find(params[:id])
    if @vacation.vacation_status == "pending" && @vacation.applicant == current_employee
      if @vacation.update(vacation_params)
        redirect_to @vacation
      else
        render 'edit'
      end
    else
      redirect_to @vacation, alert: "This vacation cannot be edited since it was already reviewed."
    end
  end

  def destroy
    @vacation = Vacation.find(params[:id])
    if @vacation.vacation_status == "pending" && @vacation.applicant == current_employee
      @vacation.destroy
      redirect_to vacations_path
    else
      redirect_to @vacation, alert: "This vacation cannot be removed since it was already reviewed."
    end
  end

  def approve_vacation
    @vacation = Vacation.find(params[:id])
    if @vacation.update(vacation_status: "approved")
      redirect_to @vacation, notice: "Vacation approved successfully."
    else
      redirect_to @vacation, alert: "An error happened and the vacation could not be approved."
    end
  end

  def reject_vacation
    @vacation = Vacation.find(params[:id])
    if @vacation.update(vacation_status: "rejected")
      redirect_to @vacation, notice: "Vacation rejected successfully."
    else
      redirect_to @vacation, alert: "An error happened and the vacation could not be rejected."
    end
  end

  private
  
  def vacation_params
    params.require(:vacation).permit(:vacation_type, :start_date, :end_date)
  end
end
