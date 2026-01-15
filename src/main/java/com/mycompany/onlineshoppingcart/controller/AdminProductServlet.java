package com.mycompany.onlineshoppingcart.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.mycompany.onlineshoppingcart.dao.ProductDAO;
import com.mycompany.onlineshoppingcart.model.Product;

@WebServlet("/admin/products")
public class AdminProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
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
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "list":
                listProducts(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteProduct(request, response);
                break;
            default:
                listProducts(request, response);
                break;
        }
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
        
        if ("add".equals(action)) {
            addProduct(request, response);
        } else if ("edit".equals(action)) {
            updateProduct(request, response);
        } else {
            listProducts(request, response);
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> products = productDAO.getAllProducts();
        request.setAttribute("products", products);
        request.getRequestDispatcher("/admin/products.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/product-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Product product = productDAO.getProductById(id);
        
        if (product == null) {
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }
        
        request.setAttribute("product", product);
        request.setAttribute("isEdit", true);
        request.getRequestDispatcher("/admin/product-form.jsp").forward(request, response);
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Product product = new Product();
        product.setName(request.getParameter("name"));
        product.setDescription(request.getParameter("description"));
        product.setPrice(new BigDecimal(request.getParameter("price")));
        product.setStock(Integer.parseInt(request.getParameter("stock")));
        product.setCategory(request.getParameter("category"));
        product.setImageUrl(request.getParameter("imageUrl"));
        
        if (productDAO.createProduct(product)) {
            response.sendRedirect(request.getContextPath() + "/admin/products?success=added");
        } else {
            request.setAttribute("error", "Failed to add product");
            request.getRequestDispatcher("/admin/product-form.jsp").forward(request, response);
        }
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Product product = new Product();
        product.setId(Integer.parseInt(request.getParameter("id")));
        product.setName(request.getParameter("name"));
        product.setDescription(request.getParameter("description"));
        product.setPrice(new BigDecimal(request.getParameter("price")));
        product.setStock(Integer.parseInt(request.getParameter("stock")));
        product.setCategory(request.getParameter("category"));
        product.setImageUrl(request.getParameter("imageUrl"));
        
        if (productDAO.updateProduct(product)) {
            response.sendRedirect(request.getContextPath() + "/admin/products?success=updated");
        } else {
            request.setAttribute("error", "Failed to update product");
            request.setAttribute("product", product);
            request.setAttribute("isEdit", true);
            request.getRequestDispatcher("/admin/product-form.jsp").forward(request, response);
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        if (productDAO.deleteProduct(id)) {
            response.sendRedirect(request.getContextPath() + "/admin/products?success=deleted");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/products?error=delete_failed");
        }
    }
}
