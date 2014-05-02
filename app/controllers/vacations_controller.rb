class VacationsController < ApplicationController
  def index
    @vacations = Vacation.all.to_a
  end

  def new
    @vacation = Vacation.new
  end

  def create
    @vacation = Vacation.new(vacation_params)
    respond_to do |format|
      if @vacation.save
        format.html { redirect_to root_path, :notice => "Vacation added successfully." }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def delete
  end

  private
  
  def vacation_params
    params.require(:vacation).permit(:vacation_type, :start_date, :end_date)
  end
end
