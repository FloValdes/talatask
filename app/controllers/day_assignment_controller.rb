class DayAssignmentController < ApplicationController
  def show
    date = Date.parse(params[:date])

    fast_day_assignment = DayAssignmentService.fast_assign_tasks(date)

    if fast_day_assignment
      render json: fast_day_assignment.assignments, status: :ok
    else
      DayAssignmentJob.perform_later(date)
      render json: { message: "Task assignment is being generated, please check back later." }, status: :accepted
    end
  end
end
