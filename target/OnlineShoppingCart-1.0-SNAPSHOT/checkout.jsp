<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mycompany.onlineshoppingcart.model.Cart" %>
<%@ page import="com.mycompany.onlineshoppingcart.model.CartItem" %>
<%@ page import="com.mycompany.onlineshoppingcart.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%
    Cart cart = (Cart) session.getAttribute("cart");
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Fashion Store</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Belleza&family=Tinos:ital,wght@0,400;0,700;1,400&family=Smooch+Sans:wght@100..1000&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/checkout.css">
    <link rel="stylesheet" type="text/css" href="css/notifications.css">
    <link rel="stylesheet" type="text/css" href="css/validation.css">
</head>
<body class="checkout-page">
    <jsp:include page="header.jsp" />
    
    <div class="checkout-container">
        <%
            if (user == null) {
        %>
        <div class="checkout-empty">
            <div class="empty-content">
                <svg width="64" height="64" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M12 22C17.5228 22 22 17.5228 22 12C22 6.47715 17.5228 2 12 2C6.47715 2 2 6.47715 2 12C2 17.5228 6.47715 22 12 22Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M12 8V12M12 16H12.01" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                <h2>Please Login</h2>
                <p>You need to be logged in to checkout</p>
                <a href="login.jsp" class="btn btn-primary">Login</a>
            </div>
        </div>
        <%
            } else if (cart == null || cart.getItems().isEmpty()) {
        %>
        <div class="checkout-empty">
            <div class="empty-content">
                <svg width="64" height="64" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M3 3H5L5.4 5M7 13H17L21 5H5.4M7 13L5.4 5M7 13L4.7 15.3C4.3 15.7 4.6 16.5 5.1 16.5H19M17 13V17C17 18.1 17.9 19 19 19C20.1 19 21 18.1 21 17V13M9 19.5C9.8 19.5 10.5 20.2 10.5 21C10.5 21.8 9.8 22.5 9 22.5C8.2 22.5 7.5 21.8 7.5 21C7.5 20.2 8.2 19.5 9 19.5ZM20 19.5C20.8 19.5 21.5 20.2 21.5 21C21.5 21.8 20.8 22.5 20 22.5C19.2 22.5 18.5 21.8 18.5 21C18.5 20.2 19.2 19.5 20 19.5Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                <h2>Your Cart is Empty</h2>
                <p>Add some items to your cart before checkout</p>
                <a href="products" class="btn btn-primary">Continue Shopping</a>
            </div>
        </div>
        <%
            } else {
                BigDecimal subtotal = cart.getTotal();
                BigDecimal shipping = subtotal.doubleValue() > 100 ? BigDecimal.ZERO : new BigDecimal("10.00");
                BigDecimal tax = subtotal.multiply(new BigDecimal("0.08")); // 8% tax
                BigDecimal total = subtotal.add(shipping).add(tax);
        %>
        <div class="checkout-layout">
            <!-- Order Summary Section - Left Side -->
            <div class="checkout-summary-section">
                <div class="summary-header">
                    <h2>Pay Fashion Store</h2>
                    <div class="summary-total-amount">$<%= String.format("%.2f", total) %></div>
                </div>
                
                <div class="summary-card">
                    <h2 class="summary-title">Order Summary</h2>
                    
                    <div class="order-items">
                        <%
                            for (CartItem item : cart.getItems()) {
                                String imageUrl = item.getProduct().getImageUrl() != null && !item.getProduct().getImageUrl().isEmpty() 
                                    ? item.getProduct().getImageUrl() 
                                    : "https://via.placeholder.com/80x80?text=No+Image";
                        %>
                        <div class="order-item">
                            <div class="order-item-image">
                                <img src="<%= imageUrl %>" alt="<%= item.getProduct().getName() %>">
                            </div>
                            <div class="order-item-details">
                                <h4><%= item.getProduct().getName() %></h4>
                                <p>Qty: <%= item.getQuantity() %></p>
                            </div>
                            <div class="order-item-price">
                                $<%= String.format("%.2f", item.getSubtotal()) %>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>
                    
                    <div class="summary-totals">
                        <div class="summary-row">
                            <span>Subtotal</span>
                            <span>$<%= String.format("%.2f", subtotal) %></span>
                        </div>
                        <div class="summary-row">
                            <span>Shipping</span>
                            <span><%= shipping.doubleValue() == 0 ? "Free" : "$" + String.format("%.2f", shipping) %></span>
                        </div>
                        <div class="summary-row">
                            <span>Tax</span>
                            <span>$<%= String.format("%.2f", tax) %></span>
                        </div>
                        <div class="summary-row summary-total">
                            <span>Total</span>
                            <span>$<%= String.format("%.2f", total) %></span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Checkout Form Section - Right Side -->
            <div class="checkout-form-section">
                <div class="checkout-header">
                    <h1 class="checkout-title">Checkout</h1>
                    <p class="checkout-subtitle">Complete your order</p>
                </div>
                
                <% if (request.getAttribute("error") != null) { %>
                    <div class="error-message">
                        <%= request.getAttribute("error") %>
                    </div>
                <% } %>
                
                <form action="checkout" method="post" class="checkout-form" id="checkoutForm">
                    <div class="form-layout-grid">
                        <!-- Left Column - Shipping Information -->
                        <div class="form-column-left">
                            <div class="form-section">
                                <div class="section-header">
                                    <svg class="section-icon" width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M3 9L12 2L21 9V20C21 20.5304 20.7893 21.0391 20.4142 21.4142C20.0391 21.7893 19.5304 22 19 22H5C4.46957 22 3.96086 21.7893 3.58579 21.4142C3.21071 21.0391 3 20.5304 3 20V9Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                        <path d="M9 22V12H15V22" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                    </svg>
                                    <h2 class="section-title">Shipping Address</h2>
                                </div>
                                
                                <div class="form-group">
                                    <label for="fullName" class="form-label">Full Name</label>
                                    <input type="text" id="fullName" name="fullName" class="form-input" 
                                           value="<%= (user.getFirstName() != null ? user.getFirstName() : "") + " " + (user.getLastName() != null ? user.getLastName() : "") %>" 
                                           placeholder="Enter your full name" required>
                                </div>
                                
                                <div class="form-group">
                                    <label for="shippingAddress" class="form-label">Shipping Address</label>
                                    <textarea id="shippingAddress" name="shippingAddress" class="form-input form-textarea" 
                                              rows="4" placeholder="Enter your complete shipping address" required><%= user.getAddress() != null ? user.getAddress() : "" %></textarea>
                                </div>
                                
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="city" class="form-label">City</label>
                                        <input type="text" id="city" name="city" class="form-input" placeholder="City" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="zipCode" class="form-label">Zip Code</label>
                                        <input type="text" id="zipCode" name="zipCode" class="form-input" placeholder="Zip Code" required>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="phone" class="form-label">Phone Number</label>
                                    <input type="tel" id="phone" name="phone" class="form-input" 
                                           value="<%= user.getPhone() != null ? user.getPhone() : "" %>" 
                                           placeholder="Enter your phone number" required>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Right Column - Payment Method -->
                        <div class="form-column-right">
                            <div class="form-section">
                                <div class="section-header">
                                    <svg class="section-icon" width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <rect x="1" y="4" width="22" height="16" rx="2" stroke="currentColor" stroke-width="2"/>
                                        <path d="M1 10H23" stroke="currentColor" stroke-width="2"/>
                                    </svg>
                                    <h2 class="section-title">Payment Method</h2>
                                </div>
                                
                                <div class="payment-methods">
                                    <label class="payment-option">
                                        <input type="radio" name="paymentMethod" value="credit" checked>
                                        <div class="payment-card">
                                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <rect x="1" y="4" width="22" height="16" rx="2" stroke="currentColor" stroke-width="2"/>
                                                <path d="M1 10H23" stroke="currentColor" stroke-width="2"/>
                                            </svg>
                                            <span>Credit Card</span>
                                        </div>
                                    </label>
                                    
                                    <label class="payment-option">
                                        <input type="radio" name="paymentMethod" value="debit">
                                        <div class="payment-card">
                                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <rect x="1" y="4" width="22" height="16" rx="2" stroke="currentColor" stroke-width="2"/>
                                                <path d="M1 10H23" stroke="currentColor" stroke-width="2"/>
                                            </svg>
                                            <span>Debit Card</span>
                                        </div>
                                    </label>
                                    
                                    <label class="payment-option">
                                        <input type="radio" name="paymentMethod" value="paypal">
                                        <div class="payment-card">
                                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M12 2C6.47715 2 2 6.47715 2 12C2 17.5228 6.47715 22 12 22C17.5228 22 22 17.5228 22 12C22 6.47715 17.5228 2 12 2Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                                <path d="M8 12L10.5 14.5L16 9" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                            </svg>
                                            <span>PayPal</span>
                                        </div>
                                    </label>
                                </div>
                            </div>
                            
                            <button type="submit" class="checkout-btn" id="checkoutBtn">
                                <span>Place Order</span>
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M5 12H19M19 12L12 5M19 12L12 19" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                </svg>
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <%
            }
        %>
    </div>
    
    <jsp:include page="footer.jsp" />
    
    <script src="js/notifications.js"></script>
    <script src="js/validation.js"></script>
    <script src="js/checkout.js"></script>
</body>
</html>
