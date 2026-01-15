package com.mycompany.onlineshoppingcart.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.mycompany.onlineshoppingcart.dao.OrderDAO;
import com.mycompany.onlineshoppingcart.model.Order;
import com.mycompany.onlineshoppingcart.model.User;

@WebServlet("/order-details")
public class OrderDetailsServlet extends HttpServlet {
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
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String orderIdParam = request.getParameter("id");
        if (orderIdParam == null || orderIdParam.isEmpty()) {
            response.sendRedirect("orders");
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdParam);
            Order order = orderDAO.getOrderById(orderId);
            
            if (order == null) {
                response.sendRedirect("orders");
                return;
            }
            
            // Verify that the order belongs to the logged-in user
            if (order.getUserId() != user.getId() && !"admin".equals(user.getRole())) {
                response.sendRedirect("orders");
                return;
            }
            
            request.setAttribute("order", order);
            request.getRequestDispatcher("/order-details.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("orders");
        }
    }
}
