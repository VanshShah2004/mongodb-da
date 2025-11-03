# 📋 Complete Step-by-Step Guide

## ✅ Current Status
- ✅ MongoDB installed and running
- ✅ Node.js server running on port 3000
- ✅ MongoDB connected successfully
- ✅ All project files created

---

## 🧪 STEP 8 - Test CRUD Operations (10 marks)

### Method 1: Using Postman (Recommended)

#### 1️⃣ **Install Postman** (if not installed)
- Download from: https://www.postman.com/downloads/
- Install and open Postman

#### 2️⃣ **Create Patient (POST)**

**Action:**
1. Open Postman
2. Create a new request
3. Set method to **POST**
4. Enter URL: `http://localhost:3000/patients`
5. Click **Body** tab → Select **raw** → Select **JSON**
6. Paste this JSON:
```json
{
  "name": "Arjun Kumar",
  "age": 35,
  "gender": "male",
  "phone": "9999999999",
  "email": "a@demo.com",
  "address": "Delhi"
}
```
7. Click **Send**
8. **📸 Take screenshot** showing:
   - Request method (POST)
   - URL
   - Request body
   - Response (status 201, patient data with `_id`)

**Expected Response:**
```json
{
  "_id": "6908617a3441e175d71a9d31",
  "name": "Arjun Kumar",
  "age": 35,
  "gender": "male",
  "phone": "9999999999",
  "email": "a@demo.com",
  "address": "Delhi",
  "medicalHistory": [],
  "createdAt": "2025-11-03T...",
  "updatedAt": "2025-11-03T...",
  "__v": 0
}
```

**💡 Copy the `_id` from response - you'll need it for next steps!**

#### 3️⃣ **Get All Patients (GET)**

**Action:**
1. Create new request in Postman
2. Set method to **GET**
3. Enter URL: `http://localhost:3000/patients`
4. Click **Send**
5. **📸 Take screenshot** showing:
   - Request method (GET)
   - URL
   - Response (array of patients)

**Expected Response:**
```json
[
  {
    "_id": "...",
    "name": "Arjun Kumar",
    ...
  }
]
```

#### 4️⃣ **Get One Patient (GET by ID)**

**Action:**
1. Create new request in Postman
2. Set method to **GET**
3. Enter URL: `http://localhost:3000/patients/YOUR_PATIENT_ID`
   - Replace `YOUR_PATIENT_ID` with the `_id` from step 2️⃣
   - Example: `http://localhost:3000/patients/6908617a3441e175d71a9d31`
4. Click **Send**
5. **📸 Take screenshot** showing:
   - Request method (GET)
   - URL with ID
   - Response (single patient object)

#### 5️⃣ **Update Patient (PUT)**

**Action:**
1. Create new request in Postman
2. Set method to **PUT**
3. Enter URL: `http://localhost:3000/patients/YOUR_PATIENT_ID`
   - Replace with your patient ID
4. Click **Body** tab → Select **raw** → Select **JSON**
5. Paste this JSON:
```json
{
  "address": "Bangalore"
}
```
6. Click **Send**
7. **📸 Take screenshot** showing:
   - Request method (PUT)
   - URL with ID
   - Request body
   - Response (updated patient with new address)

**Expected Response:** Address should now be "Bangalore"

#### 6️⃣ **Delete Patient (DELETE)**

**Action:**
1. Create new request in Postman
2. Set method to **DELETE**
3. Enter URL: `http://localhost:3000/patients/YOUR_PATIENT_ID`
   - Replace with your patient ID
4. Click **Send**
5. **📸 Take screenshot** showing:
   - Request method (DELETE)
   - URL with ID
   - Response (success message)

**Expected Response:**
```json
{
  "message": "Patient deleted"
}
```

---

### Method 2: Using PowerShell (Alternative)

Open PowerShell in your project folder and run:

```powershell
# Run the test script
.\test-api.ps1
```

This will automatically test all CRUD operations.

---

## 💡 STEP 9 - NoSQL Features & Demo (5 marks)

### 1. **Flexible Schema Demo**

