# MongoDB Terminal CRUD Operations

Complete guide for running CRUD operations directly in MongoDB shell (mongosh).

---

## Prerequisites

### Open MongoDB Shell
```powershell
mongosh
```

### Connect to Your Database
```javascript
use medicaldb
```

---

## 1. CREATE Operations

### Insert Single Document
```javascript
// Insert one patient
db.patients.insertOne({
  name: "Arjun Kumar",
  age: 35,
  gender: "male",
  phone: "9999999999",
  email: "a@demo.com",
  address: "Delhi",
  medicalHistory: []
})
```

**Response:**
```javascript
{
  acknowledged: true,
  insertedId: ObjectId("6908617a3441e175d71a9d31")
}
```

---

### Insert Multiple Documents
```javascript
// Insert multiple patients at once
db.patients.insertMany([
  {
    name: "Priya Sharma",
    age: 28,
    gender: "female",
    phone: "8888888888",
    email: "priya@demo.com",
    address: "Mumbai",
    medicalHistory: []
  },
  {
    name: "Rohit Singh",
    age: 42,
    gender: "male",
    phone: "7777777777",
    email: "rohit@demo.com",
    address: "Bangalore",
    medicalHistory: [
      {
        condition: "Hypertension",
        diagnosedOn: new Date("2019-06-20"),
        notes: "Mild, monitoring required"
      }
    ]
  }
])
```

**Response:**
```javascript
{
  acknowledged: true,
  insertedIds: [
    ObjectId("6908617a3441e175d71a9d32"),
    ObjectId("6908617a3441e175d71a9d33")
  ]
}
```

---

### Insert with Timestamps
```javascript
// MongoDB will automatically add timestamps if schema has it
// Or you can add manually:
db.patients.insertOne({
  name: "Test Patient",
  age: 25,
  gender: "male",
  phone: "1234567890",
  email: "test@demo.com",
  address: "Test City",
  medicalHistory: [],
  createdAt: new Date(),
  updatedAt: new Date()
})
```

---

## 2. READ Operations

### Find All Documents
```javascript
// Get all patients
db.patients.find()

// Get all patients (formatted/pretty print)
db.patients.find().pretty()

// Get all patients (limit to first 10)
db.patients.find().limit(10)
```

---

### Find One Document
```javascript
// Get first matching document
db.patients.findOne()

// Get first document (formatted)
db.patients.findOne().pretty()

// Find by specific field
db.patients.findOne({ name: "Arjun Kumar" })

// Find by ID
db.patients.findOne({ _id: ObjectId("6908617a3441e175d71a9d31") })
```

---

### Find with Filters

#### By Single Field
```javascript
// Find by name (exact match)
db.patients.find({ name: "Arjun Kumar" })

// Find by age
db.patients.find({ age: 35 })

// Find by gender
db.patients.find({ gender: "male" })
```

---

#### By Comparison Operators
```javascript
// Greater than
db.patients.find({ age: { $gt: 30 } })

// Greater than or equal
db.patients.find({ age: { $gte: 30 } })

// Less than
db.patients.find({ age: { $lt: 40 } })

// Less than or equal
db.patients.find({ age: { $lte: 40 } })

// Not equal
db.patients.find({ gender: { $ne: "male" } })

// In array
db.patients.find({ age: { $in: [28, 35, 42] } })

// Not in array
db.patients.find({ age: { $nin: [28, 35] } })
```

---

#### By Multiple Conditions
```javascript
// AND condition (implicit)
db.patients.find({
  gender: "male",
  age: { $gt: 30 }
})

// AND condition (explicit)
db.patients.find({
  $and: [
    { gender: "male" },
    { age: { $gt: 30 } }
  ]
})

// OR condition
db.patients.find({
  $or: [
    { address: "Delhi" },
    { address: "Bangalore" }
  ]
})

// NOR condition (neither condition true)
db.patients.find({
  $nor: [
    { address: "Delhi" },
    { address: "Mumbai" }
  ]
})
```

---

