<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mycompany.onlineshoppingcart.model.Product" %>
<%@ page import="com.mycompany.onlineshoppingcart.model.User" %>
<%
    Product product = (Product) request.getAttribute("product");
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= product != null ? product.getName() : "Product Details" %> - Fashion Store</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Belleza&family=Tinos:ital,wght@0,400;0,700;1,400&family=Smooch+Sans:wght@100..1000&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/product-details.css">
    <link rel="stylesheet" type="text/css" href="css/notifications.css">
    <link rel="stylesheet" type="text/css" href="css/validation.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="product-details-page">
        <div class="container">
            <%
                if (product != null) {
                    String imageUrl = product.getImageUrl() != null && !product.getImageUrl().isEmpty() 
                        ? product.getImageUrl() 
                        : "https://via.placeholder.com/600x600?text=No+Image";
                    String categoryName = product.getCategory() != null 
                        ? product.getCategory().substring(0, 1).toUpperCase() + product.getCategory().substring(1) 
                        : "Fashion";
            %>
            <!-- Breadcrumb -->
            <nav class="breadcrumb">
                <a href="index.jsp">Home</a>
                <span>/</span>
                <a href="products">Products</a>
                <span>/</span>
                <span><%= product.getName() %></span>
            </nav>
            
            <div class="product-details-container">
                <!-- Product Image Section -->
                <div class="product-image-section">
                    <div class="product-image-wrapper">
                        <img src="<%= imageUrl %>" alt="<%= product.getName() %>" class="product-main-image" id="mainImage">
                        <div class="image-zoom-lens" id="zoomLens"></div>
                    </div>
                    <div class="product-image-zoom" id="zoomContainer">
                        <img src="<%= imageUrl %>" alt="<%= product.getName() %>" class="zoom-image">
                    </div>
                </div>
                
                <!-- Product Info Section -->
                <div class="product-info-section">
                    <div class="product-header">
                        <p class="product-category-badge"><%= categoryName %></p>
                        <h1 class="product-title"><%= product.getName() %></h1>
                        <div class="product-rating">
                            <div class="stars">★★★★☆</div>
                            <span class="rating-text">(24 reviews)</span>
                        </div>
                    </div>
                    
                    <div class="product-price-section">
                        <span class="product-price">$<%= String.format("%.2f", product.getPrice()) %></span>
                        <% if (product.getPrice().doubleValue() > 50) { 
                            double oldPrice = product.getPrice().doubleValue() * 1.3;
                        %>
                        <span class="product-old-price">$<%= String.format("%.2f", oldPrice) %></span>
                        <span class="product-discount">Save 30%</span>
                        <% } %>
                    </div>
                    
                    <div class="product-description">
                        <h3>Description</h3>
                        <p><%= product.getDescription() != null ? product.getDescription() : "No description available." %></p>
                    </div>
                    
                    <div class="product-specs">
                        <div class="spec-item">
                            <span class="spec-label">Category:</span>
                            <span class="spec-value"><%= categoryName %></span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-label">Availability:</span>
                            <span class="spec-value stock-status <%= product.getStock() > 0 ? "in-stock" : "out-of-stock" %>">
                                <%= product.getStock() > 0 ? "In Stock (" + product.getStock() + " available)" : "Out of Stock" %>
                            </span>
                        </div>
                    </div>
                    
                    <% if (user != null && product.getStock() > 0) { %>
                    <form action="cart" method="post" class="add-to-cart-section" id="addToCartForm">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="<%= product.getId() %>">
                        
                        <div class="quantity-section">
                            <label for="quantity" class="quantity-label">Quantity</label>
                            <div class="quantity-controls">
                                <button type="button" class="quantity-btn minus" onclick="decreaseQuantity()">−</button>
                                <input type="number" id="quantity" name="quantity" value="1" min="1" max="<%= product.getStock() %>" class="quantity-input" required>
                                <button type="button" class="quantity-btn plus" onclick="increaseQuantity()">+</button>
                            </div>
                            <span class="stock-info">(<%= product.getStock() %> available)</span>
                        </div>
                        
                        <div class="action-buttons">
                            <button type="submit" class="btn-add-to-cart" id="addToCartBtn">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M3 3H5L5.4 5M7 13H17L21 5H5.4M7 13L5.4 5M7 13L4.7 15.3C4.3 15.7 4.6 16.5 5.1 16.5H19M17 13V17C17 18.1 17.9 19 19 19C20.1 19 21 18.1 21 17V13M9 19.5C9.8 19.5 10.5 20.2 10.5 21C10.5 21.8 9.8 22.5 9 22.5C8.2 22.5 7.5 21.8 7.5 21C7.5 20.2 8.2 19.5 9 19.5ZM20 19.5C20.8 19.5 21.5 20.2 21.5 21C21.5 21.8 20.8 22.5 20 22.5C19.2 22.5 18.5 21.8 18.5 21C18.5 20.2 19.2 19.5 20 19.5Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                </svg>
                                Add to Cart
                            </button>
                            <a href="products" class="btn-continue-shopping">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M19 12H5M5 12L12 19M5 12L12 5" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                </svg>
                                Continue Shopping
                            </a>
                        </div>
                    </form>
                    <% } else if (product.getStock() == 0) { %>
                    <div class="out-of-stock-message">
                        <p>This product is currently out of stock.</p>
                        <a href="products" class="btn-continue-shopping">Browse Other Products</a>
                    </div>
                    <% } else { %>
                    <div class="login-prompt">
                        <p>Please <a href="login.jsp">login</a> to add items to your cart.</p>
                    </div>
                    <% } %>
                    
                    <div class="product-features">
                        <div class="feature-item">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M5 13L9 17L19 7" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                            <span>Free Shipping</span>
                        </div>
                        <div class="feature-item">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M5 13L9 17L19 7" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                            <span>30-Day Returns</span>
                        </div>
                        <div class="feature-item">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M5 13L9 17L19 7" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                            <span>Secure Payment</span>
                        </div>
                    </div>
                </div>
            </div>
            <%
                } else {
            %>
            <div class="product-not-found">
                <h2>Product Not Found</h2>
                <p>The product you're looking for doesn't exist.</p>
                <a href="products" class="btn-continue-shopping">Back to Products</a>
            </div>
            <%
                }
            %>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
    
    <script src="js/notifications.js"></script>
    <script src="js/validation.js"></script>
    <script src="js/product-details.js"></script>
</body>
</html>
