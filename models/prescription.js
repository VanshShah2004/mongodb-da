const mongoose = require("mongoose");

const prescriptionSchema = new mongoose.Schema({
  appointmentId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Appointment"
  },
  patientId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Patient"
  },
  doctorId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Doctor"
  },
  medications: [
    {
      name: String,
      dosage: String,
      frequency: String,
      duration: String
    }
  ],
  instructions: String,
  diagnosis: String
}, { timestamps: true });

module.exports = mongoose.model("Prescription", prescriptionSchema);




