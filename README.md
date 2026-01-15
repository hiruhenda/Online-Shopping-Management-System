# Online Shopping Cart

A Java web application built with JSP (JavaServer Pages) and Servlets for an e-commerce shopping cart system.

## Project Structure

```
OnlineShoppingCart
│
├── src
│   └── main
│       ├── java
│       │   └── com
│       │       └── mycompany
│       │           └── onlineshoppingcart
│       │               │
│       │               ├── controller        (SERVLETS)
│       │               │   ├── LoginServlet.java
│       │               │   ├── LogoutServlet.java
│       │               │   ├── ProductServlet.java
│       │               │   ├── CartServlet.java
│       │               │   ├── CheckoutServlet.java
│       │               │   └── OrderServlet.java
│       │               │
│       │               ├── model             (POJO / OOP CLASSES)
│       │               │   ├── User.java
│       │               │   ├── Product.java
│       │               │   ├── Cart.java
│       │               │   ├── CartItem.java
│       │               │   ├── Order.java
│       │               │   └── OrderItem.java
│       │               │
│       │               ├── dao               (DATABASE ACCESS)
│       │               │   ├── UserDAO.java
│       │               │   ├── ProductDAO.java
│       │               │   └── OrderDAO.java
│       │               │
│       │               └── util              (HELPER CLASSES)
│       │                   └── DBConnection.java
│       │
│       └── webapp
│           ├── css
│           │   └── style.css
│           │
│           ├── login.jsp
│           ├── register.jsp
│           ├── products.jsp
│           ├── product-details.jsp
│           ├── cart.jsp
│           ├── checkout.jsp
│           ├── orders.jsp
│           ├── admin-products.jsp
│           ├── admin-reports.jsp
│           └── index.jsp
│
├── pom.xml
└── README.md
```

## Features

- **User Management**: Registration and login functionality
- **Product Catalog**: Browse and view product details
- **Shopping Cart**: Add, update, and remove items from cart
- **Order Management**: Place orders and view order history
- **Admin Panel**: Product management and reports (for admin users)

## Technologies Used

- Java 8
- JSP (JavaServer Pages)
- Java Servlets
- MySQL Database
- Maven
- Jakarta EE 8

## Prerequisites

- JDK 8 or higher
- Maven 3.6+
- MySQL 5.7+ or MySQL 8.0+
- Application Server (Tomcat 9+, GlassFish, etc.)

## Database Setup

1. Create a MySQL database:
```sql
CREATE DATABASE onlineshoppingcart;
```

2. Create the required tables:
```sql
-- Users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    address TEXT,
    phone VARCHAR(20),
    role VARCHAR(20) DEFAULT 'customer'
);

-- Products table
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    category VARCHAR(50),
    image_url VARCHAR(255)
);

-- Orders table
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'pending',
    total_amount DECIMAL(10, 2) NOT NULL,
    shipping_address TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Order Items table
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);
```

## Configuration

1. Update database connection settings in `DBConnection.java`:
   - Update `DB_URL` with your database URL
   - Update `DB_USER` with your database username
   - Update `DB_PASSWORD` with your database password

2. Add MySQL JDBC driver dependency to `pom.xml` (if not already present):
```xml
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>8.0.33</version>
</dependency>
```

## Building and Running

1. Build the project:
```bash
mvn clean package
```

2. Deploy the WAR file to your application server

3. Access the application:
   - Home: `http://localhost:8080/OnlineShoppingCart/`
   - Login: `http://localhost:8080/OnlineShoppingCart/login.jsp`
   - Products: `http://localhost:8080/OnlineShoppingCart/products`

## Development Notes

- The application uses session management for user authentication
- Cart is stored in the session
- Password encryption should be implemented for production use
- Input validation and error handling should be enhanced
- Consider implementing proper security measures (CSRF protection, SQL injection prevention, etc.)

## License

This project is for educational purposes.
