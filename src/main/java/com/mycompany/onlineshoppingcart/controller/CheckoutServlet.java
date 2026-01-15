package com.mycompany.onlineshoppingcart.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.mycompany.onlineshoppingcart.model.Cart;
import com.mycompany.onlineshoppingcart.model.CartItem;
import com.mycompany.onlineshoppingcart.model.Order;
import com.mycompany.onlineshoppingcart.model.OrderItem;
import com.mycompany.onlineshoppingcart.model.User;
import com.mycompany.onlineshoppingcart.dao.OrderDAO;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        request.setAttribute("cart", cart);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        if (cart == null || cart.getItems().isEmpty()) {
            request.setAttribute("error", "Your cart is empty. Please add items before checkout.");
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);
            return;
        }
        
        // Get form parameters
        String shippingAddress = request.getParameter("shippingAddress");
        String fullName = request.getParameter("fullName");
        String city = request.getParameter("city");
        String zipCode = request.getParameter("zipCode");
        String phone = request.getParameter("phone");
        String paymentMethod = request.getParameter("paymentMethod");
        
        // Validate required fields
        if (shippingAddress == null || shippingAddress.trim().isEmpty() ||
            fullName == null || fullName.trim().isEmpty() ||
            city == null || city.trim().isEmpty() ||
            zipCode == null || zipCode.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty()) {
            
            request.setAttribute("error", "Please fill in all required fields.");
            request.setAttribute("cart", cart);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);
            return;
        }
        
        // Build complete shipping address
        String completeAddress = fullName.trim() + "\n" + 
                                shippingAddress.trim() + "\n" +
                                city.trim() + ", " + zipCode.trim() + "\n" +
                                "Phone: " + phone.trim();
        
        // Calculate totals
        BigDecimal subtotal = cart.getTotal();
        BigDecimal shipping = subtotal.doubleValue() > 100 ? BigDecimal.ZERO : new BigDecimal("10.00");
        BigDecimal tax = subtotal.multiply(new BigDecimal("0.08")); // 8% tax
        BigDecimal totalAmount = subtotal.add(shipping).add(tax);
        
        // Create order
        Order order = new Order();
        order.setUserId(user.getId());
        order.setOrderDate(new Date());
        order.setStatus("pending");
        order.setTotalAmount(totalAmount);
        order.setShippingAddress(completeAddress);
        
        // Add order items
        for (CartItem cartItem : cart.getItems()) {
            OrderItem orderItem = new OrderItem();
            orderItem.setProductId(cartItem.getProduct().getId());
            orderItem.setProductName(cartItem.getProduct().getName());
            orderItem.setPrice(cartItem.getProduct().getPrice());
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setSubtotal(cartItem.getSubtotal());
            order.getItems().add(orderItem);
        }
        
        // Save order to database
        if (orderDAO.createOrder(order)) {
            // Clear cart
            cart.clear();
            session.setAttribute("cart", cart);
            
            // Redirect to orders page with success message
            response.sendRedirect(request.getContextPath() + "/orders?success=Order placed successfully!");
        } else {
            request.setAttribute("error", "Failed to place order. Please try again.");
            request.setAttribute("cart", cart);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);
        }
    }
}
