<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.mycompany.onlineshoppingcart.model.Order" %>
<%@ page import="com.mycompany.onlineshoppingcart.model.OrderItem" %>
<%@ page import="com.mycompany.onlineshoppingcart.model.Product" %>
<%@ page import="com.mycompany.onlineshoppingcart.dao.ProductDAO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy");
    SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    
    // Create a map to store product images
    Map<Integer, String> productImages = new HashMap<>();
    ProductDAO productDAO = new ProductDAO();
    
    if (orders != null) {
        for (Order order : orders) {
            for (OrderItem item : order.getItems()) {
                if (!productImages.containsKey(item.getProductId())) {
                    Product product = productDAO.getProductById(item.getProductId());
                    if (product != null && product.getImageUrl() != null && !product.getImageUrl().isEmpty()) {
                        productImages.put(item.getProductId(), product.getImageUrl());
                    } else {
                        productImages.put(item.getProductId(), "https://via.placeholder.com/100x100?text=No+Image");
                    }
                }
            }
        }
    }
    
    // Calculate estimated arrival date (7 days from order date)
    Calendar cal = Calendar.getInstance();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders - Online Shopping Cart</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Belleza&family=Tinos:ital,wght@0,400;0,700;1,400&family=Smooch+Sans:wght@100..1000&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/orders.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="orders-page">
        <div class="orders-container">
            <!-- Page Title -->
            <h1 class="orders-title">My Orders</h1>
            
            <!-- Status Tabs -->
            <div class="orders-tabs">
                <button class="tab-btn active" data-status="shipping">
                    <span>On Shipping</span>
                    <span class="tab-badge" id="shipping-count">0</span>
                </button>
                <button class="tab-btn" data-status="arrived">
                    <span>Arrived</span>
                    <svg class="tab-icon" width="12" height="12" viewBox="0 0 12 12" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M3 4.5L6 7.5L9 4.5" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </button>
                <button class="tab-btn" data-status="canceled">
                    <span>Canceled</span>
                </button>
            </div>
            
            <!-- Orders List -->
            <div class="orders-list" id="ordersList">
                <%
                    if (orders != null && !orders.isEmpty()) {
                        int shippingCount = 0;
                        int arrivedCount = 0;
                        int canceledCount = 0;
                        
                        // Count orders by status
                        for (Order order : orders) {
                            String status = order.getStatus().toLowerCase();
                            if (status.contains("shipped") || status.contains("processing") || status.contains("pending")) {
                                shippingCount++;
                            } else if (status.contains("delivered") || status.contains("arrived")) {
                                arrivedCount++;
                            } else if (status.contains("cancel")) {
                                canceledCount++;
                            }
                        }
                %>
                <script>
                    document.getElementById('shipping-count').textContent = '<%= shippingCount %>';
                </script>
                <%
                        for (Order order : orders) {
                            String status = order.getStatus().toLowerCase();
                            String orderStatusClass = "shipping";
                            String statusBadge = "On Deliver";
                            String statusBadgeClass = "status-on-deliver";
                            
                            if (status.contains("shipped") || status.contains("processing") || status.contains("pending")) {
                                orderStatusClass = "shipping";
                                statusBadge = "On Deliver";
                                statusBadgeClass = "status-on-deliver";
                            } else if (status.contains("delivered") || status.contains("arrived")) {
                                orderStatusClass = "arrived";
                                statusBadge = "Arrived";
                                statusBadgeClass = "status-arrived";
                            } else if (status.contains("cancel")) {
                                orderStatusClass = "canceled";
                                statusBadge = "Canceled";
                                statusBadgeClass = "status-canceled";
                            }
                            
                            // Calculate estimated arrival date
                            cal.setTime(order.getOrderDate());
                            cal.add(Calendar.DAY_OF_MONTH, 7);
                            String estimatedArrival = dateFormat.format(cal.getTime());
                            
                            // Format order ID
                            String orderIdFormatted = "CTH-" + String.format("%05d", order.getId());
                %>
                <div class="order-card" data-status="<%= orderStatusClass %>">
                    <div class="order-card-header">
                        <div class="order-id-section">
                            <svg class="order-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M3 3H5L5.4 5M7 13H17L21 5H5.4M7 13L5.4 5M7 13L4.7 15.3C4.3 15.7 4.6 16.5 5.1 16.5H19M17 13V17C17 18.1 17.9 19 19 19C20.1 19 21 18.1 21 17V13" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                            <span class="order-id"><%= orderIdFormatted %></span>
                        </div>
                        <span class="status-badge <%= statusBadgeClass %>"><%= statusBadge %></span>
                    </div>
                    
                    <div class="order-details">
                        <div class="order-info-item">
                            <svg class="info-icon" width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M21 10C21 17 12 23 12 23S3 17 3 10C3 5.02944 7.02944 1 12 1C16.9706 1 21 5.02944 21 10Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                <path d="M12 13C13.6569 13 15 11.6569 15 10C15 8.34315 13.6569 7 12 7C10.3431 7 9 8.34315 9 10C9 11.6569 10.3431 13 12 13Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                            <span>Illinois, United States</span>
                        </div>
                        <div class="order-info-item">
                            <svg class="info-icon" width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M8 2V6M16 2V6M3 10H21M5 4H19C20.1046 4 21 4.89543 21 6V20C21 21.1046 20.1046 22 19 22H5C3.89543 22 3 21.1046 3 20V6C3 4.89543 3.89543 4 5 4Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                            <span>Estimated arrived <%= estimatedArrival %></span>
                        </div>
                        <div class="order-info-item">
                            <svg class="info-icon" width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M21 10C21 17 12 23 12 23S3 17 3 10C3 5.02944 7.02944 1 12 1C16.9706 1 21 5.02944 21 10Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                <path d="M12 13C13.6569 13 15 11.6569 15 10C15 8.34315 13.6569 7 12 7C10.3431 7 9 8.34315 9 10C9 11.6569 10.3431 13 12 13Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                            <span><%= order.getShippingAddress() != null ? order.getShippingAddress() : "Address not specified" %></span>
                        </div>
                    </div>
                    
                    <div class="order-items">
                        <%
                            for (OrderItem item : order.getItems()) {
                                String imageUrl = productImages.get(item.getProductId());
                                if (imageUrl == null) {
                                    imageUrl = "https://via.placeholder.com/100x100?text=No+Image";
                                }
                        %>
                        <div class="order-item">
                            <img src="<%= imageUrl %>" alt="<%= item.getProductName() %>" class="order-item-image">
                            <div class="order-item-info">
                                <h4 class="order-item-name"><%= item.getProductName() %></h4>
                                <div class="order-item-meta">
                                    <span class="order-item-price">Rp <%= String.format("%,.0f", item.getPrice().doubleValue()) %></span>
                                    <span class="order-item-size">M</span>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>
                    
                    <div class="order-footer">
                        <div class="order-total">
                            <span class="total-label">Total:</span>
                            <span class="total-amount">Rp <%= String.format("%,.0f", order.getTotalAmount().doubleValue()) %></span>
                        </div>
                        <button class="btn-details" onclick="viewOrderDetails(<%= order.getId() %>)">Details</button>
                    </div>
                </div>
                <%
                        }
                    } else {
                %>
                <div class="empty-orders">
                    <svg class="empty-icon" width="64" height="64" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M3 3H5L5.4 5M7 13H17L21 5H5.4M7 13L5.4 5M7 13L4.7 15.3C4.3 15.7 4.6 16.5 5.1 16.5H19M17 13V17C17 18.1 17.9 19 19 19C20.1 19 21 18.1 21 17V13M9 19.5C9.8 19.5 10.5 20.2 10.5 21C10.5 21.8 9.8 22.5 9 22.5C8.2 22.5 7.5 21.8 7.5 21C7.5 20.2 8.2 19.5 9 19.5ZM20 19.5C20.8 19.5 21.5 20.2 21.5 21C21.5 21.8 20.8 22.5 20 22.5C19.2 22.5 18.5 21.8 18.5 21C18.5 20.2 19.2 19.5 20 19.5Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    <h3>You have no orders yet</h3>
                    <p>Start shopping to see your orders here</p>
                    <a href="products" class="btn-start-shopping">Start Shopping</a>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
    
    <script>
        function filterOrders(status, element) {
            // Update active tab
            document.querySelectorAll('.tab-btn').forEach(btn => {
                btn.classList.remove('active');
            });
            if (element) {
                element.classList.add('active');
            } else {
                document.querySelector(`[data-status="${status}"]`)?.classList.add('active');
            }
            
            // Filter orders
            const orders = document.querySelectorAll('.order-card');
            orders.forEach(order => {
                if (status === 'all' || order.getAttribute('data-status') === status) {
                    order.style.display = 'block';
                } else {
                    order.style.display = 'none';
                }
            });
        }
        
        function viewOrderDetails(orderId) {
            // Navigate to order details page or show modal
            window.location.href = 'order-details?id=' + orderId;
        }
        
        // Initialize: Show shipping orders by default
        document.addEventListener('DOMContentLoaded', function() {
            filterOrders('shipping');
            
            // Add click handlers to tab buttons
            document.querySelectorAll('.tab-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    const status = this.getAttribute('data-status');
                    filterOrders(status, this);
                });
            });
        });
    </script>
</body>
</html>