#### By Text Search (Regex)
```javascript
// Case-insensitive search
db.patients.find({ name: { $regex: /arjun/i } })

// Starts with
db.patients.find({ name: { $regex: /^Arjun/ } })

// Ends with
db.patients.find({ name: { $regex: /Kumar$/ } })

// Contains
db.patients.find({ name: { $regex: /sharma/i } })
```

---

#### By Array/Embedded Documents
```javascript
// Find patients with medical history
db.patients.find({ medicalHistory: { $exists: true, $ne: [] } })

// Find patients with specific condition
db.patients.find({ "medicalHistory.condition": "Diabetes" })

// Find patients with medical history array size
db.patients.find({ medicalHistory: { $size: 2 } })
```

---

#### Sort Results
```javascript
// Sort by age (ascending)
db.patients.find().sort({ age: 1 })

// Sort by age (descending)
db.patients.find().sort({ age: -1 })

// Sort by multiple fields
db.patients.find().sort({ gender: 1, age: -1 })

// Sort and limit
db.patients.find().sort({ createdAt: -1 }).limit(5)
```

---

#### Project (Select Specific Fields)
```javascript
// Include only specific fields
db.patients.find({}, { name: 1, age: 1, _id: 1 })

// Exclude specific fields
db.patients.find({}, { medicalHistory: 0, __v: 0 })

// Include name and age, exclude _id
db.patients.find({}, { name: 1, age: 1, _id: 0 })
```

---

#### Skip and Limit (Pagination)
```javascript
// Get first 5 patients
db.patients.find().limit(5)

// Skip first 5, get next 5 (pagination)
db.patients.find().skip(5).limit(5)

// Skip 10, limit 5
db.patients.find().skip(10).limit(5)
```

---

### Count Documents
```javascript
// Count all documents
db.patients.countDocuments()

// Count with filter
db.patients.countDocuments({ gender: "male" })

// Estimated count (faster for large collections)
db.patients.estimatedDocumentCount()
```

---

## 3. UPDATE Operations

### Update One Document

#### Update Single Field
```javascript
// Update address for one patient
db.patients.updateOne(
  { name: "Arjun Kumar" },
  { $set: { address: "Bangalore" } }
)
```

**Response:**
```javascript
{
  acknowledged: true,
  matchedCount: 1,
  modifiedCount: 1,
  upsertedId: null
}
```

---

#### Update Multiple Fields
```javascript
// Update multiple fields
db.patients.updateOne(
  { _id: ObjectId("6908617a3441e175d71a9d31") },
  {
    $set: {
      address: "Bangalore",
      phone: "8888888888",
      email: "arjun.new@demo.com"
    }
  }
)
```

---

#### Update Operators

**$set - Set field value**
```javascript
db.patients.updateOne(
  { name: "Arjun Kumar" },
  { $set: { address: "New Delhi" } }
)
```

**$unset - Remove field**
```javascript
db.patients.updateOne(
  { name: "Arjun Kumar" },
  { $unset: { phone: "" } }
)
```

**$inc - Increment numeric value**
```javascript
// Increment age by 1
db.patients.updateOne(
  { name: "Arjun Kumar" },
  { $inc: { age: 1 } }
)

// Decrement age by 1
db.patients.updateOne(
  { name: "Arjun Kumar" },
  { $inc: { age: -1 } }
)
```

**$push - Add to array**
```javascript
// Add medical history entry
db.patients.updateOne(
  { _id: ObjectId("6908617a3441e175d71a9d31") },
  {
    $push: {
      medicalHistory: {
        condition: "Diabetes",
        diagnosedOn: new Date("2020-01-15"),
        notes: "Type 2, controlled"
      }
    }
  }
)
```

**$pull - Remove from array**
```javascript
// Remove medical history entry
db.patients.updateOne(
  { _id: ObjectId("6908617a3441e175d71a9d31") },
  {
    $pull: {
      medicalHistory: { condition: "Diabetes" }
    }
  }
)
```

