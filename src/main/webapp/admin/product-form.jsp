<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mycompany.onlineshoppingcart.model.Product" %>
<%
    // Check if admin is logged in
    String adminUser = (String) session.getAttribute("adminUser");
    if (adminUser == null || !"admin".equals(adminUser)) {
        response.sendRedirect(request.getContextPath() + "/admin");
        return;
    }
    
    Product product = (Product) request.getAttribute("product");
    boolean isEdit = product != null;
    String action = isEdit ? "edit" : "add";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= isEdit ? "Edit" : "Add" %> Product - Admin</title>
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
                <a href="<%= request.getContextPath() %>/admin/products" class="back-link">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M19 12H5M5 12L12 19M5 12L12 5" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    Back to Products
                </a>
                <h1 class="admin-page-title"><%= isEdit ? "Edit Product" : "Add New Product" %></h1>
            </div>
            <div class="admin-header-right">
                <a href="<%= request.getContextPath() %>/admin/logout" class="admin-logout-btn">Logout</a>
            </div>
        </div>
    </div>
    
    <div class="admin-container">
        <% if (request.getAttribute("error") != null) { %>
            <div class="message error-message">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <div class="product-form-container">
            <form action="<%= request.getContextPath() %>/admin/products" method="post" class="product-form">
                <input type="hidden" name="action" value="<%= action %>">
                <% if (isEdit) { %>
                    <input type="hidden" name="id" value="<%= product.getId() %>">
                <% } %>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="name">Product Name *</label>
                        <input type="text" id="name" name="name" class="form-input" 
                               value="<%= isEdit ? product.getName() : "" %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="category">Category *</label>
                        <select id="category" name="category" class="form-input" required>
                            <option value="">Select Category</option>
                            <option value="men" <%= isEdit && "men".equals(product.getCategory()) ? "selected" : "" %>>Men</option>
                            <option value="women" <%= isEdit && "women".equals(product.getCategory()) ? "selected" : "" %>>Women</option>
                            <option value="kids" <%= isEdit && "kids".equals(product.getCategory()) ? "selected" : "" %>>Kids</option>
                            <option value="accessories" <%= isEdit && "accessories".equals(product.getCategory()) ? "selected" : "" %>>Accessories</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="description">Description *</label>
                    <textarea id="description" name="description" class="form-input form-textarea" rows="4" required><%= isEdit ? product.getDescription() : "" %></textarea>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="price">Price ($) *</label>
                        <input type="number" id="price" name="price" class="form-input" 
                               step="0.01" min="0" 
                               value="<%= isEdit ? product.getPrice() : "" %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="stock">Stock Quantity *</label>
                        <input type="number" id="stock" name="stock" class="form-input" 
                               min="0" 
                               value="<%= isEdit ? product.getStock() : "" %>" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="imageUrl">Image URL</label>
                    <input type="url" id="imageUrl" name="imageUrl" class="form-input" 
                           value="<%= isEdit && product.getImageUrl() != null ? product.getImageUrl() : "" %>"
                           placeholder="https://example.com/image.jpg">
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="submit-btn">
                        <%= isEdit ? "Update Product" : "Add Product" %>
                    </button>
                    <a href="<%= request.getContextPath() %>/admin/products" class="cancel-btn">Cancel</a>
                </div>
            </form>
        </div>
    </div>
    
    <script src="<%= request.getContextPath() %>/js/modal.js"></script>
    <script src="<%= request.getContextPath() %>/js/admin-logout.js"></script>
</body>
</html>
