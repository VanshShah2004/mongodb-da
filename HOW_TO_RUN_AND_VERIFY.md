# How to Run and Verify CRUD Operations

## Prerequisites

1. MongoDB must be running
2. Node.js installed
3. All dependencies installed (npm install)

---

## Step 1: Start MongoDB Service

### On Windows (PowerShell):
```powershell
net start MongoDB
```

### Verify MongoDB is Running:
```powershell
Get-Service MongoDB
```
Should show: **Status: Running**

---

## Step 2: Start the Server

### Open Terminal/PowerShell in Project Directory:
```powershell
cd C:\Users\Vansh\OneDrive\Desktop\mongodb-da
```

### Start the Server:
```powershell
node server.js
```

### Expected Output:
```
✅ MongoDB connected
🚀 Server running on http://localhost:3000
```

**Keep this terminal window open!**

---

## Step 3: Verify CRUD Operations

### Method 1: Using Postman (Recommended)

#### 3.1 Install Postman
- Download from: https://www.postman.com/downloads/
- Install and open Postman

#### 3.2 Test CREATE (POST)

**Request Setup:**
1. Method: **POST**
2. URL: `http://localhost:3000/patients`
3. Headers: 
   - Key: `Content-Type`
   - Value: `application/json`
4. Body: Select **raw** → **JSON**

**Request Body:**
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

**Click Send**

**Expected Response (201 Created):**
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
  "createdAt": "2025-11-03T08:02:02.690Z",
  "updatedAt": "2025-11-03T08:02:02.690Z",
  "__v": 0
}
```

**Verify:**
- Status: 201 Created
- Response contains `_id` field
- Response contains all submitted fields
- `createdAt` and `updatedAt` are auto-generated

**IMPORTANT:** Copy the `_id` value from response - you'll need it for next steps!

---

#### 3.3 Test READ ALL (GET)

**Request Setup:**
1. Method: **GET**
2. URL: `http://localhost:3000/patients`
3. No body needed

**Click Send**

**Expected Response (200 OK):**
```json
[
  {
    "_id": "6908617a3441e175d71a9d31",
    "name": "Arjun Kumar",
    "age": 35,
    "gender": "male",
    "phone": "9999999999",
    "email": "a@demo.com",
    "address": "Delhi",
    "medicalHistory": [],
    "createdAt": "2025-11-03T08:02:02.690Z",
    "updatedAt": "2025-11-03T08:02:02.690Z",
    "__v": 0
  }
]
```

**Verify:**
- Status: 200 OK
- Response is an array
- Array contains the patient you just created

---

#### 3.4 Test READ ONE (GET by ID)

**Request Setup:**
1. Method: **GET**
2. URL: `http://localhost:3000/patients/YOUR_PATIENT_ID`
   - Replace `YOUR_PATIENT_ID` with the `_id` from step 3.2
   - Example: `http://localhost:3000/patients/6908617a3441e175d71a9d31`

**Click Send**

**Expected Response (200 OK):**
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
  "createdAt": "2025-11-03T08:02:02.690Z",
  "updatedAt": "2025-11-03T08:02:02.690Z",
  "__v": 0
}
```

**Verify:**
- Status: 200 OK
- Response contains single patient object
- Matches the patient from step 3.2

**Test Error Case:**
- Use invalid ID: `http://localhost:3000/patients/invalid123`
- Expected: Status 500 with error message

---

#### 3.5 Test UPDATE (PUT)

**Request Setup:**
1. Method: **PUT**
2. URL: `http://localhost:3000/patients/YOUR_PATIENT_ID`
   - Use the same `_id` from step 3.2
3. Headers: 
   - Key: `Content-Type`
   - Value: `application/json`
4. Body: Select **raw** → **JSON**

**Request Body:**
```json
{
  "address": "Bangalore",
  "phone": "8888888888"
}
```

**Click Send**

**Expected Response (200 OK):**
```json
{
  "_id": "6908617a3441e175d71a9d31",
  "name": "Arjun Kumar",
  "age": 35,
  "gender": "male",
  "phone": "8888888888",
  "email": "a@demo.com",
  "address": "Bangalore",
  "medicalHistory": [],
  "createdAt": "2025-11-03T08:02:02.690Z",
  "updatedAt": "2025-11-03T08:03:15.123Z",
  "__v": 0
}
```

