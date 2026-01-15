package com.mycompany.onlineshoppingcart.controller;

import java.io.IOException;
import java.math.BigDecimal;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.mycompany.onlineshoppingcart.dao.StatsDAO;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StatsDAO statsDAO;

    @Override
    public void init() throws ServletException {
        statsDAO = new StatsDAO();
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
        
        // Fetch dashboard statistics
        int totalUsers = statsDAO.getTotalUsers();
        int totalProducts = statsDAO.getTotalProducts();
        int totalOrders = statsDAO.getTotalOrders();
        BigDecimal totalRevenue = statsDAO.getTotalRevenueAll();
        
        // Set attributes for JSP
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalRevenue", totalRevenue);
        
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}