**Action:**
1. In Postman, create a **POST** to `http://localhost:3000/patients`
2. Send this patient with **minimal fields**:
```json
{
  "name": "Priya Sharma",
  "age": 28
}
```
3. Send another patient with **extra fields**:
```json
{
  "name": "Rohit Singh",
  "age": 42,
  "gender": "male",
  "phone": "8888888888",
  "email": "rohit@demo.com",
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
  ],
  "emergencyContact": "9876543210",
  "bloodGroup": "O+"
}
```
4. **📸 Take screenshot** showing both requests and responses
5. **Explain in report:** "MongoDB allows different patients to have different fields - no schema migration needed!"

### 2. **Embedding Demo**

**Action:**
1. Get the patient with medicalHistory (from above)
2. In Postman, **GET** `http://localhost:3000/patients/YOUR_PATIENT_ID`
3. **📸 Take screenshot** showing the medicalHistory array embedded in the patient document
4. **Explain in report:** "Medical history is embedded as an array within the patient document, enabling fast single-document reads without joins."

### 3. **Referencing Demo**

**Action:**
1. First, create a doctor:
   - **POST** to `http://localhost:3000/doctors`
   - Body:
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
   - **Copy the doctor's `_id`**

2. Create an appointment:
   - **POST** to `http://localhost:3000/appointments`
   - Body (use your patient ID and doctor ID):
```json
{
  "patientId": "YOUR_PATIENT_ID",
  "doctorId": "YOUR_DOCTOR_ID",
  "appointmentDate": "2025-11-15",
  "appointmentTime": "10:00 AM",
  "status": "scheduled",
  "notes": "Routine checkup"
}
```

3. Get the appointment:
   - **GET** `http://localhost:3000/appointments/YOUR_APPOINTMENT_ID`
   - You should see `patientId` and `doctorId` as references
   - The response will also show populated patient and doctor data

4. **📸 Take screenshot** showing appointment with references
5. **Explain in report:** "Appointments use ObjectId references to link patients and doctors, maintaining normalized relationships."

### 4. **Aggregation Demo**

**Action:**
1. **Option A - Using MongoDB Compass:**
   - Open MongoDB Compass
   - Connect to: `mongodb://localhost:27017`
   - Navigate to `medicaldb` database
   - Go to `patients` collection
   - Click **Aggregations** tab
   - Add stage: `$group`
   - Configure:
     - `_id`: `$gender`
     - `total`: `{ $sum: 1 }`
   - Click **Run**
   - **📸 Take screenshot** of results

2. **Option B - Using mongosh (if accessible):**
   ```javascript
   mongosh
   use medicaldb
   db.patients.aggregate([
     { $group: { _id: "$gender", total: { $sum: 1 } } }
   ])
   ```
   - **📸 Take screenshot** of terminal output

3. **Explain in report:** "MongoDB aggregation pipeline provides built-in analytics capabilities without external tools."

### 5. **Indexing Demo**

**Action:**
1. **Using MongoDB Compass:**
   - Go to `patients` collection
   - Click **Indexes** tab
   - Click **Create Index**
   - Field: `name`
   - Order: `1` (ascending)
   - Click **Create**
   - **📸 Take screenshot** showing indexes

2. **Explain in report:** "Indexes on frequently queried fields (like name) improve search speed significantly."

---

## 🧱 STEP 10 - Extra Credit: Aggregation Example

### Find Total Patients Per Gender

**Using MongoDB Compass:**
1. Open `medicaldb` → `patients` collection
2. Click **Aggregations** tab
3. Add `$group` stage:
   ```json
   {
     "_id": "$gender",
     "total": { "$sum": 1 }
   }
   ```
4. Click **Run**
5. **📸 Take screenshot** showing results like:
   ```
   { "_id": "male", "total": 2 }
   { "_id": "female", "total": 1 }
   ```

**Using mongosh (if available):**
```javascript
use medicaldb
db.patients.aggregate([
  { $group: { _id: "$gender", total: { $sum: 1 } } }
])
```

**📸 Take screenshot** of results

---

## 📊 STEP 11 - Report Structure

