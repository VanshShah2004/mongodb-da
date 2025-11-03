# CRUD Operations Guide

Base URL: http://localhost:3000

---

## 1. Root Endpoint

### GET - Check Server Status
**URL:** `http://localhost:3000/`
**Method:** GET
**Description:** Returns API status

**Response:**
```
Medical App API Running
```

---

## 2. Patients CRUD Operations

### 2.1 CREATE - Add New Patient
**URL:** `http://localhost:3000/patients`
**Method:** POST
**Headers:** Content-Type: application/json

**Request Body:**
```json
{
  "name": "Arjun Kumar",
  "age": 35,
  "gender": "male",
  "phone": "9999999999",
  "email": "a@demo.com",
  "address": "Delhi",
  "medicalHistory": [
    {
      "condition": "Diabetes",
      "diagnosedOn": "2020-01-15",
      "notes": "Type 2, controlled with medication"
    }
  ]
}
```

**Success Response (201):**
```json
{
  "_id": "6908617a3441e175d71a9d31",
  "name": "Arjun Kumar",
  "age": 35,
  "gender": "male",
  "phone": "9999999999",
  "email": "a@demo.com",
  "address": "Delhi",
  "medicalHistory": [...],
  "createdAt": "2025-11-03T08:02:02.690Z",
  "updatedAt": "2025-11-03T08:02:02.690Z",
  "__v": 0
}
```

**Error Response (400):**
```json
{
  "error": "Error message here"
}
```

---

### 2.2 READ ALL - Get All Patients
**URL:** `http://localhost:3000/patients`
**Method:** GET

**Success Response (200):**
```json
[
  {
    "_id": "6908617a3441e175d71a9d31",
    "name": "Arjun Kumar",
    "age": 35,
    ...
  },
  {
    "_id": "6908617a3441e175d71a9d32",
    "name": "Priya Sharma",
    "age": 28,
    ...
  }
]
```

---

### 2.3 READ ONE - Get Patient by ID
**URL:** `http://localhost:3000/patients/:id`
**Method:** GET
**Example:** `http://localhost:3000/patients/6908617a3441e175d71a9d31`

**Success Response (200):**
```json
{
  "_id": "6908617a3441e175d71a9d31",
  "name": "Arjun Kumar",
  "age": 35,
  "gender": "male",
  "phone": "9999999999",
  "email": "a@demo.com",
  "address": "Delhi",
  "medicalHistory": [...],
  "createdAt": "2025-11-03T08:02:02.690Z",
  "updatedAt": "2025-11-03T08:02:02.690Z"
}
```

**Error Response (404):**
```json
{
  "error": "Patient not found"
}
```

---

### 2.4 UPDATE - Update Patient
**URL:** `http://localhost:3000/patients/:id`
**Method:** PUT
**Headers:** Content-Type: application/json
**Example:** `http://localhost:3000/patients/6908617a3441e175d71a9d31`

**Request Body (partial update allowed):**
```json
{
  "address": "Bangalore",
  "phone": "8888888888"
}
```

**Success Response (200):**
```json
{
  "_id": "6908617a3441e175d71a9d31",
  "name": "Arjun Kumar",
  "age": 35,
  "address": "Bangalore",
  "phone": "8888888888",
  ...
}
```

**Error Response (404):**
```json
{
  "error": "Patient not found"
}
```

---

### 2.5 DELETE - Delete Patient
**URL:** `http://localhost:3000/patients/:id`
**Method:** DELETE
**Example:** `http://localhost:3000/patients/6908617a3441e175d71a9d31`

**Success Response (200):**
```json
{
  "message": "Patient deleted"
}
```

**Error Response (404):**
```json
{
  "error": "Patient not found"
}
```

---

## 3. Doctors CRUD Operations

### 3.1 CREATE - Add New Doctor
**URL:** `http://localhost:3000/doctors`
**Method:** POST
**Headers:** Content-Type: application/json

**Request Body:**
```json
{
  "name": "Dr. Anil Verma",
  "specialization": "Cardiologist",
  "phone": "7777777777",
  "email": "dr.verma@hospital.com",
  "experience": 15,
  "qualifications": ["MBBS", "MD Cardiology"]
}
```

**Success Response (201):**
```json
{
  "_id": "6908617a3441e175d71a9d32",
  "name": "Dr. Anil Verma",
  "specialization": "Cardiologist",
  "phone": "7777777777",
  "email": "dr.verma@hospital.com",
  "experience": 15,
  "qualifications": ["MBBS", "MD Cardiology"],
  "createdAt": "2025-11-03T08:02:02.690Z",
  "updatedAt": "2025-11-03T08:02:02.690Z",
  "__v": 0
}
```

