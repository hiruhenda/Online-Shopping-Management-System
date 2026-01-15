<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mycompany.onlineshoppingcart.model.Cart" %>
<%@ page import="com.mycompany.onlineshoppingcart.model.CartItem" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - Fashion Store</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Belleza&family=Tinos:ital,wght@0,400;0,700;1,400&family=Smooch+Sans:wght@100..1000&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/cart.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="cart-page">
        <div class="container">
            <div class="cart-header">
                <h1 class="cart-title">Shopping Cart</h1>
                <p class="cart-subtitle">Review your items before checkout</p>
            </div>
            
            <%
                Cart cart = (Cart) session.getAttribute("cart");
                if (cart != null && !cart.getItems().isEmpty()) {
            %>
            <div class="cart-content">
                <div class="cart-items-section">
                    <div class="cart-items-header">
                        <h2>Items (<%= cart.getTotalItems() %>)</h2>
                    </div>
                    
                    <div class="cart-items-list">
                        <%
                            for (CartItem item : cart.getItems()) {
                                String imageUrl = item.getProduct().getImageUrl() != null && !item.getProduct().getImageUrl().isEmpty() 
                                    ? item.getProduct().getImageUrl() 
                                    : "https://via.placeholder.com/150x150?text=No+Image";
                        %>
                        <div class="cart-item-card">
                            <div class="cart-item-image">
                                <img src="<%= imageUrl %>" alt="<%= item.getProduct().getName() %>">
                            </div>
                            
                            <div class="cart-item-info">
                                <h3 class="cart-item-name">
                                    <a href="products?action=details&id=<%= item.getProduct().getId() %>">
                                        <%= item.getProduct().getName() %>
                                    </a>
                                </h3>
                                <p class="cart-item-category">
                                    <%= item.getProduct().getCategory() != null 
                                        ? item.getProduct().getCategory().substring(0, 1).toUpperCase() + item.getProduct().getCategory().substring(1) 
                                        : "Fashion" %>
                                </p>
                                <p class="cart-item-price-mobile">$<%= String.format("%.2f", item.getProduct().getPrice()) %> each</p>
                            </div>
                            
                            <div class="cart-item-quantity-section">
                                <label class="quantity-label">Quantity</label>
                                <form action="cart" method="post" class="quantity-form">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                                    <div class="quantity-controls">
                                        <button type="button" class="quantity-btn minus" onclick="updateQuantity(this, -1)">−</button>
                                        <input type="number" name="quantity" value="<%= item.getQuantity() %>" 
                                               min="1" max="<%= item.getProduct().getStock() %>" 
                                               class="quantity-input" 
                                               onchange="this.form.submit()">
                                        <button type="button" class="quantity-btn plus" onclick="updateQuantity(this, 1)">+</button>
                                    </div>
                                </form>
                            </div>
                            
                            <div class="cart-item-price-section">
                                <p class="cart-item-price">$<%= String.format("%.2f", item.getProduct().getPrice()) %></p>
                                <p class="cart-item-subtotal">Subtotal: $<%= String.format("%.2f", item.getSubtotal()) %></p>
                            </div>
                            
                            <div class="cart-item-actions">
                                <form action="cart" method="post" class="remove-form">
                                    <input type="hidden" name="action" value="remove">
                                    <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                                    <button type="submit" class="remove-btn" onclick="return confirm('Remove this item from cart?');">
                                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M3 6H5H21M8 6V4C8 3.46957 8.21071 2.96086 8.58579 2.58579C8.96086 2.21071 9.46957 2 10 2H14C14.5304 2 15.0391 2.21071 15.4142 2.58579C15.7893 2.96086 16 3.46957 16 4V6M19 6V20C19 20.5304 18.7893 21.0391 18.4142 21.4142C18.0391 21.7893 17.5304 22 17 22H7C6.46957 22 5.96086 21.7893 5.58579 21.4142C5.21071 21.0391 5 20.5304 5 20V6H19Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                        </svg>
                                        Remove
                                    </button>
                                </form>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>
                    
                    <div class="cart-continue-shopping">
                        <a href="products" class="continue-shopping-btn">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M19 12H5M5 12L12 19M5 12L12 5" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                            Continue Shopping
                        </a>
                    </div>
                </div>
                
                <div class="cart-summary-section">
                    <div class="cart-summary-card">
                        <h2 class="summary-title">Order Summary</h2>
                        
                        <div class="summary-row">
                            <span class="summary-label">Subtotal (<%= cart.getTotalItems() %> item<%= cart.getTotalItems() != 1 ? "s" : "" %>)</span>
                            <span class="summary-value">$<%= String.format("%.2f", cart.getTotal()) %></span>
                        </div>
                        
                        <div class="summary-row">
                            <span class="summary-label">Shipping</span>
                            <span class="summary-value">Free</span>
                        </div>
                        
                        <div class="summary-divider"></div>
                        
                        <div class="summary-row total-row">
                            <span class="summary-label">Total</span>
                            <span class="summary-value total-amount">$<%= String.format("%.2f", cart.getTotal()) %></span>
                        </div>
                        
                        <a href="checkout" class="checkout-btn">
                            Proceed to Checkout
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M5 12H19M19 12L12 5M19 12L12 19" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                        </a>
                        
                        <div class="secure-checkout">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M12 22C17.5228 22 22 17.5228 22 12C22 6.47715 17.5228 2 12 2C6.47715 2 2 6.47715 2 12C2 17.5228 6.47715 22 12 22Z" stroke="currentColor" stroke-width="2"/>
                                <path d="M9 12L11 14L15 10" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                            <span>Secure Checkout</span>
                        </div>
                    </div>
                </div>
            </div>
            <%
                } else {
            %>
            <div class="empty-cart">
                <div class="empty-cart-icon">
                    <svg width="80" height="80" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M3 3H5L5.4 5M7 13H17L21 5H5.4M7 13L5.4 5M7 13L4.7 15.3C4.3 15.7 4.6 16.5 5.1 16.5H19M17 13V17C17 18.1 17.9 19 19 19C20.1 19 21 18.1 21 17V13M9 19.5C9.8 19.5 10.5 20.2 10.5 21C10.5 21.8 9.8 22.5 9 22.5C8.2 22.5 7.5 21.8 7.5 21C7.5 20.2 8.2 19.5 9 19.5ZM20 19.5C20.8 19.5 21.5 20.2 21.5 21C21.5 21.8 20.8 22.5 20 22.5C19.2 22.5 18.5 21.8 18.5 21C18.5 20.2 19.2 19.5 20 19.5Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>
                <h2>Your cart is empty</h2>
                <p>Looks like you haven't added any items to your cart yet.</p>
                <a href="products" class="start-shopping-btn">Start Shopping</a>
            </div>
            <%
                }
            %>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
    
    <script>
        function updateQuantity(button, change) {
            const form = button.closest('.quantity-form');
            const input = form.querySelector('.quantity-input');
            const currentValue = parseInt(input.value);
            const max = parseInt(input.max);
            const min = parseInt(input.min);
            const newValue = currentValue + change;
            
            if (newValue >= min && newValue <= max) {
                input.value = newValue;
                form.submit();
            }
        }
    </script>
</body>
</html>
