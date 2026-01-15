<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin - Reports</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="container">
        <h1>Admin Reports</h1>
        
        <div class="reports-grid">
            <div class="report-card">
                <h3>Sales Report</h3>
                <p>Total Sales: $0.00</p>
                <p>Total Orders: 0</p>
                <a href="admin-sales-report" class="btn">View Details</a>
            </div>
            
            <div class="report-card">
                <h3>Product Report</h3>
                <p>Total Products: 0</p>
                <p>Low Stock Items: 0</p>
                <a href="admin-product-report" class="btn">View Details</a>
            </div>
            
            <div class="report-card">
                <h3>User Report</h3>
                <p>Total Users: 0</p>
                <p>Active Users: 0</p>
                <a href="admin-user-report" class="btn">View Details</a>
            </div>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
</body>
</html>
