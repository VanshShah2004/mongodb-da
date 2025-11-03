# MongoDB Queries for CRUD Verification

This guide shows you how to write MongoDB queries directly to verify your CRUD operations in the database.

---

## Method 1: Using MongoDB Compass (GUI - Recommended)

### Step 1: Connect to MongoDB
1. Open MongoDB Compass
2. Connect to: `mongodb://localhost:27017`
3. Navigate to `medicaldb` database
4. Click on `patients` collection

---

## Method 2: Using MongoDB Shell (mongosh)

### Step 1: Open MongoDB Shell
```powershell
mongosh
```

### Step 2: Switch to Your Database
```javascript
use medicaldb
```

---

## CRUD Operations - MongoDB Queries vs API

### 1. CREATE - Insert Patient

#### API Call:
```
POST http://localhost:3000/patients
Body: {
  "name": "Arjun Kumar",
  "age": 35,
  "gender": "male",
  "phone": "9999999999",
  "email": "a@demo.com",
  "address": "Delhi"
}
```

#### MongoDB Query (Direct Insert):
```javascript
// Insert single document
db.patients.insertOne({
  name: "Arjun Kumar",
  age: 35,
  gender: "male",
  phone: "9999999999",
  email: "a@demo.com",
  address: "Delhi",
  medicalHistory: []
})

// Insert multiple documents
db.patients.insertMany([
  {
    name: "Priya Sharma",
    age: 28,
    gender: "female",
    phone: "8888888888",
    email: "priya@demo.com",
    address: "Mumbai"
  },
  {
    name: "Rohit Singh",
    age: 42,
    gender: "male",
    phone: "7777777777",
    email: "rohit@demo.com",
    address: "Bangalore"
  }
])
```

#### Verify in Compass:
1. Refresh the collection view
2. You should see the new document(s)
3. Check all fields are present
4. Note the auto-generated `_id` field

---

### 2. READ - Find All Patients

#### API Call:
```
GET http://localhost:3000/patients
```

#### MongoDB Query (Find All):
```javascript
// Get all patients
db.patients.find()

// Get all patients (formatted/prettier)
db.patients.find().pretty()

// Count total patients
db.patients.find().count()
// or
db.patients.countDocuments()
```

#### Verify:
- Should return array of all patient documents
- Each document has `_id`, fields, and timestamps

---

### 3. READ - Find Patient by ID

#### API Call:
```
GET http://localhost:3000/patients/6908617a3441e175d71a9d31
```

#### MongoDB Query (Find by ID):
```javascript
// Find by ObjectId (replace with actual ID)
db.patients.findOne({ _id: ObjectId("6908617a3441e175d71a9d31") })

// Or use find (returns array)
db.patients.find({ _id: ObjectId("6908617a3441e175d71a9d31") })

// Find by ID (simpler - MongoDB handles conversion)
db.patients.findById("6908617a3441e175d71a9d31")
```

#### Verify:
- Should return single patient document
- All fields should match what you created

---

### 4. READ - Find with Filters (Advanced)

```javascript
// Find patients by age
db.patients.find({ age: 35 })

// Find patients by gender
db.patients.find({ gender: "male" })

// Find patients with age greater than 30
db.patients.find({ age: { $gt: 30 } })

// Find patients by name (case-insensitive)
db.patients.find({ name: { $regex: /arjun/i } })

// Find patients with specific address
db.patients.find({ address: "Delhi" })

// Find patients with medical history
db.patients.find({ "medicalHistory.0": { $exists: true } })

// Combine filters (AND condition)
db.patients.find({ 
  gender: "male",
  age: { $gte: 30 }
})

// OR condition
db.patients.find({
  $or: [
    { address: "Delhi" },
    { address: "Bangalore" }
  ]
})
```

---

### 5. UPDATE - Update Patient

#### API Call:
```
PUT http://localhost:3000/patients/6908617a3441e175d71a9d31
Body: {
  "address": "Bangalore",
  "phone": "8888888888"
}
```

