<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.onlineshoppingcart.model.Order" %>
<%@ page import="com.mycompany.onlineshoppingcart.dao.UserDAO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    // Check if admin is logged in
    String adminUser = (String) session.getAttribute("adminUser");
    if (adminUser == null || !"admin".equals(adminUser)) {
        response.sendRedirect(request.getContextPath() + "/admin");
        return;
    }
    
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    UserDAO userDAO = new UserDAO();
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy HH:mm");
    SimpleDateFormat dateFormatShort = new SimpleDateFormat("dd MMM yyyy");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Orders - Admin</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Belleza&family=Tinos:ital,wght@0,400;0,700;1,400&family=Smooch+Sans:wght@100..1000&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <link rel="stylesheet" type="text/css" href="../css/modal.css">
    <link rel="stylesheet" type="text/css" href="../css/admin-orders.css">
</head>
<body class="admin-orders-page">
    <div class="admin-header">
        <div class="admin-header-content">
            <div class="admin-header-left">
                <a href="<%= request.getContextPath() %>/admin/dashboard" class="back-link">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M19 12H5M5 12L12 19M5 12L12 5" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    Dashboard
                </a>
                <h1 class="admin-page-title">Manage Orders</h1>
            </div>
            <div class="admin-header-right">
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
                <% if ("updated".equals(success)) { %>
                    Order status updated successfully!
                <% } %>
            </div>
        <% } %>
        
        <% if (error != null) { %>
            <div class="message error-message">
                <% if ("updateFailed".equals(error)) { %>
                    Failed to update order status. Please try again.
                <% } else if ("invalidId".equals(error)) { %>
                    Invalid order ID.
                <% } else { %>
                    An error occurred. Please try again.
                <% } %>
            </div>
        <% } %>
        
        <!-- Filter Tabs -->
        <div class="orders-filter-tabs">
            <button class="filter-tab active" data-status="all" onclick="filterOrders('all')">
                All Orders
            </button>
            <button class="filter-tab" data-status="pending" onclick="filterOrders('pending')">
                Pending
            </button>
            <button class="filter-tab" data-status="processing" onclick="filterOrders('processing')">
                Processing
            </button>
            <button class="filter-tab" data-status="shipped" onclick="filterOrders('shipped')">
                Shipped
            </button>
            <button class="filter-tab" data-status="delivered" onclick="filterOrders('delivered')">
                Delivered
            </button>
            <button class="filter-tab" data-status="cancelled" onclick="filterOrders('cancelled')">
                Cancelled
            </button>
        </div>
        
        <!-- Orders Table -->
        <div class="orders-table-container">
            <% if (orders != null && !orders.isEmpty()) { %>
                <table class="orders-table">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Customer</th>
                            <th>Date</th>
                            <th>Items</th>
                            <th>Total</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Order order : orders) {
                                com.mycompany.onlineshoppingcart.model.User customer = userDAO.getUserById(order.getUserId());
                                String customerName = customer != null 
                                    ? (customer.getFirstName() != null && !customer.getFirstName().isEmpty() 
                                        ? customer.getFirstName() + " " + (customer.getLastName() != null ? customer.getLastName() : "")
                                        : customer.getUsername())
                                    : "Unknown User";
                                String orderIdFormatted = "CTH-" + String.format("%05d", order.getId());
                                String status = order.getStatus().toLowerCase();
                                int itemCount = order.getItems() != null ? order.getItems().size() : 0;
                        %>
                        <tr class="order-row" data-status="<%= status %>">
                            <td class="order-id-cell">
                                <span class="order-id-value"><%= orderIdFormatted %></span>
                            </td>
                            <td class="customer-cell">
                                <div class="customer-info">
                                    <span class="customer-name"><%= customerName %></span>
                                    <% if (customer != null && customer.getEmail() != null) { %>
                                    <span class="customer-email"><%= customer.getEmail() %></span>
                                    <% } %>
                                </div>
                            </td>
                            <td class="date-cell">
                                <span class="order-date"><%= dateFormatShort.format(order.getOrderDate()) %></span>
                                <span class="order-time"><%= dateFormat.format(order.getOrderDate()) %></span>
                            </td>
                            <td class="items-cell">
                                <span class="items-count"><%= itemCount %> item<%= itemCount != 1 ? "s" : "" %></span>
                            </td>
                            <td class="total-cell">
                                <span class="order-total">Rp <%= String.format("%,.0f", order.getTotalAmount().doubleValue()) %></span>
                            </td>
                            <td class="status-cell">
                                <select class="status-select" data-order-id="<%= order.getId() %>" onchange="updateOrderStatus(<%= order.getId() %>, this.value)">
                                    <option value="pending" <%= "pending".equals(status) ? "selected" : "" %>>Pending</option>
                                    <option value="processing" <%= "processing".equals(status) ? "selected" : "" %>>Processing</option>
                                    <option value="shipped" <%= "shipped".equals(status) ? "selected" : "" %>>Shipped</option>
                                    <option value="delivered" <%= "delivered".equals(status) || "arrived".equals(status) ? "selected" : "" %>>Delivered</option>
                                    <option value="cancelled" <%= status.contains("cancel") ? "selected" : "" %>>Cancelled</option>
                                </select>
                            </td>
                            <td class="actions-cell">
                                <a href="<%= request.getContextPath() %>/order-details?id=<%= order.getId() %>" class="action-btn view-btn" target="_blank">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M1 12C1 12 5 4 12 4C19 4 23 12 23 12C23 12 19 20 12 20C5 20 1 12 1 12Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                        <path d="M12 15C13.6569 15 15 13.6569 15 12C15 10.3431 13.6569 9 12 9C10.3431 9 9 10.3431 9 12C9 13.6569 10.3431 15 12 15Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                    </svg>
                                    View
                                </a>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            <% } else { %>
                <div class="empty-orders">
                    <svg class="empty-icon" width="64" height="64" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M9 11L12 14L22 4" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M21 12V19C21 19.5304 20.7893 20.0391 20.4142 20.4142C20.0391 20.7893 19.5304 21 19 21H5C4.46957 21 3.96086 20.7893 3.58579 20.4142C3.21071 20.0391 3 19.5304 3 19V5C3 4.46957 3.21071 3.96086 3.58579 3.58579C3.96086 3.21071 4.46957 3 5 3H16" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    <h3>No orders found</h3>
                    <p>There are no orders in the system yet.</p>
                </div>
            <% } %>
        </div>
    </div>
    
    <script>
        function filterOrders(status) {
            // Update active tab
            document.querySelectorAll('.filter-tab').forEach(tab => {
                tab.classList.remove('active');
            });
            event.target.classList.add('active');
            
            // Filter orders
            const rows = document.querySelectorAll('.order-row');
            rows.forEach(row => {
                if (status === 'all' || row.getAttribute('data-status') === status) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }
        
        function updateOrderStatus(orderId, newStatus) {
            if (!confirm('Are you sure you want to update the order status?')) {
                // Reset to previous value
                location.reload();
                return;
            }
            
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '<%= request.getContextPath() %>/admin/orders';
            
            const actionInput = document.createElement('input');
            actionInput.type = 'hidden';
            actionInput.name = 'action';
            actionInput.value = 'updateStatus';
            form.appendChild(actionInput);
            
            const orderIdInput = document.createElement('input');
            orderIdInput.type = 'hidden';
            orderIdInput.name = 'orderId';
            orderIdInput.value = orderId;
            form.appendChild(orderIdInput);
            
            const statusInput = document.createElement('input');
            statusInput.type = 'hidden';
            statusInput.name = 'status';
            statusInput.value = newStatus;
            form.appendChild(statusInput);
            
            document.body.appendChild(form);
            form.submit();
        }
        
        // Initialize: Show all orders by default
        document.addEventListener('DOMContentLoaded', function() {
            filterOrders('all');
        });
    </script>
    
    <script src="<%= request.getContextPath() %>/js/modal.js"></script>
    <script src="<%= request.getContextPath() %>/js/admin-logout.js"></script>
</body>
</html>