**$addToSet - Add to array if not exists**
```javascript
// Add qualification if not already present
db.patients.updateOne(
  { _id: ObjectId("6908617a3441e175d71a9d31") },
  {
    $addToSet: {
      tags: "vip"
    }
  }
)
```

---

### Update Multiple Documents
```javascript
// Update all patients in Delhi
db.patients.updateMany(
  { address: "Delhi" },
  { $set: { address: "New Delhi" } }
)
```

**Response:**
```javascript
{
  acknowledged: true,
  matchedCount: 3,
  modifiedCount: 3,
  upsertedId: null
}
```

---

### Find One and Update (Return Updated Document)
```javascript
// Update and return the updated document
db.patients.findOneAndUpdate(
  { name: "Arjun Kumar" },
  { $set: { address: "Bangalore" } },
  { returnDocument: "after" }  // Return updated document
)

// Return original document before update
db.patients.findOneAndUpdate(
  { name: "Arjun Kumar" },
  { $set: { address: "Bangalore" } },
  { returnDocument: "before" }  // Return original document
)
```

---

### Upsert (Insert if not exists, update if exists)
```javascript
// If patient exists, update; if not, create
db.patients.updateOne(
  { email: "arjun@demo.com" },
  {
    $set: {
      name: "Arjun Kumar",
      age: 35,
      gender: "male",
      phone: "9999999999",
      address: "Delhi"
    }
  },
  { upsert: true }  // Create if doesn't exist
)
```

---

### Replace Document
```javascript
// Replace entire document (except _id)
db.patients.replaceOne(
  { _id: ObjectId("6908617a3441e175d71a9d31") },
  {
    name: "Arjun Kumar Updated",
    age: 36,
    gender: "male",
    phone: "9999999999",
    email: "arjun@demo.com",
    address: "Mumbai"
  }
)
```

---

## 4. DELETE Operations

### Delete One Document
```javascript
// Delete by ID
db.patients.deleteOne({ _id: ObjectId("6908617a3441e175d71a9d31") })

// Delete by name
db.patients.deleteOne({ name: "Arjun Kumar" })
```

**Response:**
```javascript
{
  acknowledged: true,
  deletedCount: 1
}
```

---

### Delete Multiple Documents
```javascript
// Delete all patients in Delhi
db.patients.deleteMany({ address: "Delhi" })

// Delete all patients older than 50
db.patients.deleteMany({ age: { $gt: 50 } })
```

**Response:**
```javascript
{
  acknowledged: true,
  deletedCount: 5
}
```

---

### Delete All Documents (Careful!)
```javascript
// Delete all patients
db.patients.deleteMany({})
```

**Warning:** This deletes ALL documents in the collection!

---

### Find One and Delete (Return Deleted Document)
```javascript
// Delete and return the deleted document
db.patients.findOneAndDelete({ name: "Arjun Kumar" })
```

**Response:**
```javascript
{
  _id: ObjectId("6908617a3441e175d71a9d31"),
  name: "Arjun Kumar",
  age: 35,
  ...
}
```

---

## 5. Complete CRUD Workflow Example

### Full Test Sequence

```javascript
// 1. CREATE - Insert patient
var result = db.patients.insertOne({
  name: "Test Patient",
  age: 25,
  gender: "male",
  phone: "1234567890",
  email: "test@demo.com",
  address: "Test City",
  medicalHistory: []
})

// Save the ID
var patientId = result.insertedId
print("Created patient with ID:", patientId)

// 2. READ - Find the patient
var patient = db.patients.findOne({ _id: patientId })
printjson(patient)

// 3. READ - Count total
var count = db.patients.countDocuments()
print("Total patients:", count)

// 4. UPDATE - Update patient
db.patients.updateOne(
  { _id: patientId },
  { $set: { address: "Updated City", age: 26 } }
)

// Verify update
var updated = db.patients.findOne({ _id: patientId })
printjson(updated)

// 5. DELETE - Delete patient
db.patients.deleteOne({ _id: patientId })

// Verify delete
var afterDelete = db.patients.countDocuments()
print("After delete - Total patients:", afterDelete)
print("Patient exists:", db.patients.findOne({ _id: patientId }))
```

