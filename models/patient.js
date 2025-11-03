const mongoose = require("mongoose");

const patientSchema = new mongoose.Schema({
  name: String,
  age: Number,
  gender: String,
  phone: String,
  email: String,
  address: String,
  medicalHistory: [
    {
      condition: String,
      diagnosedOn: Date,
      notes: String
    }
  ]
}, { timestamps: true });

module.exports = mongoose.model("Patient", patientSchema);

