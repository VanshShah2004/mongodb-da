const mongoose = require("mongoose");

const doctorSchema = new mongoose.Schema({
  name: String,
  specialization: String,
  phone: String,
  email: String,
  experience: Number,
  qualifications: [String]
}, { timestamps: true });

module.exports = mongoose.model("Doctor", doctorSchema);

