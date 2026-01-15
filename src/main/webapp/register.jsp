<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Fashion Store</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Belleza&family=Tinos:ital,wght@0,400;0,700;1,400&family=Smooch+Sans:wght@100..1000&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/register.css">
    <link rel="stylesheet" type="text/css" href="css/notifications.css">
    <link rel="stylesheet" type="text/css" href="css/validation.css">
</head>
<body class="register-page">
    <jsp:include page="header.jsp" />
    
    <div class="register-container">
        <div class="register-form-section">
            <div class="register-content">
                    <div class="register-header">
                        <h1 class="register-title">Create Account</h1>
                        <p class="register-subtitle">Join us and start shopping</p>
                    </div>
                    
                    <% if (request.getAttribute("error") != null) { %>
                        <div class="error-message">
                            <%= request.getAttribute("error") %>
                        </div>
                    <% } %>
                    
                    <% if (request.getAttribute("success") != null) { %>
                        <div class="success-message">
                            <%= request.getAttribute("success") %>
                        </div>
                    <% } %>
                    
                    <form action="register" method="post" class="register-form" id="registerForm">
                        <div class="form-row">
                            <div class="form-group">
                                <input type="text" id="username" name="username" class="form-input" placeholder="Username" 
                                       value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>" required>
                            </div>
                            <div class="form-group">
                                <input type="email" id="email" name="email" class="form-input" placeholder="Email" 
                                       value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" required>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <input type="password" id="password" name="password" class="form-input" placeholder="Password" required>
                                <button type="button" class="password-toggle" id="passwordToggle">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M1 12C1 12 5 4 12 4C19 4 23 12 23 12C23 12 19 20 12 20C5 20 1 12 1 12Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                        <path d="M12 15C13.6569 15 15 13.6569 15 12C15 10.3431 13.6569 9 12 9C10.3431 9 9 10.3431 9 12C9 13.6569 10.3431 15 12 15Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                    </svg>
                                </button>
                            </div>
                            <div class="form-group">
                                <input type="text" id="firstName" name="firstName" class="form-input" placeholder="First Name" 
                                       value="<%= request.getAttribute("firstName") != null ? request.getAttribute("firstName") : "" %>" required>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <input type="text" id="lastName" name="lastName" class="form-input" placeholder="Last Name" 
                                       value="<%= request.getAttribute("lastName") != null ? request.getAttribute("lastName") : "" %>" required>
                            </div>
                            <div class="form-group">
                                <input type="tel" id="phone" name="phone" class="form-input" placeholder="Phone" 
                                       value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>" required>
                            </div>
                        </div>
                        
                        <div class="form-group full-width">
                            <textarea id="address" name="address" class="form-input form-textarea" placeholder="Address" rows="3" required><%= request.getAttribute("address") != null ? request.getAttribute("address") : "" %></textarea>
                        </div>
                        
                        <button type="submit" class="register-btn" id="registerBtn">
                            <span>Create Account</span>
                        </button>
                        
                        <div class="register-footer">
                            <p>Already have an account? <a href="login.jsp" class="login-link">Sign in</a></p>
                        </div>
                    </form>
            </div>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
    
    <script src="js/notifications.js"></script>
    <script src="js/validation.js"></script>
    <script src="js/register.js"></script>
</body>
</html>
