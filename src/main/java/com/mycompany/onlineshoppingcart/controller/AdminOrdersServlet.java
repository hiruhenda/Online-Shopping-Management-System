package com.mycompany.onlineshoppingcart.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.mycompany.onlineshoppingcart.dao.OrderDAO;

@WebServlet("/admin/orders")
public class AdminOrdersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check if admin is logged in
        if (session == null || !"admin".equals(session.getAttribute("adminUser"))) {
            response.sendRedirect(request.getContextPath() + "/admin");
            return;
        }
        
        // Get all orders
        List<com.mycompany.onlineshoppingcart.model.Order> orders = orderDAO.getAllOrders();
        request.setAttribute("orders", orders);
        
        request.getRequestDispatcher("/admin/orders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check if admin is logged in
        if (session == null || !"admin".equals(session.getAttribute("adminUser"))) {
            response.sendRedirect(request.getContextPath() + "/admin");
            return;
        }
        
        String action = request.getParameter("action");
        String orderIdParam = request.getParameter("orderId");
        String status = request.getParameter("status");
        
        if ("updateStatus".equals(action) && orderIdParam != null && status != null) {
            try {
                int orderId = Integer.parseInt(orderIdParam);
                boolean success = orderDAO.updateOrderStatus(orderId, status);
                
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin/orders?success=updated");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/orders?error=updateFailed");
                }
                return;
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/orders?error=invalidId");
                return;
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }
}