**Verify:**
- Status: 200 OK
- `address` changed from "Delhi" to "Bangalore"
- `phone` changed from "9999999999" to "8888888888"
- `updatedAt` timestamp is newer than `createdAt`

**Test Error Case:**
- Use non-existent ID: `http://localhost:3000/patients/000000000000000000000000`
- Expected: Status 404 with message "Patient not found"

---

#### 3.6 Test DELETE (DELETE)

**Request Setup:**
1. Method: **DELETE**
2. URL: `http://localhost:3000/patients/YOUR_PATIENT_ID`
   - Use the same `_id` from previous steps

**Click Send**

**Expected Response (200 OK):**
```json
{
  "message": "Patient deleted successfully"
}
```

**Verify:**
- Status: 200 OK
- Response contains success message

**Verify Deletion:**
- Run GET ALL again: `http://localhost:3000/patients`
- The deleted patient should NOT appear in the array
- Expected: Empty array `[]` if it was the only patient

**Test Error Case:**
- Use non-existent ID: `http://localhost:3000/patients/000000000000000000000000`
- Expected: Status 404 with message "Patient not found"

---

### Method 2: Using PowerShell

#### 3.1 CREATE (POST)
```powershell
$body = @{
    name = "Arjun Kumar"
    age = 35
    gender = "male"
    phone = "9999999999"
    email = "a@demo.com"
    address = "Delhi"
} | ConvertTo-Json

$response = Invoke-WebRequest -Uri "http://localhost:3000/patients" -Method POST -Body $body -ContentType "application/json" -UseBasicParsing
$response.Content | ConvertFrom-Json | ConvertTo-Json -Depth 10

# Save the ID
$patient = $response.Content | ConvertFrom-Json
$patientId = $patient._id
Write-Host "Patient ID: $patientId"
```

**Verify Output:**
- Should show patient object with `_id`
- Status should be 201

---

#### 3.2 READ ALL (GET)
```powershell
$response = Invoke-WebRequest -Uri "http://localhost:3000/patients" -Method GET -UseBasicParsing
$response.Content | ConvertFrom-Json | ConvertTo-Json -Depth 10
Write-Host "Status: $($response.StatusCode)"
```

**Verify Output:**
- Status: 200
- Array of patients displayed

---

#### 3.3 READ ONE (GET by ID)
```powershell
# Use the $patientId from step 3.1
$response = Invoke-WebRequest -Uri "http://localhost:3000/patients/$patientId" -Method GET -UseBasicParsing
$response.Content | ConvertFrom-Json | ConvertTo-Json -Depth 10
```

**Verify Output:**
- Status: 200
- Single patient object displayed

---

#### 3.4 UPDATE (PUT)
```powershell
$body = @{
    address = "Bangalore"
    phone = "8888888888"
} | ConvertTo-Json

$response = Invoke-WebRequest -Uri "http://localhost:3000/patients/$patientId" -Method PUT -Body $body -ContentType "application/json" -UseBasicParsing
$response.Content | ConvertFrom-Json | ConvertTo-Json -Depth 10
```

**Verify Output:**
- Status: 200
- Updated patient with new address and phone

---

#### 3.5 DELETE (DELETE)
```powershell
$response = Invoke-WebRequest -Uri "http://localhost:3000/patients/$patientId" -Method DELETE -UseBasicParsing
$response.Content
Write-Host "Status: $($response.StatusCode)"
```

**Verify Output:**
- Status: 200
- Message: "Patient deleted successfully"

---

### Method 3: Using curl (if available)

#### 3.1 CREATE (POST)
```bash
curl -X POST http://localhost:3000/patients \
  -H "Content-Type: application/json" \
  -d "{\"name\":\"Arjun Kumar\",\"age\":35,\"gender\":\"male\",\"phone\":\"9999999999\",\"email\":\"a@demo.com\",\"address\":\"Delhi\"}"
```

