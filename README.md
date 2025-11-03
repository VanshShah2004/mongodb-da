# Medical App - MongoDB Backend

A Node.js/Express backend application for managing medical records using MongoDB.

## Prerequisites

- Node.js (LTS version)
- MongoDB Community Edition or MongoDB Atlas account

## Installation Steps

### 1. Install MongoDB

**Option 1 - Local MongoDB (Recommended):**
1. Download from https://www.mongodb.com/try/download/community
2. Choose Windows MSI package
3. Install with "Complete" installation
4. Check "Install MongoDB as a Service"

**Option 2 - MongoDB Atlas:**
1. Visit https://www.mongodb.com/cloud/atlas
2. Create a free cluster
3. Add IP address (0.0.0.0/0 for development)
4. Create database user
5. Copy connection URI

### 2. Verify MongoDB Installation

```powershell
mongod --version
mongosh
```

### 3. Start MongoDB Service

```powershell
net start MongoDB
```

### 4. Project Setup

Dependencies are already installed. If you need to reinstall:

```powershell
npm install
```

### 5. Configure Environment

The `.env` file is already created with:
```
MONGO_URI=mongodb://127.0.0.1:27017/medicaldb
PORT=3000
```

If using Atlas, update `MONGO_URI` in `.env` with your Atlas connection string.

## Running the Application

```powershell
npm start
```

Or:

```powershell
node server.js
```

You should see:
- ✅ MongoDB connected
- 🚀 Server running on http://localhost:3000

## API Endpoints

### Patients

- `POST /patients` - Create a new patient
- `GET /patients` - Get all patients
- `GET /patients/:id` - Get patient by ID
- `PUT /patients/:id` - Update patient
- `DELETE /patients/:id` - Delete patient

### Doctors

- `POST /doctors` - Create a new doctor
- `GET /doctors` - Get all doctors
- `GET /doctors/:id` - Get doctor by ID
- `PUT /doctors/:id` - Update doctor
- `DELETE /doctors/:id` - Delete doctor

### Appointments

- `POST /appointments` - Create a new appointment
- `GET /appointments` - Get all appointments
- `GET /appointments/:id` - Get appointment by ID
- `PUT /appointments/:id` - Update appointment
- `DELETE /appointments/:id` - Delete appointment

## Testing with Postman

### Create Patient Example

**POST** `http://localhost:3000/patients`

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
      "notes": "Type 2"
    }
  ]
}
```

### Get All Patients

**GET** `http://localhost:3000/patients`

### Update Patient

**PUT** `http://localhost:3000/patients/:id`

```json
{
  "address": "Bangalore"
}
```

### Delete Patient

**DELETE** `http://localhost:3000/patients/:id`

## Project Structure

```
medical-app/
│
├── models/
│   ├── patient.js
│   ├── doctor.js
│   ├── appointment.js
│   └── prescription.js
│
├── routes/
│   ├── patientRoutes.js
│   ├── doctorRoutes.js
│   └── appointmentRoutes.js
│
├── .env
├── server.js
└── package.json
```

## MongoDB Features Demonstrated

1. **Flexible Schema** - Medical history can vary per patient
2. **Embedding** - Medical history stored as array in patient documents
3. **Referencing** - Appointments reference patients and doctors via ObjectId
4. **Timestamps** - Automatic createdAt/updatedAt fields
5. **Aggregation** - Can use MongoDB aggregation pipeline for analytics

## Next Steps for Report

1. Screenshot MongoDB Compass showing database
2. Test all CRUD operations in Postman and screenshot
3. Show aggregation queries in mongosh
4. Explain NoSQL benefits for medical data




