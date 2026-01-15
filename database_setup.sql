-- =====================================================
-- Online Shopping Cart Database Setup Script
-- Database: onlineshopping
-- For MySQL (XAMPP)
-- =====================================================

-- Create database (if not exists)
CREATE DATABASE IF NOT EXISTS onlineshopping;
USE onlineshopping;

-- =====================================================
-- 1. USERS TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    address TEXT,
    phone VARCHAR(20),
    role VARCHAR(20) DEFAULT 'customer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_username (username),
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 2. PRODUCTS TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    category VARCHAR(50),
    image_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_category (category),
    INDEX idx_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 3. ORDERS TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'pending',
    total_amount DECIMAL(10, 2) NOT NULL,
    shipping_address TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_order_date (order_date),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 4. ORDER_ITEMS TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE RESTRICT,
    INDEX idx_order_id (order_id),
    INDEX idx_product_id (product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SAMPLE DATA (Optional - for testing)
-- =====================================================

-- Insert sample products
INSERT INTO products (name, description, price, stock, category, image_url) VALUES
('Classic White T-Shirt', 'Comfortable cotton t-shirt perfect for everyday wear', 29.99, 50, 'men', 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=500'),
('Elegant Summer Dress', 'Beautiful floral dress for summer occasions', 79.99, 30, 'women', 'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=500'),
('Kids Denim Jacket', 'Stylish denim jacket for kids', 49.99, 25, 'kids', 'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=500'),
('Leather Handbag', 'Premium leather handbag with multiple compartments', 129.99, 15, 'accessories', 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500'),
('Slim Fit Jeans', 'Classic blue jeans with perfect fit', 59.99, 40, 'men', 'https://images.unsplash.com/photo-1542272604-787c3835535d?w=500'),
('Floral Print Blouse', 'Elegant blouse with beautiful floral pattern', 45.99, 35, 'women', 'https://images.unsplash.com/photo-1594633312681-425c7b97ccd1?w=500');

-- =====================================================
-- END OF SCRIPT
-- =====================================================