---

## 6. Aggregation Queries

### Group by Gender
```javascript
db.patients.aggregate([
  {
    $group: {
      _id: "$gender",
      total: { $sum: 1 },
      averageAge: { $avg: "$age" }
    }
  }
])
```

---

### Count by Address
```javascript
db.patients.aggregate([
  {
    $group: {
      _id: "$address",
      count: { $sum: 1 }
    }
  },
  {
    $sort: { count: -1 }
  }
])
```

---

### Patients with Medical History
```javascript
db.patients.aggregate([
  {
    $match: {
      "medicalHistory.0": { $exists: true }
    }
  },
  {
    $project: {
      name: 1,
      medicalHistoryCount: { $size: "$medicalHistory" }
    }
  }
])
```

---

## 7. Useful Utility Commands

### Show Collections
```javascript
show collections
// or
db.getCollectionNames()
```

### Show Database
```javascript
db.getName()
```

### Switch Database
```javascript
use medicaldb
```

### Show Indexes
```javascript
db.patients.getIndexes()
```

### Create Index
```javascript
// Single field index
db.patients.createIndex({ name: 1 })

// Compound index
db.patients.createIndex({ name: 1, age: -1 })

// Unique index
db.patients.createIndex({ email: 1 }, { unique: true })
```

### Collection Stats
```javascript
db.patients.stats()
```

### Explain Query
```javascript
db.patients.find({ age: 35 }).explain()
```

---

## 8. Quick Reference Table

| Operation | Command | Example |
|-----------|---------|---------|
| **Create One** | `insertOne()` | `db.patients.insertOne({name: "John"})` |
| **Create Many** | `insertMany()` | `db.patients.insertMany([{...}, {...}])` |
| **Read All** | `find()` | `db.patients.find()` |
| **Read One** | `findOne()` | `db.patients.findOne({name: "John"})` |
| **Count** | `countDocuments()` | `db.patients.countDocuments()` |
| **Update One** | `updateOne()` | `db.patients.updateOne({...}, {$set: {...}})` |
| **Update Many** | `updateMany()` | `db.patients.updateMany({...}, {$set: {...}})` |
| **Find and Update** | `findOneAndUpdate()` | `db.patients.findOneAndUpdate({...}, {...})` |
| **Delete One** | `deleteOne()` | `db.patients.deleteOne({_id: ...})` |
| **Delete Many** | `deleteMany()` | `db.patients.deleteMany({address: "Delhi"})` |
| **Find and Delete** | `findOneAndDelete()` | `db.patients.findOneAndDelete({...})` |

---

## 9. Common Patterns

### Check if Document Exists
```javascript
var exists = db.patients.findOne({ name: "Arjun Kumar" })
if (exists) {
  print("Patient exists!")
} else {
  print("Patient not found")
}
```

### Update or Insert (Upsert)
```javascript
db.patients.updateOne(
  { email: "arjun@demo.com" },
  { $set: { name: "Arjun", age: 35 } },
  { upsert: true }
)
```

### Add to Array if Not Exists
```javascript
db.patients.updateOne(
  { _id: ObjectId("...") },
  { $addToSet: { tags: "vip" } }
)
```

### Increment Counter
```javascript
db.patients.updateOne(
  { _id: ObjectId("...") },
  { $inc: { visitCount: 1 } }
)
```

---

## 10. Error Handling Tips

### Check if ID is Valid
```javascript
// This will throw error if ID format is invalid
try {
  db.patients.findOne({ _id: ObjectId("invalid") })
} catch (e) {
  print("Invalid ObjectId format")
}
```

### Safe Delete (Check before delete)
```javascript
var patient = db.patients.findOne({ name: "Arjun Kumar" })
if (patient) {
  db.patients.deleteOne({ _id: patient._id })
  print("Patient deleted")
} else {
  print("Patient not found")
}
```

---

**Use these commands directly in mongosh terminal to test and verify your CRUD operations!**

