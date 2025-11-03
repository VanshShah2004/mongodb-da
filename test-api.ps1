# PowerShell script to test Medical App API CRUD operations

$baseUrl = "http://localhost:3000"

Write-Host "🧪 Testing Medical App API" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan

# 1. Test GET root endpoint
Write-Host "`n1️⃣ Testing GET /" -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "$baseUrl" -UseBasicParsing
    Write-Host "✅ Status: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "   Response: $($response.Content)" -ForegroundColor Gray
} catch {
    Write-Host "❌ Error: $_" -ForegroundColor Red
}

# 2. Create Patient
Write-Host "`n2️⃣ Testing POST /patients (Create)" -ForegroundColor Yellow
$newPatient = @{
    name = "Arjun Kumar"
    age = 35
    gender = "male"
    phone = "9999999999"
    email = "a@demo.com"
    address = "Delhi"
    medicalHistory = @(
        @{
            condition = "Diabetes"
            diagnosedOn = "2020-01-15"
            notes = "Type 2"
        }
    )
} | ConvertTo-Json -Depth 10

try {
    $response = Invoke-WebRequest -Uri "$baseUrl/patients" -Method POST -Body $newPatient -ContentType "application/json" -UseBasicParsing
    $patient = $response.Content | ConvertFrom-Json
    $patientId = $patient._id
    Write-Host "✅ Patient created successfully!" -ForegroundColor Green
    Write-Host "   Patient ID: $patientId" -ForegroundColor Gray
    Write-Host "   Name: $($patient.name)" -ForegroundColor Gray
} catch {
    Write-Host "❌ Error: $_" -ForegroundColor Red
    $patientId = "6908617a3441e175d71a9d31" # Fallback ID if creation fails
}

# 3. Get All Patients
Write-Host "`n3️⃣ Testing GET /patients (Read All)" -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "$baseUrl/patients" -UseBasicParsing
    $patients = $response.Content | ConvertFrom-Json
    Write-Host "✅ Found $($patients.Count) patient(s)" -ForegroundColor Green
    if ($patients.Count -gt 0) {
        Write-Host "   First patient: $($patients[0].name)" -ForegroundColor Gray
    }
} catch {
    Write-Host "❌ Error: $_" -ForegroundColor Red
}

# 4. Get One Patient
Write-Host "`n4️⃣ Testing GET /patients/:id (Read One)" -ForegroundColor Yellow
if ($patientId) {
    try {
        $response = Invoke-WebRequest -Uri "$baseUrl/patients/$patientId" -UseBasicParsing
        $patient = $response.Content | ConvertFrom-Json
        Write-Host "✅ Patient retrieved successfully!" -ForegroundColor Green
        Write-Host "   Name: $($patient.name)" -ForegroundColor Gray
        Write-Host "   Address: $($patient.address)" -ForegroundColor Gray
    } catch {
        Write-Host "❌ Error: $_" -ForegroundColor Red
    }
}

# 5. Update Patient
Write-Host "`n5️⃣ Testing PUT /patients/:id (Update)" -ForegroundColor Yellow
if ($patientId) {
    $updateData = @{
        address = "Bangalore"
    } | ConvertTo-Json
    
    try {
        $response = Invoke-WebRequest -Uri "$baseUrl/patients/$patientId" -Method PUT -Body $updateData -ContentType "application/json" -UseBasicParsing
        $patient = $response.Content | ConvertFrom-Json
        Write-Host "✅ Patient updated successfully!" -ForegroundColor Green
        Write-Host "   New Address: $($patient.address)" -ForegroundColor Gray
    } catch {
        Write-Host "❌ Error: $_" -ForegroundColor Red
    }
}

# 6. Delete Patient (optional - commented out to keep test data)
Write-Host "`n6️⃣ Testing DELETE /patients/:id (Delete)" -ForegroundColor Yellow
Write-Host "   ⚠️  Skipped to preserve test data" -ForegroundColor Yellow
# Uncomment below to test delete:
# if ($patientId) {
#     try {
#         $response = Invoke-WebRequest -Uri "$baseUrl/patients/$patientId" -Method DELETE -UseBasicParsing
#         Write-Host "✅ Patient deleted successfully!" -ForegroundColor Green
#     } catch {
#         Write-Host "❌ Error: $_" -ForegroundColor Red
#     }
# }

Write-Host "`n================================" -ForegroundColor Cyan
Write-Host "✅ All tests completed!" -ForegroundColor Green




