# Database Setup Guide

## Prerequisites
- XAMPP installed and running
- MySQL service started in XAMPP Control Panel

## Step 1: Create Database

1. Open **phpMyAdmin** (usually at `http://localhost/phpmyadmin`)
2. Click on **"New"** in the left sidebar
3. Enter database name: **`onlineshopping`**
4. Select collation: **`utf8mb4_unicode_ci`**
5. Click **"Create"**

## Step 2: Import SQL Script

### Option A: Using phpMyAdmin
1. Select the **`onlineshopping`** database from the left sidebar
2. Click on the **"Import"** tab
3. Click **"Choose File"** and select `database_setup.sql`
4. Click **"Go"** at the bottom

### Option B: Using MySQL Command Line
1. Open Command Prompt or Terminal
2. Navigate to XAMPP MySQL bin directory:
   ```bash
   cd C:\xampp\mysql\bin
   ```
3. Run the SQL script:
   ```bash
   mysql -u root -p onlineshopping < "C:\path\to\database_setup.sql"
   ```
   (If no password is set, just press Enter when prompted)

### Option C: Copy and Paste SQL
1. Open **phpMyAdmin**
2. Select **`onlineshopping`** database
3. Click on **"SQL"** tab
4. Copy the entire content from `database_setup.sql`
5. Paste it into the SQL text area
6. Click **"Go"**

## Step 3: Verify Tables

After importing, you should see these tables:
- ✅ `users`
- ✅ `products`
- ✅ `orders`
- ✅ `order_items`

## Step 4: Configure Database Connection

The database connection is already configured in `DBConnection.java`:
- **Database**: `onlineshopping`
- **Host**: `localhost:3306`
- **Username**: `root`
- **Password**: (empty - default XAMPP)

If your MySQL has a password, update it in:
```
src/main/java/com/mycompany/onlineshoppingcart/util/DBConnection.java
```

Change line 10:
```java
private static final String DB_PASSWORD = "your_password_here";
```

## Step 5: Test Connection

1. Rebuild your project:
   ```bash
   mvn clean compile
   ```

2. Deploy and restart Tomcat

3. Try registering a new user or adding a product through admin panel

## Database Schema

### Users Table
- Stores user accounts (customers and admins)
- Fields: id, username, email, password, first_name, last_name, address, phone, role

### Products Table
- Stores product catalog
- Fields: id, name, description, price, stock, category, image_url

### Orders Table
- Stores customer orders
- Fields: id, user_id, order_date, status, total_amount, shipping_address

### Order Items Table
- Stores individual items in each order
- Fields: id, order_id, product_id, product_name, price, quantity, subtotal

## Troubleshooting

### Error: "Access denied for user 'root'@'localhost'"
- Check if MySQL password is set in XAMPP
- Update `DB_PASSWORD` in `DBConnection.java`

### Error: "Unknown database 'onlineshopping'"
- Make sure you created the database first
- Verify database name is exactly `onlineshopping`

### Error: "Table doesn't exist"
- Run the SQL script again
- Check if all tables were created successfully

### Connection Timeout
- Make sure MySQL service is running in XAMPP Control Panel
- Check if port 3306 is not blocked by firewall