---

### 3.2 READ ALL - Get All Doctors
**URL:** `http://localhost:3000/doctors`
**Method:** GET

**Success Response (200):**
```json
[
  {
    "_id": "6908617a3441e175d71a9d32",
    "name": "Dr. Anil Verma",
    ...
  }
]
```

---

### 3.3 READ ONE - Get Doctor by ID
**URL:** `http://localhost:3000/doctors/:id`
**Method:** GET
**Example:** `http://localhost:3000/doctors/6908617a3441e175d71a9d32`

---

### 3.4 UPDATE - Update Doctor
**URL:** `http://localhost:3000/doctors/:id`
**Method:** PUT
**Headers:** Content-Type: application/json

**Request Body:**
```json
{
  "experience": 16,
  "qualifications": ["MBBS", "MD Cardiology", "Fellowship"]
}
```

---

### 3.5 DELETE - Delete Doctor
**URL:** `http://localhost:3000/doctors/:id`
**Method:** DELETE

**Success Response (200):**
```json
{
  "message": "Doctor deleted"
}
```

---

## 4. Appointments CRUD Operations

### 4.1 CREATE - Add New Appointment
**URL:** `http://localhost:3000/appointments`
**Method:** POST
**Headers:** Content-Type: application/json

**Request Body:**
```json
{
  "patientId": "6908617a3441e175d71a9d31",
  "doctorId": "6908617a3441e175d71a9d32",
  "appointmentDate": "2025-11-15",
  "appointmentTime": "10:00 AM",
  "status": "scheduled",
  "notes": "Routine checkup"
}
```

**Success Response (201):**
```json
{
  "_id": "6908617a3441e175d71a9d33",
  "patientId": {
    "_id": "6908617a3441e175d71a9d31",
    "name": "Arjun Kumar",
    ...
  },
  "doctorId": {
    "_id": "6908617a3441e175d71a9d32",
    "name": "Dr. Anil Verma",
    ...
  },
  "appointmentDate": "2025-11-15T00:00:00.000Z",
  "appointmentTime": "10:00 AM",
  "status": "scheduled",
  "notes": "Routine checkup",
  "createdAt": "2025-11-03T08:02:02.690Z",
  "updatedAt": "2025-11-03T08:02:02.690Z"
}
```

---

### 4.2 READ ALL - Get All Appointments
**URL:** `http://localhost:3000/appointments`
**Method:** GET

**Success Response (200):**
```json
[
  {
    "_id": "6908617a3441e175d71a9d33",
    "patientId": { ... },
    "doctorId": { ... },
    ...
  }
]
```

---

### 4.3 READ ONE - Get Appointment by ID
**URL:** `http://localhost:3000/appointments/:id`
**Method:** GET
**Example:** `http://localhost:3000/appointments/6908617a3441e175d71a9d33`

---

### 4.4 UPDATE - Update Appointment
**URL:** `http://localhost:3000/appointments/:id`
**Method:** PUT
**Headers:** Content-Type: application/json

**Request Body:**
```json
{
  "status": "completed",
  "notes": "Patient checked, prescribed medication"
}
```

---

### 4.5 DELETE - Delete Appointment
**URL:** `http://localhost:3000/appointments/:id`
**Method:** DELETE

**Success Response (200):**
```json
{
  "message": "Appointment deleted"
}
```

---

## 5. Testing with Postman

### 5.1 Setup Postman Collection

1. Create a new Collection: "Medical App API"
2. Create folders: Patients, Doctors, Appointments
3. Add requests for each endpoint

### 5.2 Test Sequence

**Step 1:** Create a Patient
- POST http://localhost:3000/patients
- Copy the `_id` from response

**Step 2:** Create a Doctor
- POST http://localhost:3000/doctors
- Copy the `_id` from response

**Step 3:** Create an Appointment
- POST http://localhost:3000/appointments
- Use patientId and doctorId from steps 1 and 2

**Step 4:** Read All
- GET http://localhost:3000/patients
- GET http://localhost:3000/doctors
- GET http://localhost:3000/appointments

**Step 5:** Update
- PUT http://localhost:3000/patients/:id
- PUT http://localhost:3000/doctors/:id
- PUT http://localhost:3000/appointments/:id

