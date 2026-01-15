package com.mycompany.onlineshoppingcart.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.mycompany.onlineshoppingcart.dao.ProductDAO;
import com.mycompany.onlineshoppingcart.model.Product;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "list":
                listProducts(request, response);
                break;
            case "details":
                showProductDetails(request, response);
                break;
            default:
                listProducts(request, response);
                break;
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String category = request.getParameter("category");
        List<Product> products;
        List<Product> allProducts; // For counting
        
        // Get all products for counting
        allProducts = productDAO.getAllProducts();
        
        // Filter by category if specified
        if (category != null && !category.isEmpty() && !"all".equals(category)) {
            products = productDAO.getProductsByCategory(category);
        } else {
            products = allProducts;
        }
        
        // Get all categories for filter
        List<String> categories = productDAO.getAllCategories();
        
        request.setAttribute("products", products);
        request.setAttribute("allProducts", allProducts); // For accurate counting
        request.setAttribute("categories", categories);
        request.setAttribute("selectedCategory", category != null ? category : "all");
        request.getRequestDispatcher("/products.jsp").forward(request, response);
    }

    private void showProductDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productId = request.getParameter("id");
        Product product = productDAO.getProductById(Integer.parseInt(productId));
        request.setAttribute("product", product);
        request.getRequestDispatcher("/product-details.jsp").forward(request, response);
    }
}
