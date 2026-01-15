<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.onlineshoppingcart.model.Product" %>
<%@ page import="com.mycompany.onlineshoppingcart.model.User" %>
<%@ page import="com.mycompany.onlineshoppingcart.dao.ProductDAO" %>
<%
    // Fetch new arrivals products from database
    ProductDAO productDAO = new ProductDAO();
    List<Product> newArrivals = productDAO.getNewArrivals(4); // Get 4 latest products
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fashion Store - Premium Clothing Collection</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Belleza&family=Tinos:ital,wght@0,400;0,700;1,400&family=Smooch+Sans:wght@100..1000&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/homepage.css">
</head>
<body>
    <!-- Loading Screen -->
    <div id="loadingScreen" class="loading-screen" style="display: flex; opacity: 1; visibility: visible;">
        <div class="loading-content">
            <img src="images/loading.gif" alt="Loading..." class="loading-gif">
        </div>
    </div>
    
    <jsp:include page="header.jsp" />
    
    <!-- Hero Section -->
    <section class="hero-section">
        <div class="hero-banner-carousel">
            <div class="banner-slide active" style="background-image: url('images/banner1.jpg');"></div>
            <div class="banner-slide" style="background-image: url('images/banner2.jpg');"></div>
            <div class="banner-slide" style="background-image: url('images/banner3.jpg');"></div>
            <div class="banner-slide" style="background-image: url('images/banner4.jpg');"></div>
        </div>
        <div class="hero-overlay"></div>
        <div class="hero-content">
            <h1 class="hero-title">Fashion That Speaks Your Style</h1>
            <p class="hero-subtitle">Discover the latest trends in clothing and accessories</p>
            <div class="hero-buttons">
                <a href="products" class="btn btn-hero-primary">Shop Now</a>
                <a href="#new-arrivals" class="btn btn-hero-secondary">New Arrivals</a>
            </div>
        </div>
        <div class="carousel-indicators">
            <span class="indicator active" data-slide="0"></span>
            <span class="indicator" data-slide="1"></span>
            <span class="indicator" data-slide="2"></span>
            <span class="indicator" data-slide="3"></span>
        </div>
    </section>

    <!-- Categories Section -->
    <section class="categories-section">
        <div class="container">
            <h2 class="section-title">Shop by Category</h2>
            <div class="categories-grid">
                <div class="category-card" data-category="men">
                    <div class="category-image">
                        <img src="https://images.unsplash.com/photo-1617137968427-85924c800a22?w=600&h=600&fit=crop" alt="Men's Fashion" />
                        <div class="category-overlay"></div>
                    </div>
                    <div class="category-content">
                        <h3>Men's Fashion</h3>
                        <p>Trendy & Classic Styles</p>
                        <a href="products?category=men" class="category-link">Explore →</a>
                    </div>
                </div>
                <div class="category-card" data-category="women">
                    <div class="category-image">
                        <img src="https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=600&h=600&fit=crop" alt="Women's Fashion" />
                        <div class="category-overlay"></div>
                    </div>
                    <div class="category-content">
                        <h3>Women's Fashion</h3>
                        <p>Elegant & Modern Designs</p>
                        <a href="products?category=women" class="category-link">Explore →</a>
                    </div>
                </div>
                <div class="category-card" data-category="kids">
                    <div class="category-image">
                        <img src="https://images.unsplash.com/photo-1503454537195-1dcabb73ffb9?w=600&h=600&fit=crop" alt="Kids Collection" />
                        <div class="category-overlay"></div>
                    </div>
                    <div class="category-content">
                        <h3>Kids Collection</h3>
                        <p>Comfortable & Fun</p>
                        <a href="products?category=kids" class="category-link">Explore →</a>
                    </div>
                </div>
                <div class="category-card" data-category="accessories">
                    <div class="category-image">
                        <img src="https://images.unsplash.com/photo-1606760227091-3dd870d97f1d?w=600&h=600&fit=crop" alt="Accessories" />
                        <div class="category-overlay"></div>
                    </div>
                    <div class="category-content">
                        <h3>Accessories</h3>
                        <p>Complete Your Look</p>
                        <a href="products?category=accessories" class="category-link">Explore →</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- New Arrivals Section -->
    <section id="new-arrivals" class="new-arrivals-section">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">New Arrivals</h2>
                <p class="section-subtitle">Fresh styles just landed in our store</p>
            </div>
            <div class="products-showcase">
                <%
                    if (newArrivals != null && !newArrivals.isEmpty()) {
                        for (Product product : newArrivals) {
                            String imageUrl = product.getImageUrl() != null && !product.getImageUrl().isEmpty() 
                                ? product.getImageUrl() 
                                : "https://via.placeholder.com/300x300?text=No+Image";
                            String categoryName = "Fashion";
                            if (product.getCategory() != null && !product.getCategory().isEmpty()) {
                                String cat = product.getCategory();
                                categoryName = cat.substring(0, 1).toUpperCase() + cat.substring(1) + "'s Wear";
                            }
                %>
                <div class="product-showcase-card">
                    <div class="product-badge">New</div>
                    <div class="product-image-placeholder" style="background-image: url('<%= imageUrl %>'); background-size: cover; background-position: center;">
                        <div class="product-image-overlay">
                            <a href="products?action=details&id=<%= product.getId() %>" class="quick-view-btn">Quick View</a>
                            <%
                                if (user != null) {
                            %>
                            <form action="cart" method="post" class="add-to-cart-quick-form">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productId" value="<%= product.getId() %>">
                                <input type="hidden" name="quantity" value="1">
                                <button type="submit" class="add-to-cart-quick-btn" onclick="event.stopPropagation();">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M3 3H5L5.4 5M7 13H17L21 5H5.4M7 13L5.4 5M7 13L4.7 15.3C4.3 15.7 4.6 16.5 5.1 16.5H19M17 13V17C17 18.1 17.9 19 19 19C20.1 19 21 18.1 21 17V13M9 19.5C9.8 19.5 10.5 20.2 10.5 21C10.5 21.8 9.8 22.5 9 22.5C8.2 22.5 7.5 21.8 7.5 21C7.5 20.2 8.2 19.5 9 19.5ZM20 19.5C20.8 19.5 21.5 20.2 21.5 21C21.5 21.8 20.8 22.5 20 22.5C19.2 22.5 18.5 21.8 18.5 21C18.5 20.2 19.2 19.5 20 19.5Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                    </svg>
                                    Add to Cart
                                </button>
                            </form>
                            <%
                                }
                            %>
                        </div>
                    </div>
                    <div class="product-info">
                        <h4><%= product.getName() %></h4>
                        <p class="product-category"><%= categoryName %></p>
                        <div class="product-rating">
                            <span class="stars">★★★★☆</span>
                            <span class="rating-count">(<%= (int)(Math.random() * 30 + 10) %>)</span>
                        </div>
                        <div class="product-price">
                            <span class="current-price">$<%= String.format("%.2f", product.getPrice()) %></span>
                            <% if (product.getPrice().doubleValue() > 50) { 
                                double oldPrice = product.getPrice().doubleValue() * 1.3;
                            %>
                            <span class="old-price">$<%= String.format("%.2f", oldPrice) %></span>
                            <% } %>
                        </div>
                    </div>
                </div>
                <%
                        }
                    } else {
                %>
                <div class="no-products-message">
                    <p>No new arrivals at the moment. Check back soon!</p>
                </div>
                <%
                    }
                %>
            </div>
            <div class="view-all-container">
                <a href="products" class="btn btn-view-all">View All Products</a>
            </div>
        </div>
    </section>

    <!-- Special Offer Banner -->
    <section class="offer-banner">
        <div class="container">
            <div class="offer-content">
                <div class="offer-text">
                    <h2>Special Summer Sale</h2>
                    <p>Up to 50% OFF on Selected Items</p>
                    <span class="offer-code">Use Code: SUMMER2024</span>
                </div>
                <div class="offer-timer">
                    <div class="timer-item">
                        <span class="timer-value" id="days">00</span>
                        <span class="timer-label">Days</span>
                    </div>
                    <div class="timer-item">
                        <span class="timer-value" id="hours">00</span>
                        <span class="timer-label">Hours</span>
                    </div>
                    <div class="timer-item">
                        <span class="timer-value" id="minutes">00</span>
                        <span class="timer-label">Minutes</span>
                    </div>
                    <div class="timer-item">
                        <span class="timer-value" id="seconds">00</span>
                        <span class="timer-label">Seconds</span>
                    </div>
                </div>
                <a href="products" class="btn btn-offer">Shop Now</a>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features-section">
        <div class="container">
            <div class="features-grid">
                <div class="feature-item">
                    <div class="feature-icon-wrapper">
                        <svg class="feature-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M20 8H17L15 4H9L7 8H4C2.9 8 2 8.9 2 10V19C2 20.1 2.9 21 4 21H20C21.1 21 22 20.1 22 19V10C22 8.9 21.1 8 20 8Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M12 15C13.6569 15 15 13.6569 15 12C15 10.3431 13.6569 9 12 9C10.3431 9 9 10.3431 9 12C9 13.6569 10.3431 15 12 15Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </div>
                    <h3>Free Shipping</h3>
                    <p>On orders over $100</p>
                    <blockquote class="feature-quote">"Fast and reliable delivery to your doorstep"</blockquote>
                </div>
                <div class="feature-item">
                    <div class="feature-icon-wrapper">
                        <svg class="feature-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M1 4H5L7.68 14.39C7.77 14.7 7.95 14.98 8.2 15.19L16.54 21.53C16.83 21.75 17.18 21.87 17.54 21.87H21C22.1 21.87 23 20.97 23 19.87V18.87C23 18.31 22.79 17.77 22.41 17.38L9.12 4.09C8.73 3.7 8.19 3.5 7.63 3.5H1" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M8 6H22.79C23.18 6 23.5 6.32 23.5 6.71V9.29C23.5 9.68 23.18 10 22.79 10H8" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </div>
                    <h3>Easy Returns</h3>
                    <p>30-day return policy</p>
                    <blockquote class="feature-quote">"Shop with confidence, return with ease"</blockquote>
                </div>
                <div class="feature-item">
                    <div class="feature-icon-wrapper">
                        <svg class="feature-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <rect x="1" y="4" width="22" height="16" rx="2" stroke="currentColor" stroke-width="2"/>
                            <path d="M1 10H23" stroke="currentColor" stroke-width="2"/>
                            <path d="M7 16H9" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                            <path d="M13 16H15" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                        </svg>
                    </div>
                    <h3>Secure Payment</h3>
                    <p>100% secure checkout</p>
                    <blockquote class="feature-quote">"Your payment information is always protected"</blockquote>
                </div>
                <div class="feature-item">
                    <div class="feature-icon-wrapper">
                        <svg class="feature-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M12 2L15.09 8.26L22 9.27L17 14.14L18.18 21.02L12 17.77L5.82 21.02L7 14.14L2 9.27L8.91 8.26L12 2Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </div>
                    <h3>Quality Guarantee</h3>
                    <p>Premium quality products</p>
                    <blockquote class="feature-quote">"Only the finest quality for our customers"</blockquote>
                </div>
            </div>
        </div>
    </section>

    <jsp:include page="footer.jsp" />
    
    <script src="js/homepage.js"></script>
</body>
</html>
