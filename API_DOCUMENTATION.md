## Employees

### GET /employees
**Description:** Retrieve a list of all employees.

**Response:**
- 200 OK
```json
[
  {
    "id": 1,
    "name": "Alice",
    "available_days": [0, 1, 2],
    "work_hours_per_day": 8.0,
    "abilities": [
      { "id": 1, "name": "Ability 1" },
      { "id": 2, "name": "Ability 2" }
    ]
  },
  ...
]
```

### POST /employees
**Description: Create a new employee.**

**Request body**

```json
{
  "name": "John",
  "available_days": [0, 1],
  "work_hours_per_day": 8,
  "abilities": ["Ability 1", "Ability 2"]
}
```

Notes:
- The available_days field for employees is an array of integers representing the days of the week (0 = Sunday, 1 = Monday, ..., 6 = Saturday).
- When creating employees (or tasks), if the specified abilities do not exist, they will be created automatically.

**Response:**
- 201 Created
```json
{
  "id": 1,
  "name": "John",
  "available_days": [0, 1],
  "work_hours_per_day": 8,
  "abilities": [
    { "id": 1, "name": "Ability 1" },
    { "id": 2, "name": "Ability 2" }
  ]
}
```

### GET /employees/:id
**Description:** Retrieve a specific employee by ID

**Response:**
- 200 OK
```json
{
  "id": 1,
  "name": "Alice",
  "available_days": [0, 1, 2],
  "work_hours_per_day": 8.0,
  "abilities": [
    { "id": 1, "name": "Ability 1" },
    { "id": 2, "name": "Ability 2" }
  ]
}
```

### DELETE /employees/:id
**Description:** Delete a specific employee by ID.

**Response:**
- 204 No Content

## Tasks

### GET /tasks
**Description:** Retrieve a list of all tasks.

**Response:**
- 200 OK
```json
[
  {
    "id": 1,
    "title": "Task 1",
    "date": "2024-10-04T00:00:00Z",
    "duration": 3.0,
    "abilities": [
      { "id": 1, "name": "Ability 1" },
      { "id": 2, "name": "Ability 2" }
    ]
  },
  ...
]
```

### POST /tasks
**Description: Create a new task.**

**Request body**

```json
{
  "title": "New Task",
  "date": "2024-10-04",
  "duration": 2.5,
  "abilities": ["Ability 1", "Ability 3"]
}
```

**Response:**
- 201 Created
```json
{
  "id": 1,
  "title": "New Task",
  "date": "2024-10-04T00:00:00Z",
  "duration": 2.5,
  "abilities": [
    { "id": 1, "name": "Ability 1" },
    { "id": 3, "name": "Ability 3" }
  ]
}
```

### GET /tasks/:id
**Description:** Retrieve a specific task by ID

**Response:**
- 200 OK
```json
{
  "id": 1,
  "title": "New Task",
  "date": "2024-10-04T00:00:00Z",
  "duration": 2.5,
  "abilities": [
    { "id": 1, "name": "Ability 1" },
    { "id": 3, "name": "Ability 3" }
  ]
}
```

### DELETE /tasks/:id
**Description:** Delete a specific task by ID.

**Response:**
- 204 No Content

## Abilities

### GET /abilities
**Description:** Retrieve a list of all abilities.

**Response:**
- 200 OK
```json
[
  {
    "id": 1,
    "name": "Ability 1"
  },
  ...
]
```

### POST /abilities
**Description: Create a new ability.**

**Request body**

```json
{
  "name": "New Ability"
}
```

**Response:**
- 201 Created
```json
{
  "id": 2,
  "name": "New Ability"
}
```

### GET /abilities/:id
**Description:** Retrieve a specific ability by ID

**Response:**
- 200 OK
```json
{
  "id": 2,
  "name": "New Ability"
}
```

### DELETE /abilities/:id
**Description:** Delete a specific ability by ID.

**Response:**
- 204 No Content

## Day Assignment

### GET /day_assignment/:date
**Description:** Retrieve the task assignments for a specific date. On the first call, if the assignments are being generated, a message will be returned indicating that the user should check back later. On subsequent calls, it will either return the assignments for the day or an empty array if no assignments could be made.

#### Path Parameters:
- `date` (required): The date for which to retrieve the task assignments in `YYYY-MM-DD` format.

#### Responses:

- **First Call** (if assignments are still being generated):
  - 200 OK
```json
{
  "message": "Task assignment is being generated, please check back later."
}
```

- **First Call** (if assignments are available):
- 200 OK

```json
[
  {
    "id": 1,
    "created_at": "2024-10-04T10:00:00Z",
    "updated_at": "2024-10-04T10:00:00Z",
    "day_assignment_id": 1,
    "employee_id": 1,
    "task_id": 1
  },
  ...
]
```

- **Subsequent Calls:** (if assignments were generated but no suitable assignments could be made):
- 200 OK

```json
[]
```

- **Subsequent Calls:** (if assignments are available):
- 200 OK

```json
[
  {
    "id": 1,
    "created_at": "2024-10-04T10:00:00Z",
    "updated_at": "2024-10-04T10:00:00Z",
    "day_assignment_id": 1,
    "employee_id": 1,
    "task_id": 1
  },
  ...
]
```

Notes:
- Each assignment contains references to the employee and task involved.
- The response format includes the id, created_at, updated_at, day_assignment_id, employee_id, and task_id for each assignment.
- Ensure the date is formatted correctly when making the request to avoid errors.