**Step 6:** Delete (optional)
- DELETE http://localhost:3000/appointments/:id
- DELETE http://localhost:3000/doctors/:id
- DELETE http://localhost:3000/patients/:id

---

## 6. Testing with PowerShell

### 6.1 Create Patient
```powershell
$body = @{
    name = "Arjun Kumar"
    age = 35
    gender = "male"
    phone = "9999999999"
    email = "a@demo.com"
    address = "Delhi"
} | ConvertTo-Json

Invoke-WebRequest -Uri "http://localhost:3000/patients" -Method POST -Body $body -ContentType "application/json" -UseBasicParsing
```

### 6.2 Get All Patients
```powershell
Invoke-WebRequest -Uri "http://localhost:3000/patients" -Method GET -UseBasicParsing
```

### 6.3 Get Patient by ID
```powershell
$patientId = "6908617a3441e175d71a9d31"
Invoke-WebRequest -Uri "http://localhost:3000/patients/$patientId" -Method GET -UseBasicParsing
```

### 6.4 Update Patient
```powershell
$patientId = "6908617a3441e175d71a9d31"
$body = @{
    address = "Bangalore"
} | ConvertTo-Json

Invoke-WebRequest -Uri "http://localhost:3000/patients/$patientId" -Method PUT -Body $body -ContentType "application/json" -UseBasicParsing
```

### 6.5 Delete Patient
```powershell
$patientId = "6908617a3441e175d71a9d31"
Invoke-WebRequest -Uri "http://localhost:3000/patients/$patientId" -Method DELETE -UseBasicParsing
```

---

## 7. Testing with curl (Command Line)

### 7.1 Create Patient
```bash
curl -X POST http://localhost:3000/patients \
  -H "Content-Type: application/json" \
  -d '{"name":"Arjun Kumar","age":35,"gender":"male","phone":"9999999999","email":"a@demo.com","address":"Delhi"}'
```

### 7.2 Get All Patients
```bash
curl http://localhost:3000/patients
```

### 7.3 Get Patient by ID
```bash
curl http://localhost:3000/patients/6908617a3441e175d71a9d31
```

### 7.4 Update Patient
```bash
curl -X PUT http://localhost:3000/patients/6908617a3441e175d71a9d31 \
  -H "Content-Type: application/json" \
  -d '{"address":"Bangalore"}'
```

### 7.5 Delete Patient
```bash
curl -X DELETE http://localhost:3000/patients/6908617a3441e175d71a9d31
```

---

## 8. HTTP Status Codes

- 200 OK - Request successful
- 201 Created - Resource created successfully
- 400 Bad Request - Invalid request data
- 404 Not Found - Resource not found
- 500 Internal Server Error - Server error

---

## 9. Common Request Examples

### 9.1 Minimal Patient (Flexible Schema)
```json
{
  "name": "John Doe",
  "age": 25
}
```

### 9.2 Full Patient with Medical History
```json
{
  "name": "Jane Smith",
  "age": 42,
  "gender": "female",
  "phone": "9876543210",
  "email": "jane@email.com",
  "address": "Mumbai",
  "medicalHistory": [
    {
      "condition": "Hypertension",
      "diagnosedOn": "2021-03-15",
      "notes": "Controlled with medication"
    },
    {
      "condition": "Asthma",
      "diagnosedOn": "2019-07-20",
      "notes": "Seasonal"
    }
  ]
}
```

### 9.3 Appointment Status Values
- "scheduled" - Appointment is scheduled
- "completed" - Appointment has been completed
- "cancelled" - Appointment was cancelled

---

## 10. Error Handling

All endpoints include error handling:

- Invalid ObjectId format: 500 error
- Missing required fields: 400 error (if validation is added)
- Resource not found: 404 error
- Database connection issues: 500 error

---

## 11. Quick Reference

| Resource | CREATE | READ ALL | READ ONE | UPDATE | DELETE |
|----------|--------|----------|----------|--------|--------|
| Patients | POST /patients | GET /patients | GET /patients/:id | PUT /patients/:id | DELETE /patients/:id |
| Doctors | POST /doctors | GET /doctors | GET /doctors/:id | PUT /doctors/:id | DELETE /doctors/:id |
| Appointments | POST /appointments | GET /appointments | GET /appointments/:id | PUT /appointments/:id | DELETE /appointments/:id |

---

Make sure your server is running:
```bash
node server.js
```

Then test all endpoints using Postman, PowerShell, or curl!

