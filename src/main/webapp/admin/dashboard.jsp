<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.math.BigDecimal" %>
<%
    // Check if admin is logged in
    String adminUser = (String) session.getAttribute("adminUser");
    if (adminUser == null || !"admin".equals(adminUser)) {
        response.sendRedirect(request.getContextPath() + "/admin");
        return;
    }
    
    // Get dashboard statistics
    Integer totalUsers = (Integer) request.getAttribute("totalUsers");
    Integer totalProducts = (Integer) request.getAttribute("totalProducts");
    Integer totalOrders = (Integer) request.getAttribute("totalOrders");
    BigDecimal totalRevenue = (BigDecimal) request.getAttribute("totalRevenue");
    
    // Set defaults if null
    if (totalUsers == null) totalUsers = 0;
    if (totalProducts == null) totalProducts = 0;
    if (totalOrders == null) totalOrders = 0;
    if (totalRevenue == null) totalRevenue = BigDecimal.ZERO;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Fashion Store</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Belleza&family=Tinos:ital,wght@0,400;0,700;1,400&family=Smooch+Sans:wght@100..1000&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <link rel="stylesheet" type="text/css" href="../css/modal.css">
    <link rel="stylesheet" type="text/css" href="../css/admin-dashboard.css">
</head>
<body class="admin-dashboard-page">
    <div class="admin-header">
        <div class="admin-header-content">
            <div class="admin-header-left">
                <h1 class="admin-dashboard-title">Admin Dashboard</h1>
            </div>
            <div class="admin-header-right">
                <a href="<%= request.getContextPath() %>/admin/logout" class="admin-logout-btn" id="adminLogoutBtn">Logout</a>
            </div>
        </div>
    </div>
    
    <div class="admin-container">
        <div class="admin-welcome">
            <h2>Welcome, Admin!</h2>
            <p>Manage your store from here</p>
        </div>
        
        <div class="admin-stats">
            <div class="stat-card">
                <div class="stat-icon">
                    <svg width="32" height="32" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M16 7C16 9.20914 14.2091 11 12 11C9.79086 11 8 9.20914 8 7C8 4.79086 9.79086 3 12 3C14.2091 3 16 4.79086 16 7Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M12 14C8.13401 14 5 17.134 5 21H19C19 17.134 15.866 14 12 14Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>
                <div class="stat-content">
                    <h3>Users</h3>
                    <p class="stat-number"><%= totalUsers %></p>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <svg width="32" height="32" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M21 16V8C21 7.46957 20.7893 6.96086 20.4142 6.58579C20.0391 6.21071 19.5304 6 19 6H5C4.46957 6 3.96086 6.21071 3.58579 6.58579C3.21071 6.96086 3 7.46957 3 8V16C3 16.5304 3.21071 17.0391 3.58579 17.4142C3.96086 17.7893 4.46957 18 5 18H19C19.5304 18 20.0391 17.7893 20.4142 17.4142C20.7893 17.0391 21 16.5304 21 16Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M3 10H21" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>
                <div class="stat-content">
                    <h3>Products</h3>
                    <p class="stat-number"><%= totalProducts %></p>
                </div>
            </div>
            
            <a href="<%= request.getContextPath() %>/admin/orders" class="stat-card-link">
                <div class="stat-card">
                    <div class="stat-icon">
                        <svg width="32" height="32" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M9 11L12 14L22 4" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M21 12V19C21 19.5304 20.7893 20.0391 20.4142 20.4142C20.0391 20.7893 19.5304 21 19 21H5C4.46957 21 3.96086 20.7893 3.58579 20.4142C3.21071 20.0391 3 19.5304 3 19V5C3 4.46957 3.21071 3.96086 3.58579 3.58579C3.96086 3.21071 4.46957 3 5 3H16" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </div>
                    <div class="stat-content">
                        <h3>Orders</h3>
                        <p class="stat-number"><%= totalOrders %></p>
                    </div>
                </div>
            </a>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <svg width="32" height="32" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M12 2V6M12 18V22M6 12H2M22 12H18M19.07 19.07L16.24 16.24M19.07 4.93L16.24 7.76M4.93 19.07L7.76 16.24M4.93 4.93L7.76 7.76" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>
                <div class="stat-content">
                    <h3>Revenue</h3>
                    <p class="stat-number">$<%= String.format("%.2f", totalRevenue) %></p>
                </div>
            </div>
        </div>
        
        <div class="admin-actions">
            <h3>Quick Actions</h3>
            <div class="action-buttons">
                <a href="<%= request.getContextPath() %>/admin/products" class="action-btn">
                    <span>Manage Products</span>
                </a>
                <a href="<%= request.getContextPath() %>/admin/orders" class="action-btn">
                    <span>Manage Orders</span>
                </a>
                <a href="<%= request.getContextPath() %>" class="action-btn">
                    <span>View Website</span>
                </a>
            </div>
        </div>
    </div>
    
    <script src="<%= request.getContextPath() %>/js/modal.js"></script>
    <script src="<%= request.getContextPath() %>/js/admin-logout.js"></script>
</body>
</html>
