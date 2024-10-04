class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show update destroy ]

  # GET /employees
  def index
    @employees = Employee.all

    render json: @employees.as_json(include: :abilities)
  end

  # GET /employees/1
  def show
    render json: @employee.as_json(include: :abilities)
  end

  # POST /employees
  def create
    @employee = Employee.new(employee_params)

    if params[:abilities]
      abilities = params[:abilities].map do |ability_name|
        Ability.find_or_create_by(name: ability_name)
      end
      @employee.abilities = abilities
    end

    if @employee.save
      render json: @employee, status: :created, location: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /employees/1
  def update
    if @employee.update(employee_params)
      render json: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  # DELETE /employees/1
  def destroy
    @employee.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:name, :work_hours_per_day, available_days: [])
    end
end
