-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 12, 2026 at 08:51 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `onlineshopping`
--

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` varchar(20) DEFAULT 'pending',
  `total_amount` decimal(10,2) NOT NULL,
  `shipping_address` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `order_date`, `status`, `total_amount`, `shipping_address`) VALUES
(5, 3, '2026-01-12 18:49:02', 'cancelled', 330.44, 'User User\nSri Lanka\nHikkaduwa, 80240\nPhone: 0759307059'),
(6, 4, '2026-01-12 18:57:37', 'cancelled', 1339.17, 'user new new\nSri Lankan\nHikkaduwa, 80240\nPhone: 0759307059');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `product_name`, `price`, `quantity`, `subtotal`) VALUES
(11, 5, 2, 'Elegant Summer Dress', 79.99, 1, 79.99),
(12, 5, 4, 'Leather Handbag', 129.99, 1, 129.99),
(13, 5, 3, 'Kids Denim Jacket', 49.99, 1, 49.99),
(14, 5, 6, 'Floral Print Blouse', 45.99, 1, 45.99),
(15, 6, 2, 'Elegant Summer Dress', 79.99, 1, 79.99),
(16, 6, 9, 'new test', 1000.00, 1, 1000.00),
(17, 6, 4, 'Leather Handbag', 129.99, 1, 129.99),
(18, 6, 1, 'Classic White T-Shirt', 29.99, 1, 29.99);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `category` varchar(50) DEFAULT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `stock`, `category`, `image_url`, `created_at`, `updated_at`) VALUES
(1, 'Classic White T-Shirt', 'Comfortable cotton t-shirt perfect for everyday wear', 29.99, 50, 'men', 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=500', '2026-01-12 15:51:00', '2026-01-12 15:51:00'),
(2, 'Elegant Summer Dress', 'Beautiful floral dress for summer occasions', 79.99, 30, 'women', 'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=500', '2026-01-12 15:51:00', '2026-01-12 15:51:00'),
(3, 'Kids Denim Jacket', 'Stylish denim jacket for kids', 49.99, 25, 'kids', 'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=500', '2026-01-12 15:51:00', '2026-01-12 15:51:00'),
(4, 'Leather Handbag', 'Premium leather handbag with multiple compartments', 129.99, 15, 'accessories', 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500', '2026-01-12 15:51:00', '2026-01-12 15:51:00'),
(5, 'Slim Fit Jeans', 'Classic blue jeans with perfect fit', 59.99, 40, 'men', 'https://images.unsplash.com/photo-1542272604-787c3835535d?w=500', '2026-01-12 15:51:00', '2026-01-12 15:51:00'),
(6, 'Floral Print Blouse', 'Elegant blouse with beautiful floral pattern', 45.99, 35, 'women', 'https://images.unsplash.com/photo-1594633312681-425c7b97ccd1?w=500', '2026-01-12 15:51:00', '2026-01-12 15:51:00'),
(7, 'Test', 'New', 100.00, 20, 'men', 'https://www.voguecollege.com/wp-content/uploads/2025/06/vcf-es_blog_article_tendencias_1920x1280px.jpg', '2026-01-12 16:01:35', '2026-01-12 16:26:22'),
(8, 'Testing Item', 'Testing Kids', 1200.00, 50, 'kids', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4sc72INHlKb5jlvFC8KTI67PE9Tmd8O8WDw&s', '2026-01-12 18:43:14', '2026-01-12 18:43:14'),
(9, 'new test', 'Testing', 1000.00, 10, 'women', 'https://mimosaforever.com/cdn/shop/files/096A9724.jpg?v=1766570908&width=400', '2026-01-12 18:51:18', '2026-01-12 18:51:18'),
(10, 'New D Brand', 'New Testing', 120.00, 10, 'women', 'https://mimosaforever.com/cdn/shop/files/image00061_0f00304f-eaf1-4be5-a55c-94cd00d27259.jpg?v=1766468571&width=400', '2026-01-12 18:59:09', '2026-01-12 18:59:09');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `role` varchar(20) DEFAULT 'customer',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `address`, `phone`, `role`, `created_at`) VALUES
(3, 'User', 'user@gmail.com', 'user1234', 'User', 'User', 'Sri Lanka', '0759307059', 'customer', '2026-01-12 18:48:02'),
(4, 'User1', 'new@gmail.com', 'user1234', 'user new', 'new', 'Sri Lankan', '0759307059', 'customer', '2026-01-12 18:56:14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_order_date` (`order_date`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_order_id` (`order_id`),
  ADD KEY `idx_product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_category` (`category`),
  ADD KEY `idx_name` (`name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_username` (`username`),
  ADD KEY `idx_email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
