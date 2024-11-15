<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
    <!-- Add intl-tel-input CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/css/intlTelInput.min.css">

    <!-- Add jQuery and intl-tel-input JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/intlTelInput.min.js"></script>
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center">User Registration</h2>
    <form id="registrationForm" action="/users/api/save" method="post" class="needs-validation" novalidate>
        <div class="row">
            <!-- Form Fields -->
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" name="username" required>
                    <div class="invalid-feedback">
                        Please provide a username.
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                    <div class="invalid-feedback">
                        Please provide a valid email address.
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="phoneNumber" class="form-label">Phone Number</label>
                    <input type="tel" id="phoneNumber" name="phoneNumber" class="form-control" required>
                    <div class="invalid-feedback">
                        Please provide a phone number.
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="mb-3">
                    <label for="address" class="form-label">Address</label>
                    <input type="text" class="form-control" id="address" name="address" required>
                    <div class="invalid-feedback">
                        Please provide an address.
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="pinCode" class="form-label">Pin Code</label>
                    <input type="text" class="form-control" id="pinCode" name="pinCode" required>
                    <div class="invalid-feedback">
                        Please provide a pin code.
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="city" class="form-label">City</label>
                    <input type="text" class="form-control" id="city" placeholder="City" readonly>
                </div>
            </div>
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="state" class="form-label">State</label>
                    <input type="text" class="form-control" id="state" placeholder="State" readonly>
                </div>
            </div>
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="country" class="form-label">Country</label>
                    <input type="text" class="form-control" id="country" placeholder="Country" readonly>
                </div>
            </div>

            <div class="col-md-6">
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                    <div class="invalid-feedback">
                        Please provide a password.
                    </div>
                </div>
            </div>

            <!-- Confirm Password -->
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="confirmPassword" class="form-label">Confirm Password</label>
                    <input type="password" class="form-control" id="confirmPassword" required>
                    <div class="invalid-feedback">
                        Please confirm your password.
                    </div>
                </div>
            </div>

            <div class="col-md-12 text-center">
                <button type="submit" class="btn btn-primary">Register</button>
            </div>
        </div>
    </form>
</div>
<p>Already have an account? <a href="/users/api/login">Login here</a></p>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Function to fetch and update city, state, and country based on pin code
        function searchPin() {
            let pin = document.getElementById("pinCode").value.trim();

            if (pin.length === 6) {
                const url = "https://api.postalpincode.in/pincode/" + pin;

                $.getJSON(url, function (data) {
                    createHTML(data);
                }).fail(function() {
                    alert("Failed to fetch data from the API.");
                });
            } else {
                $("#city").val("");
                $("#state").val("");
                $("#country").val("");
            }
        }

        function createHTML(data) {
            if (data[0].Message === "No records found") {
                alert('Enter a valid pincode');
                $("#city").val("");
                $("#state").val("");
                $("#country").val("");
                return;
            }

            var postOffice = data[0].PostOffice[0];
            if (postOffice) {
                $("#city").val(postOffice.Name);
                $("#state").val(postOffice.State);
                $("#country").val("India");
            }
        }

        document.getElementById("pinCode").addEventListener("input", searchPin);
    });

    var input = document.querySelector("#phoneNumber");
    var iti = window.intlTelInput(input, {
        initialCountry: "in",
        preferredCountries: ["in", "us", "gb", "au"],
        separateDialCode: true,
        utilsScript: "https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.min.js",
    });

    // Use jQuery to submit the form using AJAX
    $(document).ready(function() {
        $('#registrationForm').submit(function(event) {
            event.preventDefault(); // Prevent the default form submission

            // Get password and confirm password values
            var password = $('#password').val();
            var confirmPassword = $('#confirmPassword').val();

            // Check if passwords match
            if (password !== confirmPassword) {
                alert("Passwords do not match.");
                // Highlight the Confirm Password field with a red border
                $('#confirmPassword').css('border-color', 'red');
                return; // Stop form submission
            } else {
                // Reset border to default if passwords match
                $('#confirmPassword').css('border-color', '');
            }

            var formData = {
                username: $('#username').val(),
                email: $('#email').val(),
                phoneNumber: $('#phoneNumber').val(),
                address: $('#address').val(),
                pinCode: $('#pinCode').val(),
                city: $('#city').val(),
                state: $('#state').val(),
                country: $('#country').val(),
                password: password  // Only send the password
            };

            // Send data to the backend using AJAX
            $.ajax({
                url: '/users/api/save',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(formData),
                success: function(response) {
                    alert("Registration successful!");
                    $('#registrationForm')[0].reset();
                },
                error: function(error) {
                    alert("Error registering user.");
                }
            });
        });
    });
</script>
</body>
</html>
