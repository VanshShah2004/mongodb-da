# ✅ Quick Checklist - MongoDB Medical App

## 📌 Current Status
- ✅ MongoDB installed and running
- ✅ Server running on port 3000
- ✅ All files created

---

## 🎯 What You Need to Do Now

### Step 1: Ensure Server is Running ⚠️
```powershell
# If server stopped, restart it:
node server.js
```
**Keep this terminal window open!**

---

### Step 2: Install Postman (if not done)
- Download: https://www.postman.com/downloads/
- Install and open

---

### Step 3: Test CRUD Operations 📸

#### ✅ CREATE Patient
- **POST** `http://localhost:3000/patients`
- Body (JSON):
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
- **📸 Screenshot required!**

#### ✅ READ All Patients
- **GET** `http://localhost:3000/patients`
- **📸 Screenshot required!**

#### ✅ READ One Patient
- **GET** `http://localhost:3000/patients/YOUR_ID`
- Replace YOUR_ID with actual ID from CREATE response
- **📸 Screenshot required!**

#### ✅ UPDATE Patient
- **PUT** `http://localhost:3000/patients/YOUR_ID`
- Body (JSON):
```json
{
  "address": "Bangalore"
}
```
- **📸 Screenshot required!**

#### ✅ DELETE Patient
- **DELETE** `http://localhost:3000/patients/YOUR_ID`
- **📸 Screenshot required!**

---

### Step 4: Demonstrate NoSQL Features 📸

#### ✅ Flexible Schema
- Create patient with minimal fields
- Create patient with extra fields
- **📸 Screenshot showing both**

#### ✅ Embedding
- Show medicalHistory array in patient document
- **📸 Screenshot**

#### ✅ Referencing
- Create doctor → Create appointment with patientId/doctorId
- **📸 Screenshot**

#### ✅ Aggregation
- MongoDB Compass → Aggregations tab
- Run: `{ $group: { _id: "$gender", total: { $sum: 1 } } }`
- **📸 Screenshot**

#### ✅ Indexing
- MongoDB Compass → Indexes tab
- Create index on "name" field
- **📸 Screenshot**

---

### Step 5: MongoDB Compass Setup 📸

1. Open MongoDB Compass
2. Connect to: `mongodb://localhost:27017`
3. Navigate to `medicaldb` database
4. View `patients` collection
5. **📸 Screenshot of connection and data**

---

### Step 6: Write Report

**Sections:**
1. ✅ Introduction
2. ✅ Setup & Configuration (with screenshots)
3. ✅ Data Model (with diagram)
4. ✅ CRUD Operations (with Postman screenshots)
5. ✅ NoSQL Features (with demonstrations)
6. ✅ Conclusion

---

## 🎬 Start Here:

1. **Open Postman**
2. **Test each CRUD operation** (take screenshots!)
3. **Open MongoDB Compass** (take screenshots!)
4. **Write your report** using screenshots

---

## 💡 Pro Tips

- Keep server running in one terminal window
- Use Postman Collection to save all requests
- Take screenshots as you go (don't wait until the end!)
- Test everything before writing the report

---

**Time Estimate: 2-3 hours for testing + screenshots + report**

Good luck! 🚀