#### MongoDB Query (Update):
```javascript
// Update one document
db.patients.updateOne(
  { _id: ObjectId("6908617a3441e175d71a9d31") },
  { 
    $set: { 
      address: "Bangalore",
      phone: "8888888888"
    } 
  }
)

// Update and return the updated document
db.patients.findOneAndUpdate(
  { _id: ObjectId("6908617a3441e175d71a9d31") },
  { 
    $set: { 
      address: "Bangalore",
      phone: "8888888888"
    } 
  },
  { returnDocument: "after" }  // Returns updated document
)

// Update multiple documents (all patients in Delhi)
db.patients.updateMany(
  { address: "Delhi" },
  { 
    $set: { 
      address: "New Delhi"
    } 
  }
)

// Add to array (medical history)
db.patients.updateOne(
  { _id: ObjectId("6908617a3441e175d71a9d31") },
  { 
    $push: { 
      medicalHistory: {
        condition: "Diabetes",
        diagnosedOn: new Date("2020-01-15"),
        notes: "Type 2"
      }
    } 
  }
)

// Increment age
db.patients.updateOne(
  { _id: ObjectId("6908617a3441e175d71a9d31") },
  { 
    $inc: { 
      age: 1 
    } 
  }
)
```

#### Verify:
1. Before update: Note the current values
2. Run the update query
3. After update: Query again to see changed values
4. In Compass: Refresh and check the document

---

### 6. DELETE - Delete Patient

#### API Call:
```
DELETE http://localhost:3000/patients/6908617a3441e175d71a9d31
```

#### MongoDB Query (Delete):
```javascript
// Delete one document
db.patients.deleteOne({ _id: ObjectId("6908617a3441e175d71a9d31") })

// Delete and return the deleted document
db.patients.findOneAndDelete({ _id: ObjectId("6908617a3441e175d71a9d31") })

// Delete multiple documents
db.patients.deleteMany({ address: "Delhi" })

// Delete all documents (careful!)
db.patients.deleteMany({})
```

#### Verify:
1. Before delete: Note the count
   ```javascript
   db.patients.countDocuments()
   ```
2. Run delete query
3. After delete: Check count again
   ```javascript
   db.patients.countDocuments()
   ```
4. In Compass: Refresh, document should be gone

---

## Complete Verification Workflow

### Step 1: Check Initial State
```javascript
// Count documents
db.patients.countDocuments()

// View all documents
db.patients.find().pretty()
```

### Step 2: Insert Test Data
```javascript
db.patients.insertOne({
  name: "Test Patient",
  age: 25,
  gender: "male",
  phone: "1234567890",
  email: "test@demo.com",
  address: "Test City"
})
```

### Step 3: Verify Insert
```javascript
// Should return 1
db.patients.countDocuments()

// Should show the new document
db.patients.find({ name: "Test Patient" })
```

### Step 4: Update the Document
```javascript
db.patients.updateOne(
  { name: "Test Patient" },
  { $set: { address: "Updated City" } }
)
```

### Step 5: Verify Update
```javascript
// Should show updated address
db.patients.findOne({ name: "Test Patient" })
```

### Step 6: Delete the Document
```javascript
db.patients.deleteOne({ name: "Test Patient" })
```

### Step 7: Verify Delete
```javascript
// Should return 0
db.patients.find({ name: "Test Patient" }).count()

// Or check count decreased
db.patients.countDocuments()
```

---

## Advanced MongoDB Queries for Verification

### Aggregation Queries

```javascript
// Count patients by gender
db.patients.aggregate([
  {
    $group: {
      _id: "$gender",
      total: { $sum: 1 }
    }
  }
])

// Average age by gender
db.patients.aggregate([
  {
    $group: {
      _id: "$gender",
      averageAge: { $avg: "$age" },
      total: { $sum: 1 }
    }
  }
])

// Patients with medical history count
db.patients.aggregate([
  {
    $project: {
      name: 1,
      medicalHistoryCount: { $size: { $ifNull: ["$medicalHistory", []] } }
    }
  }
])

// Sort patients by age (descending)
db.patients.find().sort({ age: -1 })

// Limit results
db.patients.find().limit(5)

// Skip and limit (pagination)
db.patients.find().skip(0).limit(10)
```

---

## Verify API vs Database Sync

### Test Flow:

1. **Create via API:**
   ```
   POST http://localhost:3000/patients
   Body: { "name": "API Patient", "age": 30 }
   ```
   - Note the returned `_id`

2. **Verify in MongoDB:**
   ```javascript
   db.patients.findOne({ name: "API Patient" })
   ```
   - Should return the document with same `_id`

