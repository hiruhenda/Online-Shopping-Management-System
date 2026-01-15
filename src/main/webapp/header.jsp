<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mycompany.onlineshoppingcart.model.User" %>
<%@ page import="com.mycompany.onlineshoppingcart.model.Cart" %>
<%@ page import="com.mycompany.onlineshoppingcart.model.CartItem" %>
<%
    User user = (User) session.getAttribute("user");
    Cart cart = (Cart) session.getAttribute("cart");
    int cartItemCount = (cart != null) ? cart.getTotalItems() : 0;
%>
<header class="main-header">
    <nav class="navbar">
        <div class="nav-container">
            <div class="logo">
                <a href="index.jsp">
                    <span class="logo-text">Fashion</span>
                    <span class="logo-accent">Store</span>
                </a>
            </div>
            
            <ul class="nav-menu" id="navMenu">
                <li class="nav-item">
                    <a href="index.jsp" class="nav-link">Home</a>
                </li>
                <li class="nav-item">
                    <a href="products" class="nav-link">Products</a>
                </li>
                <%
                    if (user != null) {
                %>
                <li class="nav-item cart-dropdown-wrapper">
                    <a href="cart" class="nav-link cart-link">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M3 3H5L5.4 5M7 13H17L21 5H5.4M7 13L5.4 5M7 13L4.7 15.3C4.3 15.7 4.6 16.5 5.1 16.5H19M17 13V17C17 18.1 17.9 19 19 19C20.1 19 21 18.1 21 17V13M9 19.5C9.8 19.5 10.5 20.2 10.5 21C10.5 21.8 9.8 22.5 9 22.5C8.2 22.5 7.5 21.8 7.5 21C7.5 20.2 8.2 19.5 9 19.5ZM20 19.5C20.8 19.5 21.5 20.2 21.5 21C21.5 21.8 20.8 22.5 20 22.5C19.2 22.5 18.5 21.8 18.5 21C18.5 20.2 19.2 19.5 20 19.5Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <span class="cart-text">Cart</span>
                        <span class="cart-badge"><%= cartItemCount %></span>
                    </a>
                    <div class="cart-dropdown" id="cartDropdown">
                        <div class="cart-dropdown-header">
                            <h3>Shopping Cart</h3>
                            <span class="cart-item-count"><%= cartItemCount %> item<%= cartItemCount != 1 ? "s" : "" %></span>
                        </div>
                        <div class="cart-dropdown-items">
                            <%
                                if (cart != null && !cart.getItems().isEmpty()) {
                                    int displayLimit = 3;
                                    int count = 0;
                                    for (CartItem item : cart.getItems()) {
                                        if (count >= displayLimit) break;
                            %>
                            <div class="cart-dropdown-item">
                                <div class="cart-item-image">
                                    <% if (item.getProduct().getImageUrl() != null && !item.getProduct().getImageUrl().isEmpty()) { %>
                                        <img src="<%= item.getProduct().getImageUrl() %>" alt="<%= item.getProduct().getName() %>">
                                    <% } else { %>
                                        <div class="cart-item-placeholder">No Image</div>
                                    <% } %>
                                </div>
                                <div class="cart-item-details">
                                    <h4><%= item.getProduct().getName() %></h4>
                                    <p class="cart-item-quantity">Qty: <%= item.getQuantity() %></p>
                                    <p class="cart-item-price">$<%= String.format("%.2f", item.getSubtotal()) %></p>
                                </div>
                            </div>
                            <%
                                        count++;
                                    }
                                    if (cart.getItems().size() > displayLimit) {
                            %>
                            <div class="cart-dropdown-more">
                                <p>+<%= cart.getItems().size() - displayLimit %> more item<%= (cart.getItems().size() - displayLimit) != 1 ? "s" : "" %></p>
                            </div>
                            <%
                                    }
                                } else {
                            %>
                            <div class="cart-dropdown-empty">
                                <p>Your cart is empty</p>
                            </div>
                            <%
                                }
                            %>
                        </div>
                        <%
                            if (cart != null && !cart.getItems().isEmpty()) {
                        %>
                        <div class="cart-dropdown-footer">
                            <div class="cart-dropdown-total">
                                <span>Total:</span>
                                <span class="cart-total-amount">$<%= String.format("%.2f", cart.getTotal()) %></span>
                            </div>
                            <a href="cart" class="btn-view-cart">View Cart</a>
                            <a href="checkout" class="btn-checkout">Checkout</a>
                        </div>
                        <%
                            } else {
                        %>
                        <div class="cart-dropdown-footer">
                            <a href="products" class="btn-view-cart">Start Shopping</a>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </li>
                <%
                    }
                %>
                <%
                    if (user != null) {
                %>
                <li class="nav-item">
                    <a href="orders" class="nav-link">Orders</a>
                </li>
                <%
                        if ("admin".equals(user.getRole())) {
                %>
                <li class="nav-item">
                    <a href="admin-products.jsp" class="nav-link admin-link">Admin</a>
                </li>
                <%
                        }
                %>
                <li class="nav-item dropdown">
                    <a href="#" class="nav-link user-link">
                        <span class="user-name"><%= (user.getFirstName() != null && !user.getFirstName().isEmpty()) ? user.getFirstName() : user.getUsername() %></span>
                        <svg class="dropdown-icon" width="12" height="12" viewBox="0 0 12 12" fill="none">
                            <path d="M2 4L6 8L10 4" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                        </svg>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="logout" class="dropdown-item">Logout</a></li>
                    </ul>
                </li>
                <%
                    } else {
                %>
                <li class="nav-item">
                    <a href="login.jsp" class="nav-link">Login</a>
                </li>
                <li class="nav-item">
                    <a href="register.jsp" class="nav-link nav-btn">Sign Up</a>
                </li>
                <%
                    }
                %>
            </ul>
            
            <button class="hamburger" id="hamburger" aria-label="Toggle menu">
                <span></span>
                <span></span>
                <span></span>
            </button>
        </div>
    </nav>
</header>
<script>
// Mobile Hamburger Menu - Works on all pages
(function() {
    const hamburger = document.getElementById('hamburger');
    const navMenu = document.getElementById('navMenu');
    
    if (hamburger && navMenu) {
        hamburger.addEventListener('click', function() {
            hamburger.classList.toggle('active');
            navMenu.classList.toggle('active');
            document.body.style.overflow = navMenu.classList.contains('active') ? 'hidden' : '';
        });
        
        // Close menu when clicking on a link
        const navLinks = navMenu.querySelectorAll('.nav-link');
        navLinks.forEach(function(link) {
            link.addEventListener('click', function() {
                hamburger.classList.remove('active');
                navMenu.classList.remove('active');
                document.body.style.overflow = '';
            });
        });
        
        // Close menu when clicking outside
        document.addEventListener('click', function(e) {
            if (!hamburger.contains(e.target) && !navMenu.contains(e.target) && navMenu.classList.contains('active')) {
                hamburger.classList.remove('active');
                navMenu.classList.remove('active');
                document.body.style.overflow = '';
            }
        });
    }
    
    // Header scroll effect
    window.addEventListener('scroll', function() {
        const header = document.querySelector('.main-header');
        if (header) {
            if (window.scrollY > 50) {
                header.classList.add('scrolled');
            } else {
                header.classList.remove('scrolled');
            }
        }
    }, { passive: true });
    
    // Update cart badge on page load
    function updateCartBadge() {
        // This will be updated via server-side rendering
        // For dynamic updates, you can use AJAX to fetch cart count
    }
    
    updateCartBadge();
})();
</script>
<script src="js/modal.js"></script>