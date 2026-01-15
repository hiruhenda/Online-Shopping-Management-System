<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mycompany.onlineshoppingcart.model.Order" %>
<%@ page import="com.mycompany.onlineshoppingcart.model.OrderItem" %>
<%@ page import="com.mycompany.onlineshoppingcart.model.Product" %>
<%@ page import="com.mycompany.onlineshoppingcart.dao.ProductDAO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%
    Order order = (Order) request.getAttribute("order");
    if (order == null) {
        response.sendRedirect("orders");
        return;
    }
    
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMMM yyyy");
    SimpleDateFormat dateTimeFormat = new SimpleDateFormat("dd MMMM yyyy 'at' HH:mm");
    ProductDAO productDAO = new ProductDAO();
    
    // Calculate estimated arrival date (7 days from order date)
    Calendar cal = Calendar.getInstance();
    cal.setTime(order.getOrderDate());
    cal.add(Calendar.DAY_OF_MONTH, 7);
    String estimatedArrival = dateFormat.format(cal.getTime());
    
    // Format order ID
    String orderIdFormatted = "CTH-" + String.format("%05d", order.getId());
    
    // Determine status badge
    String status = order.getStatus().toLowerCase();
    String statusBadge = "On Deliver";
    String statusBadgeClass = "status-on-deliver";
    
    if (status.contains("shipped") || status.contains("processing") || status.contains("pending")) {
        statusBadge = "On Deliver";
        statusBadgeClass = "status-on-deliver";
    } else if (status.contains("delivered") || status.contains("arrived")) {
        statusBadge = "Arrived";
        statusBadgeClass = "status-arrived";
    } else if (status.contains("cancel")) {
        statusBadge = "Canceled";
        statusBadgeClass = "status-canceled";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details - <%= orderIdFormatted %></title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Belleza&family=Tinos:ital,wght@0,400;0,700;1,400&family=Smooch+Sans:wght@100..1000&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/order-details.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="order-details-page">
        <div class="order-details-container">
            <!-- Breadcrumb -->
            <nav class="breadcrumb">
                <a href="index.jsp">Home</a>
                <span>/</span>
                <a href="orders">My Orders</a>
                <span>/</span>
                <span>Order Details</span>
            </nav>
            
            <!-- Order Header -->
            <div class="order-header-section">
                <div class="order-header-left">
                    <h1 class="order-details-title">Order Details</h1>
                    <p class="order-id-text">Order ID: <span class="order-id-value"><%= orderIdFormatted %></span></p>
                </div>
                <div class="order-header-right">
                    <span class="status-badge-large <%= statusBadgeClass %>"><%= statusBadge %></span>
                </div>
            </div>
            
            <!-- Order Info Cards -->
            <div class="order-info-grid">
                <!-- Order Date Card -->
                <div class="info-card">
                    <div class="info-card-icon">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M8 2V6M16 2V6M3 10H21M5 4H19C20.1046 4 21 4.89543 21 6V20C21 21.1046 20.1046 22 19 22H5C3.89543 22 3 21.1046 3 20V6C3 4.89543 3.89543 4 5 4Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </div>
                    <div class="info-card-content">
                        <h3 class="info-card-label">Order Date</h3>
                        <p class="info-card-value"><%= dateTimeFormat.format(order.getOrderDate()) %></p>
                    </div>
                </div>
                
                <!-- Estimated Arrival Card -->
                <div class="info-card">
                    <div class="info-card-icon">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M12 2L2 7L12 12L22 7L12 2Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M2 17L12 22L22 17" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M2 12L12 17L22 12" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </div>
                    <div class="info-card-content">
                        <h3 class="info-card-label">Estimated Arrival</h3>
                        <p class="info-card-value"><%= estimatedArrival %></p>
                    </div>
                </div>
                
                <!-- Shipping Address Card -->
                <div class="info-card">
                    <div class="info-card-icon">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M21 10C21 17 12 23 12 23S3 17 3 10C3 5.02944 7.02944 1 12 1C16.9706 1 21 5.02944 21 10Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M12 13C13.6569 13 15 11.6569 15 10C15 8.34315 13.6569 7 12 7C10.3431 7 9 8.34315 9 10C9 11.6569 10.3431 13 12 13Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </div>
                    <div class="info-card-content">
                        <h3 class="info-card-label">Shipping Address</h3>
                        <p class="info-card-value"><%= order.getShippingAddress() != null && !order.getShippingAddress().isEmpty() ? order.getShippingAddress() : "Address not specified" %></p>
                    </div>
                </div>
            </div>
            
            <!-- Order Items Section -->
            <div class="order-items-section">
                <h2 class="section-title">Order Items</h2>
                <div class="order-items-list">
                    <%
                        for (OrderItem item : order.getItems()) {
                            Product product = productDAO.getProductById(item.getProductId());
                            String imageUrl = (product != null && product.getImageUrl() != null && !product.getImageUrl().isEmpty()) 
                                ? product.getImageUrl() 
                                : "https://via.placeholder.com/150x150?text=No+Image";
                    %>
                    <div class="order-item-card">
                        <img src="<%= imageUrl %>" alt="<%= item.getProductName() %>" class="order-item-image-large">
                        <div class="order-item-details">
                            <h3 class="order-item-name-large"><%= item.getProductName() %></h3>
                            <div class="order-item-specs">
                                <span class="item-spec">Size: M</span>
                                <span class="item-spec">Quantity: <%= item.getQuantity() %></span>
                            </div>
                            <div class="order-item-price-section">
                                <span class="item-price-label">Price:</span>
                                <span class="item-price-value">Rp <%= String.format("%,.0f", item.getPrice().doubleValue()) %></span>
                            </div>
                            <div class="order-item-subtotal">
                                <span class="item-subtotal-label">Subtotal:</span>
                                <span class="item-subtotal-value">Rp <%= String.format("%,.0f", item.getSubtotal().doubleValue()) %></span>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
            
            <!-- Order Summary Section -->
            <div class="order-summary-section">
                <h2 class="section-title">Order Summary</h2>
                <div class="summary-card">
                    <div class="summary-row">
                        <span class="summary-label">Subtotal:</span>
                        <span class="summary-value">Rp <%= String.format("%,.0f", order.getTotalAmount().doubleValue()) %></span>
                    </div>
                    <div class="summary-row">
                        <span class="summary-label">Shipping:</span>
                        <span class="summary-value">Free</span>
                    </div>
                    <div class="summary-row">
                        <span class="summary-label">Tax:</span>
                        <span class="summary-value">Rp 0</span>
                    </div>
                    <div class="summary-divider"></div>
                    <div class="summary-row summary-total">
                        <span class="summary-label">Total:</span>
                        <span class="summary-value">Rp <%= String.format("%,.0f", order.getTotalAmount().doubleValue()) %></span>
                    </div>
                </div>
            </div>
            
            <!-- Action Buttons -->
            <div class="order-actions">
                <a href="orders" class="btn-back">Back to Orders</a>
                <% if (status.contains("shipped") || status.contains("processing") || status.contains("pending")) { %>
                <button class="btn-track" onclick="trackOrder('<%= orderIdFormatted %>')">Track Order</button>
                <% } %>
            </div>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
    
    <script>
        function trackOrder(orderId) {
            alert('Tracking information for order ' + orderId + ' will be available soon.');
        }
    </script>
</body>
</html>