#### 3.2 READ ALL (GET)
```bash
curl http://localhost:3000/patients
```

#### 3.3 READ ONE (GET by ID)
```bash
curl http://localhost:3000/patients/6908617a3441e175d71a9d31
```

#### 3.4 UPDATE (PUT)
```bash
curl -X PUT http://localhost:3000/patients/6908617a3441e175d71a9d31 \
  -H "Content-Type: application/json" \
  -d "{\"address\":\"Bangalore\"}"
```

#### 3.5 DELETE (DELETE)
```bash
curl -X DELETE http://localhost:3000/patients/6908617a3441e175d71a9d31
```

---

## Step 4: Verify in MongoDB Compass (Optional)

### 4.1 Open MongoDB Compass
1. Open MongoDB Compass application
2. Connect to: `mongodb://localhost:27017`

### 4.2 Navigate to Database
1. Click on `medicaldb` database
2. Click on `patients` collection
3. View documents

### 4.3 Verify Data
- Should see all created patients
- Can verify field values
- Can see `_id`, `createdAt`, `updatedAt` fields

---

## Step 5: Test Complete Flow

### Complete Test Sequence:

1. **Create Patient 1:**
   - POST `http://localhost:3000/patients`
   - Body: `{"name":"Arjun Kumar","age":35,"gender":"male","phone":"9999999999","email":"a@demo.com","address":"Delhi"}`
   - Save `_id` as `patientId1`

2. **Create Patient 2:**
   - POST `http://localhost:3000/patients`
   - Body: `{"name":"Priya Sharma","age":28,"gender":"female","phone":"8888888888","email":"priya@demo.com","address":"Mumbai"}`
   - Save `_id` as `patientId2`

3. **Get All Patients:**
   - GET `http://localhost:3000/patients`
   - Verify: Should see 2 patients

4. **Get Patient 1 by ID:**
   - GET `http://localhost:3000/patients/{patientId1}`
   - Verify: Correct patient data

5. **Update Patient 1:**
   - PUT `http://localhost:3000/patients/{patientId1}`
   - Body: `{"address":"Bangalore"}`
   - Verify: Address updated

6. **Get All Patients Again:**
   - GET `http://localhost:3000/patients`
   - Verify: Patient 1 has updated address

7. **Delete Patient 2:**
   - DELETE `http://localhost:3000/patients/{patientId2}`
   - Verify: Success message

8. **Get All Patients Final:**
   - GET `http://localhost:3000/patients`
   - Verify: Only Patient 1 remains

---

## Troubleshooting

### Server won't start?
- Check MongoDB is running: `net start MongoDB`
- Check port 3000 is not in use
- Verify `.env` file exists with correct `MONGO_URI`

### Connection errors?
- Verify MongoDB service: `Get-Service MongoDB`
- Check MongoDB is listening: `netstat -an | Select-String "27017"`

### 404 errors?
- Verify server is running
- Check URL is correct: `http://localhost:3000/patients`
- Verify `_id` is correct (24 character hex string)

### 400/500 errors?
- Check request body is valid JSON
- Verify Content-Type header is `application/json`
- Check server console for error messages

---

## Expected Results Summary

| Operation | Method | URL | Status | Response |
|-----------|--------|-----|--------|----------|
| Create | POST | /patients | 201 | Patient object with `_id` |
| Read All | GET | /patients | 200 | Array of patients |
| Read One | GET | /patients/:id | 200 | Single patient object |
| Update | PUT | /patients/:id | 200 | Updated patient object |
| Delete | DELETE | /patients/:id | 200 | Success message |

---

## Quick Verification Checklist

- [ ] MongoDB service running
- [ ] Server started successfully
- [ ] POST creates patient (201 status)
- [ ] GET all returns array (200 status)
- [ ] GET by ID returns single patient (200 status)
- [ ] PUT updates patient correctly (200 status)
- [ ] DELETE removes patient (200 status)
- [ ] Error handling works (404 for not found)
- [ ] Data persists in MongoDB
- [ ] Timestamps auto-generated correctly

---

**All operations are now ready to test! Start with step 1 and work through each operation sequentially.**