### Section 1: Introduction
**What to write:**
- Describe your medical app (patient, doctor, appointment management)
- Explain why MongoDB suits this application:
  - Flexible schema for varying medical records
  - Embedded documents for medical history
  - Document model matches real-world data structure
  - Easy to scale

### Section 2: Setup & Configuration
**What to include:**
- 📸 Screenshot of MongoDB Compass connected to localhost:27017
- 📸 Screenshot of terminal showing:
  - `node server.js` output
  - "✅ MongoDB connected"
  - "🚀 Server running on http://localhost:3000"
- Brief explanation of installation steps

### Section 3: Data Model
**What to include:**
- **Schema Diagram** (text or image):
  ```
  Patient {
    _id: ObjectId
    name: String
    age: Number
    gender: String
    phone: String
    email: String
    address: String
    medicalHistory: [           ← EMBEDDING
      {
        condition: String
        diagnosedOn: Date
        notes: String
      }
    ]
    createdAt: Date
    updatedAt: Date
  }

  Appointment {
    _id: ObjectId
    patientId: ObjectId         ← REFERENCING
    doctorId: ObjectId          ← REFERENCING
    appointmentDate: Date
    ...
  }
  ```
- **Explain:**
  - Embedding: `medicalHistory` array inside patients
  - Referencing: `patientId` and `doctorId` in appointments
  - Benefits of each approach

### Section 4: CRUD Operations
**What to include:**
- 📸 Screenshot of **POST** `/patients` (Create)
- 📸 Screenshot of **GET** `/patients` (Read All)
- 📸 Screenshot of **GET** `/patients/:id` (Read One)
- 📸 Screenshot of **PUT** `/patients/:id` (Update)
- 📸 Screenshot of **DELETE** `/patients/:id` (Delete)
- Brief explanation of each operation

### Section 5: NoSQL Features
**What to include:**
- 📸 Screenshot of flexible schema (different patient structures)
- 📸 Screenshot of embedding (medicalHistory array)
- 📸 Screenshot of referencing (appointments with ObjectIds)
- 📸 Screenshot of aggregation query and results
- 📸 Screenshot of indexing
- Table showing features, demonstrations, and advantages

### Section 6: Conclusion
**What to write:**
- Summary of what you learned
- Benefits of using MongoDB vs SQL for medical data
- Challenges faced (if any)
- Future improvements

---

## ✅ Quick Checklist

### Before Starting:
- [ ] Server is running (`node server.js`)
- [ ] Postman installed (or PowerShell ready)
- [ ] MongoDB Compass installed and connected

### Testing:
- [ ] Created patient via POST
- [ ] Retrieved all patients via GET
- [ ] Retrieved one patient via GET/:id
- [ ] Updated patient via PUT
- [ ] Deleted patient via DELETE
- [ ] Created doctor
- [ ] Created appointment with references

### Documentation:
- [ ] Screenshots of all CRUD operations
- [ ] Screenshot of MongoDB Compass showing database
- [ ] Screenshot of flexible schema demo
- [ ] Screenshot of aggregation results
- [ ] Screenshot of indexing

### Report:
- [ ] Introduction written
- [ ] Setup section with screenshots
- [ ] Data model diagram created
- [ ] CRUD section with screenshots
- [ ] NoSQL features explained
- [ ] Conclusion written

---

## 🚀 Quick Start Commands

### Start Server
```powershell
node server.js
```

### Test API (PowerShell)
```powershell
.\test-api.ps1
```

### MongoDB Compass Connection String
```
mongodb://localhost:27017
```

---

## 🆘 Troubleshooting

### Server won't start?
- Check if MongoDB service is running: `Get-Service MongoDB`
- Verify `.env` file exists with correct `MONGO_URI`

### Can't connect to MongoDB?
- Ensure MongoDB service is started: `net start MongoDB`
- Check port 27017 is not blocked

### Postman requests fail?
- Ensure server is running (`node server.js`)
- Check URL is correct: `http://localhost:3000/patients`
- Verify Content-Type header is `application/json` for POST/PUT

---

**Good luck with your report! 🎉**