3. **Update via API:**
   ```
   PUT http://localhost:3000/patients/{id}
   Body: { "age": 31 }
   ```

4. **Verify in MongoDB:**
   ```javascript
   db.patients.findOne({ _id: ObjectId("{id}") })
   ```
   - Age should be 31

5. **Delete via API:**
   ```
   DELETE http://localhost:3000/patients/{id}
   ```

6. **Verify in MongoDB:**
   ```javascript
   db.patients.findOne({ _id: ObjectId("{id}") })
   ```
   - Should return `null` (document deleted)

---

## MongoDB Compass Queries

### Using Compass Filter Tab:

1. **Filter All:**
   - Click "Filter" tab
   - Leave empty or use: `{}`
   - Click "Find"

2. **Filter by Field:**
   - Filter: `{ "gender": "male" }`
   - Shows only male patients

3. **Filter by Age:**
   - Filter: `{ "age": { "$gt": 30 } }`
   - Shows patients older than 30

4. **Project (Select Fields):**
   - Project: `{ "name": 1, "age": 1, "_id": 0 }`
   - Shows only name and age

5. **Sort:**
   - Sort: `{ "age": -1 }`
   - Sorts by age descending

---

## Useful MongoDB Commands Reference

```javascript
// Show all databases
show dbs

// Switch database
use medicaldb

// Show collections in current database
show collections

// Show indexes
db.patients.getIndexes()

// Create index
db.patients.createIndex({ name: 1 })

// Remove index
db.patients.dropIndex("name_1")

// Collection stats
db.patients.stats()

// Explain query execution
db.patients.find({ age: 35 }).explain()

// Get document count
db.patients.countDocuments()

// Get estimated document count (faster)
db.patients.estimatedDocumentCount()
```

---

## Verification Checklist

After running CRUD operations via API, verify in MongoDB:

### CREATE Verification:
- [ ] Document appears in `patients` collection
- [ ] `_id` is auto-generated
- [ ] `createdAt` and `updatedAt` timestamps present
- [ ] All fields match request body

### READ Verification:
- [ ] `find()` returns all documents
- [ ] `findById()` returns correct document
- [ ] Count matches number of created documents

### UPDATE Verification:
- [ ] Document fields updated correctly
- [ ] `updatedAt` timestamp changed
- [ ] `createdAt` timestamp unchanged
- [ ] Other fields unchanged (if not updated)

### DELETE Verification:
- [ ] Document removed from collection
- [ ] Count decreased
- [ ] `findById()` returns null
- [ ] Other documents unaffected

---

## Quick Test Script

Run this in mongosh to test all operations:

```javascript
// Connect
use medicaldb

// 1. CREATE - Insert
db.patients.insertOne({
  name: "MongoDB Test",
  age: 25,
  gender: "male",
  phone: "9999999999",
  email: "test@mongo.com",
  address: "Test City"
})

// Save the ID
var patientId = db.patients.findOne({ name: "MongoDB Test" })._id

// 2. READ - Find All
print("Total patients:", db.patients.countDocuments())

// 3. READ - Find One
printjson(db.patients.findOne({ _id: patientId }))

// 4. UPDATE - Update
db.patients.updateOne(
  { _id: patientId },
  { $set: { address: "Updated City", age: 26 } }
)

// Verify update
printjson(db.patients.findOne({ _id: patientId }))

// 5. DELETE - Delete
db.patients.deleteOne({ _id: patientId })

// Verify delete
print("After delete - Total patients:", db.patients.countDocuments())
print("Document exists:", db.patients.findOne({ _id: patientId }))
```

---

## Common Verification Queries

```javascript
// Check if collection exists and has data
db.getCollectionNames()  // Should include "patients"
db.patients.countDocuments()  // Should be > 0

// View latest document
db.patients.find().sort({ createdAt: -1 }).limit(1)

// Check for specific patient
db.patients.find({ name: "Arjun Kumar" })

// Verify timestamps
db.patients.find({
  createdAt: { $exists: true },
  updatedAt: { $exists: true }
}).count()

// Find documents updated in last hour
db.patients.find({
  updatedAt: {
    $gte: new Date(Date.now() - 3600000)
  }
})
```

---

This guide covers all MongoDB queries you need to verify your CRUD operations! Use MongoDB Compass for visual verification or mongosh for command-line queries.

