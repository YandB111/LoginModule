<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Login</title>

    <!-- Bootstrap CSS (use a CDN for simplicity) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEJ6VZiQe2i7hUNa9r0vJzU45l33P7eQsPvlRg96kF1n1hU0IxxvDdTr8dhg0" crossorigin="anonymous">

    <!-- Optional: Add custom styling -->
    <style>
        body {
            background-color: #f0f8ff;
            font-family: Arial, sans-serif;
        }

        .login-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 40px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .login-container h1 {
            text-align: center;
            margin-bottom: 30px;
            color: #007bff;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            font-weight: bold;
            color: #007bff;
        }

        
        .form-control:focus {
            background-color: #d4efff;
            border-color: #0056b3;
            box-shadow: none;
        }

        .login-btn {
            width: 100%;
            background-color: #007bff;
            border: none;
            color: white;
            padding: 10px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
        }

        .login-btn:hover {
            background-color: #0056b3;
        }

        .forgot-password {
            text-align: center;
            margin-top: 15px;
        }

        .forgot-password a {
            color: #007bff;
            text-decoration: none;
        }

        .forgot-password a:hover {
            text-decoration: underline;
        }

        .alert {
            margin-top: 20px;
        }


        #email{
           border-radius: 5px;
            padding: 10px;
            background-color: #e9f7ff;
            border: 1px solid #007bff;
            margin-left: 36px;
        } 
       
       #password{
         border-radius: 5px;
            padding: 10px;
            background-color: #e9f7ff;
            border: 1px solid #007bff;
            margin:5px
      
       }
    </style>
</head>

<body>
    <div class="container">
        <div class="login-container">
            <h1>User Login</h1>

            <!-- Login Form -->
            <form action="/users/api/login" method="POST">
                <!-- Email input -->
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" class="form-control" required>
                </div>

                <!-- Password input -->
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" class="form-control" required>
                </div>

                <!-- Submit button -->
                <button type="submit" class="btn login-btn">Login</button>
            </form>

            <!-- Display error message if exists -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger mt-3">
                    <p>${error}</p>
                </div>
            </c:if>

            <!-- Forgot Password and Register Link -->
            <div class="forgot-password">
                <p><a href="/users/api/forgot-password">Forgot your password?</a></p>
                <p>Don't have an account? <a href="/users/api/register">Register here</a></p>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS (optional but useful for additional functionality like modal dialogs, etc.) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kd/t+JliTK72g+tmKv6KNWllvxXqxj5fZo7exuGfaIiwUMWX2bpA9d9jq65XX1Xq" crossorigin="anonymous"></script>
</body>

</html>
