<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.onlineshoppingcart.model.Product" %>
<%
    // Check if admin is logged in
    String adminUser = (String) session.getAttribute("adminUser");
    if (adminUser == null || !"admin".equals(adminUser)) {
        response.sendRedirect(request.getContextPath() + "/admin");
        return;
    }
    
    List<Product> products = (List<Product>) request.getAttribute("products");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products - Admin</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Belleza&family=Tinos:ital,wght@0,400;0,700;1,400&family=Smooch+Sans:wght@100..1000&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <link rel="stylesheet" type="text/css" href="../css/modal.css">
    <link rel="stylesheet" type="text/css" href="../css/admin-products.css">
</head>
<body class="admin-products-page">
    <div class="admin-header">
        <div class="admin-header-content">
            <div class="admin-header-left">
                <a href="<%= request.getContextPath() %>/admin/dashboard" class="back-link">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M19 12H5M5 12L12 19M5 12L12 5" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    Dashboard
                </a>
                <h1 class="admin-page-title">Manage Products</h1>
            </div>
            <div class="admin-header-right">
                <a href="<%= request.getContextPath() %>/admin/products?action=add" class="add-product-btn">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M12 5V19M5 12H19" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    Add Product
                </a>
                <a href="<%= request.getContextPath() %>/admin/logout" class="admin-logout-btn">Logout</a>
            </div>
        </div>
    </div>
    
    <div class="admin-container">
        <% 
            String success = request.getParameter("success");
            String error = request.getParameter("error");
        %>
        
        <% if (success != null) { %>
            <div class="message success-message">
                <% if ("added".equals(success)) { %>
                    Product added successfully!
                <% } else if ("updated".equals(success)) { %>
                    Product updated successfully!
                <% } else if ("deleted".equals(success)) { %>
                    Product deleted successfully!
                <% } %>
            </div>
        <% } %>
        
        <% if (error != null) { %>
            <div class="message error-message">
                Failed to delete product. Please try again.
            </div>
        <% } %>
        
        <div class="products-table-container">
            <% if (products != null && !products.isEmpty()) { %>
                <table class="products-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Image</th>
                            <th>Name</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Product product : products) { %>
                            <tr>
                                <td><%= product.getId() %></td>
                                <td class="product-image-cell">
                                    <% if (product.getImageUrl() != null && !product.getImageUrl().isEmpty()) { %>
                                        <img src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>" class="product-thumb">
                                    <% } else { %>
                                        <div class="no-image">No Image</div>
                                    <% } %>
                                </td>
                                <td class="product-name"><%= product.getName() %></td>
                                <td><span class="category-badge"><%= product.getCategory() %></span></td>
                                <td class="product-price">$<%= product.getPrice() %></td>
                                <td>
                                    <span class="stock-badge <%= product.getStock() > 0 ? "in-stock" : "out-of-stock" %>">
                                        <%= product.getStock() %>
                                    </span>
                                </td>
                                <td class="actions-cell">
                                    <a href="<%= request.getContextPath() %>/admin/products?action=edit&id=<%= product.getId() %>" class="action-btn edit-btn">
                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M11 4H4C3.46957 4 2.96086 4.21071 2.58579 4.58579C2.21071 4.96086 2 5.46957 2 6V20C2 20.5304 2.21071 21.0391 2.58579 21.4142C2.96086 21.7893 3.46957 22 4 22H18C18.5304 22 19.0391 21.7893 19.4142 21.4142C19.7893 21.0391 20 20.5304 20 20V13" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                            <path d="M18.5 2.5C18.8978 2.10218 19.4374 1.87868 20 1.87868C20.5626 1.87868 21.1022 2.10218 21.5 2.5C21.8978 2.89782 22.1213 3.43739 22.1213 4C22.1213 4.56261 21.8978 5.10218 21.5 5.5L12 15L8 16L9 12L18.5 2.5Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                        </svg>
                                        Edit
                                    </a>
                                    <a href="<%= request.getContextPath() %>/admin/products?action=delete&id=<%= product.getId() %>" 
                                       class="action-btn delete-btn"
                                       onclick="return confirm('Are you sure you want to delete this product?');">
                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M3 6H5H21M8 6V4C8 3.46957 8.21071 2.96086 8.58579 2.58579C8.96086 2.21071 9.46957 2 10 2H14C14.5304 2 15.0391 2.21071 15.4142 2.58579C15.7893 2.96086 16 3.46957 16 4V6M19 6V20C19 20.5304 18.7893 21.0391 18.4142 21.4142C18.0391 21.7893 17.5304 22 17 22H7C6.46957 22 5.96086 21.7893 5.58579 21.4142C5.21071 21.0391 5 20.5304 5 20V6H19Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                        </svg>
                                        Delete
                                    </a>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <div class="empty-state">
                    <svg width="64" height="64" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M21 16V8C21 7.46957 20.7893 6.96086 20.4142 6.58579C20.0391 6.21071 19.5304 6 19 6H5C4.46957 6 3.96086 6.21071 3.58579 6.58579C3.21071 6.96086 3 7.46957 3 8V16C3 16.5304 3.21071 17.0391 3.58579 17.4142C3.96086 17.7893 4.46957 18 5 18H19C19.5304 18 20.0391 17.7893 20.4142 17.4142C20.7893 17.0391 21 16.5304 21 16Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M3 10H21" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    <h3>No Products Found</h3>
                    <p>Get started by adding your first product</p>
                    <a href="<%= request.getContextPath() %>/admin/products?action=add" class="add-product-btn">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M12 5V19M5 12H19" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        Add Product
                    </a>
                </div>
            <% } %>
        </div>
    </div>
    
    <script src="<%= request.getContextPath() %>/js/modal.js"></script>
    <script src="<%= request.getContextPath() %>/js/admin-logout.js"></script>
</body>
</html>
