<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.onlineshoppingcart.model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin - Products Management</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="container">
        <h1>Products Management</h1>
        <a href="admin-product-form.jsp" class="btn">Add New Product</a>
        
        <table class="admin-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Product> products = (List<Product>) request.getAttribute("products");
                    if (products != null && !products.isEmpty()) {
                        for (Product product : products) {
                %>
                <tr>
                    <td><%= product.getId() %></td>
                    <td><%= product.getName() %></td>
                    <td><%= product.getCategory() %></td>
                    <td>$<%= product.getPrice() %></td>
                    <td><%= product.getStock() %></td>
                    <td>
                        <a href="admin-product-edit.jsp?id=<%= product.getId() %>" class="btn">Edit</a>
                        <a href="admin-product-delete?id=<%= product.getId() %>" class="btn-danger">Delete</a>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="6">No products found.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
    
    <jsp:include page="footer.jsp" />
</body>
</html>
