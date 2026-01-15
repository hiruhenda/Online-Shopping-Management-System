<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.onlineshoppingcart.model.Product" %>
<%@ page import="com.mycompany.onlineshoppingcart.model.User" %>
<%@ page import="java.math.BigDecimal" %>
<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    List<Product> allProducts = (List<Product>) request.getAttribute("allProducts");
    List<String> categories = (List<String>) request.getAttribute("categories");
    String selectedCategory = (String) request.getAttribute("selectedCategory");
    if (selectedCategory == null) selectedCategory = "all";
    if (allProducts == null) allProducts = products;
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Fashions - Fashion Store</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Belleza&family=Tinos:ital,wght@0,400;0,700;1,400&family=Smooch+Sans:wght@100..1000&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/products.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="products-page">
        <!-- Banner Section -->
        <div class="products-banner">
            <div class="banner-overlay"></div>
            <div class="banner-content">
                <h1 class="banner-title">Your Fashions</h1>
                <p class="banner-subtitle">Discover your unique style</p>
            </div>
        </div>
        
        <div class="container">
            <div class="products-layout">
                <!-- Sidebar Filters -->
                <aside class="products-sidebar">
                    <div class="filter-section">
                        <h2 class="filter-title">Categories</h2>
                        <div class="filter-list">
                            <a href="products" class="filter-item <%= "all".equals(selectedCategory) ? "active" : "" %>" data-category="all">
                                <span class="filter-icon">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M3 9L12 2L21 9V20C21 20.5304 20.7893 21.0391 20.4142 21.4142C20.0391 21.7893 19.5304 22 19 22H5C4.46957 22 3.96086 21.7893 3.58579 21.4142C3.21071 21.0391 3 20.5304 3 20V9Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                        <path d="M9 22V12H15V22" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                    </svg>
                                </span>
                                <span>All Products</span>
                                <span class="filter-count" id="count-all"><%= allProducts != null ? allProducts.size() : 0 %></span>
                            </a>
                            <%
                                if (categories != null) {
                                    for (String category : categories) {
                                        int categoryCount = 0;
                                        if (allProducts != null) {
                                            for (Product p : allProducts) {
                                                if (category.equals(p.getCategory())) {
                                                    categoryCount++;
                                                }
                                            }
                                        }
                                        String categoryName = category.substring(0, 1).toUpperCase() + category.substring(1);
                            %>
                            <a href="products?category=<%= category %>" class="filter-item <%= category.equals(selectedCategory) ? "active" : "" %>" data-category="<%= category %>">
                                <span class="filter-icon">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M21 16V8C21 7.46957 20.7893 6.96086 20.4142 6.58579C20.0391 6.21071 19.5304 6 19 6H5C4.46957 6 3.96086 6.21071 3.58579 6.58579C3.21071 6.96086 3 7.46957 3 8V16C3 16.5304 3.21071 17.0391 3.58579 17.4142C3.96086 17.7893 4.46957 18 5 18H19C19.5304 18 20.0391 17.7893 20.4142 17.4142C20.7893 17.0391 21 16.5304 21 16Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                        <path d="M3 10H21" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                    </svg>
                                </span>
                                <span><%= categoryName %></span>
                                <span class="filter-count"><%= categoryCount %></span>
                            </a>
                            <%
                                    }
                                }
                            %>
                        </div>
                    </div>
                </aside>
                
                <!-- Products Grid -->
                <main class="products-main">
                    <div class="products-toolbar">
                        <div class="products-count">
                            <span id="products-count-text">
                                <%= products != null ? products.size() : 0 %> product<%= (products != null && products.size() != 1) ? "s" : "" %> found
                            </span>
                        </div>
                        <div class="view-toggle">
                            <button class="view-btn active" data-view="grid" aria-label="Grid view">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M3 3H10V10H3V3Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                    <path d="M14 3H21V10H14V3Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                    <path d="M3 14H10V21H3V14Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                    <path d="M14 14H21V21H14V14Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                </svg>
                            </button>
                            <button class="view-btn" data-view="list" aria-label="List view">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M3 6H21M3 12H21M3 18H21" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                </svg>
                            </button>
                        </div>
                    </div>
                    
                    <div class="products-grid" id="productsGrid">
                        <%
                            if (products != null && !products.isEmpty()) {
                                for (Product product : products) {
                                    String imageUrl = product.getImageUrl() != null && !product.getImageUrl().isEmpty() 
                                        ? product.getImageUrl() 
                                        : "https://via.placeholder.com/400x400?text=No+Image";
                                    String categoryName = product.getCategory() != null 
                                        ? product.getCategory().substring(0, 1).toUpperCase() + product.getCategory().substring(1) 
                                        : "Fashion";
                        %>
                        <div class="product-card" data-category="<%= product.getCategory() != null ? product.getCategory() : "" %>">
                            <div class="product-image-wrapper">
                                <a href="products?action=details&id=<%= product.getId() %>" class="product-image-link">
                                    <img src="<%= imageUrl %>" alt="<%= product.getName() %>" class="product-image">
                                </a>
                                <div class="product-overlay">
                                    <a href="products?action=details&id=<%= product.getId() %>" class="product-action-btn quick-view-btn">
                                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M1 12C1 12 5 4 12 4C19 4 23 12 23 12C23 12 19 20 12 20C5 20 1 12 1 12Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                            <path d="M12 15C13.6569 15 15 13.6569 15 12C15 10.3431 13.6569 9 12 9C10.3431 9 9 10.3431 9 12C9 13.6569 10.3431 15 12 15Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                        </svg>
                                        Quick View
                                    </a>
                                    <%
                                        if (user != null) {
                                    %>
                                    <form action="cart" method="post" class="add-to-cart-form-inline">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="productId" value="<%= product.getId() %>">
                                        <input type="hidden" name="quantity" value="1">
                                        <button type="submit" class="product-action-btn add-to-cart-btn" onclick="event.stopPropagation();">
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
                                <% if (product.getStock() <= 5 && product.getStock() > 0) { %>
                                <span class="product-badge low-stock">Low Stock</span>
                                <% } else if (product.getStock() == 0) { %>
                                <span class="product-badge out-of-stock">Out of Stock</span>
                                <% } %>
                            </div>
                            
                            <div class="product-info">
                                <p class="product-category"><%= categoryName %></p>
                                <h3 class="product-name">
                                    <a href="products?action=details&id=<%= product.getId() %>"><%= product.getName() %></a>
                                </h3>
                                <div class="product-price-row">
                                    <span class="product-price">$<%= String.format("%.2f", product.getPrice()) %></span>
                                    <% if (product.getStock() > 0) { %>
                                    <span class="product-stock">In Stock</span>
                                    <% } else { %>
                                    <span class="product-stock out">Out of Stock</span>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                        <%
                                }
                            } else {
                        %>
                        <div class="no-products">
                            <div class="no-products-icon">
                                <svg width="64" height="64" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M21 16V8C21 7.46957 20.7893 6.96086 20.4142 6.58579C20.0391 6.21071 19.5304 6 19 6H5C4.46957 6 3.96086 6.21071 3.58579 6.58579C3.21071 6.96086 3 7.46957 3 8V16C3 16.5304 3.21071 17.0391 3.58579 17.4142C3.96086 17.7893 4.46957 18 5 18H19C19.5304 18 20.0391 17.7893 20.4142 17.4142C20.7893 17.0391 21 16.5304 21 16Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                    <path d="M3 10H21" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                </svg>
                            </div>
                            <h3>No Products Found</h3>
                            <p>We couldn't find any products in this category.</p>
                            <a href="products" class="btn-view-all">View All Products</a>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </main>
            </div>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
    
    <script src="js/products.js"></script>
</body>
</html>
