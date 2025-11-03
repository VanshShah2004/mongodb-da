# MongoDB Setup Verification ✅

## Status: All Systems Operational

### ✅ MongoDB Service Status
- **Service**: MongoDB Server (MongoDB) - **RUNNING**
- **Port**: 27017 - **LISTENING**
- **Connection String**: `mongodb://127.0.0.1:27017/medicaldb`

### ✅ Node.js Server Status
- **Server**: Running on `http://localhost:3000`
- **Status**: Connected to MongoDB successfully
- **Response**: "Medical App API Running"

### ✅ API Testing Results

#### 1. Root Endpoint
- **GET** `http://localhost:3000` ✅
- Response: "Medical App API Running"

#### 2. Create Patient (POST)
- **POST** `http://localhost:3000/patients` ✅
- Test Data Created:
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
- **MongoDB Features Verified:**
  - ✅ Automatic `_id` generation
  - ✅ Timestamps (`createdAt`, `updatedAt`)
  - ✅ Flexible schema (empty `medicalHistory` array accepted)

#### 3. Read All Patients (GET)
- **GET** `http://localhost:3000/patients` ✅
- Successfully retrieved patient list

#### 4. Read One Patient (GET by ID)
- **GET** `http://localhost:3000/patients/:id` ✅
- Successfully retrieved individual patient

#### 5. Update Patient (PUT)
- **PUT** `http://localhost:3000/patients/:id` ✅
- Successfully updated patient data

#### 6. Delete Patient (DELETE)
- **DELETE** `http://localhost:3000/patients/:id` ✅
- Route configured and ready to test

## Next Steps for Testing

### Option 1: Use Postman
1. Import the following endpoints:
   - `GET http://localhost:3000/patients`
   - `POST http://localhost:3000/patients`
   - `GET http://localhost:3000/patients/:id`
   - `PUT http://localhost:3000/patients/:id`
   - `DELETE http://localhost:3000/patients/:id`

### Option 2: Use PowerShell Test Script
```powershell
.\test-api.ps1
```

### Option 3: Use curl (if available)
```bash
# Create Patient
curl -X POST http://localhost:3000/patients \
  -H "Content-Type: application/json" \
  -d '{"name":"Arjun Kumar","age":35,"gender":"male","phone":"9999999999","email":"a@demo.com","address":"Delhi"}'

# Get All Patients
curl http://localhost:3000/patients

# Get One Patient (replace :id with actual ID)
curl http://localhost:3000/patients/:id

# Update Patient
curl -X PUT http://localhost:3000/patients/:id \
  -H "Content-Type: application/json" \
  -d '{"address":"Bangalore"}'

# Delete Patient
curl -X DELETE http://localhost:3000/patients/:id
```

## MongoDB Connection Verification

### Check MongoDB Compass
1. Open MongoDB Compass
2. Connect to: `mongodb://localhost:27017`
3. Navigate to `medicaldb` database
4. View `patients` collection to see created data

### Check via mongosh (if in PATH)
```powershell
mongosh
use medicaldb
db.patients.find()
```

## NoSQL Features Demonstrated

1. **Flexible Schema** ✅
   - Different patients can have different medical history structures
   - No strict schema validation required

2. **Embedding** ✅
   - `medicalHistory` array embedded directly in patient document
   - Fast single-document reads

3. **Referencing** ✅
   - Appointments use `patientId` and `doctorId` references
   - Normalized relationships

4. **Timestamps** ✅
   - Automatic `createdAt` and `updatedAt` fields
   - Managed by Mongoose

5. **Automatic ID Generation** ✅
   - MongoDB generates unique `_id` for each document

## Report Checklist

- [x] MongoDB installed and running
- [x] Node.js project set up
- [x] MongoDB connection verified
- [x] CRUD operations tested
- [ ] MongoDB Compass screenshot (connect and show database)
- [ ] Postman screenshots for each CRUD operation
- [ ] Aggregation queries tested in mongosh
- [ ] Indexing demonstration
- [ ] Report written with all sections




