class DayAssignmentService
  def self.fast_assign_tasks(date)
    current_hash = self.calculate_hash(date)
    cached_task_assignment = DayAssignment.find_by(date: date, hash_value: current_hash)

    if cached_task_assignment
      return cached_task_assignment
    end

    initial_assignment = initial_assignment_algorithm(date)

    if initial_assignment
      DayAssignment.create(date: date, assignments_attributes: initial_assignment, hash_value: current_hash)
    else
      nil
    end
  end

  def self.calculate_hash(date)
    tasks = Task.where(date: date).order(:id)
    employees = Employee.all.order(:id)

    task_string = tasks.map do |task|
      [ task.id, task.duration, task.abilities.map(&:id) ].join("-")
    end.join("|")
    employee_string = employees.map do |emp|
      [ emp.id, emp.work_hours_per_day, emp.available_days, emp.abilities.map(&:id) ].join("-")
    end.join("|")

    Digest::SHA256.hexdigest(task_string + employee_string)
  end

  def self.initial_assignment_algorithm(date)
    # Greedy algorithm to assign tasks to employees
    tasks = Task.where(date: date).order(duration: :desc)
    employees = Employee.all.sort_by(&:work_hours_per_day).reverse

    assignments = []

    tasks.each do |task|
      assigned = false

      employees.each do |employee|
        next unless available_on_day?(employee, date)
        next unless has_required_abilities?(employee, task)
        next unless has_available_hours?(employee, task)

        assignments << { task: task, employee: employee }
        employee.work_hours_per_day -= task.duration
        assigned = true
        break
      end

      return nil unless assigned
    end

    assignments
  end

  def self.backtracking_assignment_algorithm(date)
    # Backtracking algorithm to assign tasks to employees
    tasks = Task.where(date: date).order(duration: :desc)
    employees = Employee.all.sort_by(&:work_hours_per_day).reverse

    assignments = []
    backtrack_assignments(tasks, employees, date, assignments)
  end

  def self.backtrack_assignments(tasks, employees, date, assignments)
    return assignments if tasks.empty?

    task = tasks.first

    employees.each do |employee|
      next unless available_on_day?(employee, date)
      next unless has_required_abilities?(employee, task)
      next unless has_available_hours?(employee, task)

      employee.work_hours_per_day -= task.duration
      assignments << { task: task, employee: employee }

      result = backtrack_assignments(tasks[1..-1], employees, date, assignments)

      return result if result

      employee.work_hours_per_day += task.duration
      assignments.pop
    end

    nil
  end

  private

  def self.available_on_day?(employee, date)
    employee.available_days.include?(date.wday)
  end

  def self.has_required_abilities?(employee, task)
    (task.abilities - employee.abilities).empty?
  end

  def self.has_available_hours?(employee, task)
    employee.work_hours_per_day >= task.duration
  end
end
