-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 03, 2023 at 11:53 AM
-- Server version: 8.0.33-0ubuntu0.20.04.2
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `example_data`
--

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `total` decimal(8,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `subtotal` decimal(8,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`id`, `user_id`, `total`, `created_at`, `updated_at`, `subtotal`) VALUES
(4, 5, '0.00', '2023-07-02 23:58:06', '2023-07-03 00:39:40', '10000.00');

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `id` bigint UNSIGNED NOT NULL,
  `cart_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint UNSIGNED NOT NULL,
  `category_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_specification` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `category_name`, `category_type`, `slug`, `category_image`, `category_content`, `category_specification`, `created_at`, `updated_at`, `user_id`) VALUES
(1, 'chair', 'furniture', 'table-furniture', 'http://127.0.0.1:8000/storage/categories/1687859496_product-2.png', 'zbc', 'abc', '2023-06-27 01:53:19', '2023-06-27 04:44:26', 2),
(2, 'Table', 'furniture', 'table-furniture', 'http://127.0.0.1:8000/storage/categories/1687851416_image 8.png', 'zbc', 'bcd', '2023-06-27 02:06:56', '2023-06-27 02:06:56', 2);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2023_06_25_115216_create_products_table', 2),
(6, '2023_06_25_124914_add_product_images_to_products_table', 3),
(7, '2023_06_27_051203_create_roles_table', 4),
(8, '2023_06_27_052043_add_role_id_to_users_table', 5),
(9, '2023_06_25_142334_create_categories_table', 6),
(10, '2023_06_25_142840_create_subcategories_table', 6),
(11, '2023_06_27_065929_add_user_id_to_categories_table', 7),
(12, '2023_06_27_065936_add_user_id_to_subcategories_table', 7),
(13, '2023_06_27_070139_add_user_id_to_categories_table', 8),
(14, '2023_06_27_070205_add_user_id_to_subcategories_table', 8),
(15, '2023_06_27_122620_create_sub_categories_table', 9),
(16, '2023_06_27_122938_add_user_id_to_sub_categories_table', 10),
(17, '2023_06_28_054030_add_category_id_to_products_table', 11),
(18, '2023_06_28_054053_add_sub_category_id_to_products_table', 11),
(19, '2023_06_28_054449_add_category_id_to_products_table', 12),
(20, '2023_06_28_054539_add_sub_category_id_to_products_table', 12),
(21, '2023_06_28_054830_add_category_id_to_products_table', 13),
(22, '2023_06_28_054835_add_sub_category_id_to_products_table', 14),
(23, '2023_06_28_092927_create_carts_table', 15),
(24, '2023_06_28_110712_create_cart_items_table', 16),
(25, '2023_06_28_121717_add_price_to_cart_items', 17),
(26, '2023_06_28_123210_create_carts_table', 18),
(27, '2023_06_28_123216_create_cart_items_table', 18),
(28, '2023_06_30_053336_create_carts_table', 19),
(29, '2023_06_30_053643_create_cart_items_table', 19),
(30, '2023_06_30_055252_add_subtotal_to_carts', 20),
(31, '2023_06_30_075208_create_orders_table', 21),
(32, '2023_07_03_052148_add_status_to_orders_table', 22),
(33, '2023_07_03_053124_add_price_to_order_items__table', 23),
(34, '2023_07_03_054910_add_payment_status_to_orders__table', 24);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` decimal(8,2) NOT NULL DEFAULT '0.00',
  `payment_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`, `status`, `total`, `payment_status`) VALUES
(1, 5, '2023-06-30 03:53:24', '2023-06-30 03:53:24', '', '0.00', ''),
(2, 5, '2023-06-30 03:56:02', '2023-06-30 03:56:02', '', '0.00', ''),
(3, 5, '2023-07-02 23:59:58', '2023-07-02 23:59:58', 'pending', '5000.00', ''),
(4, 5, '2023-07-03 00:02:08', '2023-07-03 00:16:18', 'delivered', '5000.00', ''),
(5, 5, '2023-07-03 00:39:40', '2023-07-03 00:44:24', 'delivered', '10000.00', 'online_payment');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint UNSIGNED NOT NULL,
  `order_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `quantity` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `price` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `created_at`, `updated_at`, `price`) VALUES
(1, 2, 5, 1, '2023-06-30 03:56:02', '2023-06-30 03:56:02', '0.00'),
(2, 2, 4, 2, '2023-06-30 03:56:02', '2023-06-30 03:56:02', '0.00'),
(3, 4, 4, 1, '2023-07-03 00:02:08', '2023-07-03 00:02:08', '5000.00'),
(4, 5, 5, 2, '2023-07-03 00:39:40', '2023-07-03 00:39:40', '10000.00');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 4, 'authToken', 'b96ef89f8764cd53c1d35dd0ca01730e86a91f295c43eb711a697f58f289cc1d', '[\"*\"]', NULL, NULL, '2023-06-22 08:00:19', '2023-06-22 08:00:19'),
(2, 'App\\Models\\User', 4, 'authToken', '5ce7c3dd8bff6a5e74311bb928204e9825d2d88a5241fae003908c10eb563e70', '[\"*\"]', NULL, NULL, '2023-06-23 02:22:18', '2023-06-23 02:22:18'),
(3, 'App\\Models\\User', 5, 'authToken', '4f536c7e7313e15ea145c8c399629a0e5927128781b62e1d33dc5a9a802b8343', '[\"*\"]', '2023-06-23 04:12:23', NULL, '2023-06-23 03:45:27', '2023-06-23 04:12:23'),
(4, 'App\\Models\\User', 5, 'authToken', '046b797a193852e27f50cd000b691a4538a2e0f86122f4d7f982786f4483e9bf', '[\"*\"]', NULL, NULL, '2023-06-23 04:14:07', '2023-06-23 04:14:07'),
(5, 'App\\Models\\User', 5, 'authToken', 'd960f6e7e738a916598435be5e3c2c2a4d5e18c80aada98d2b623c18a73e0a56', '[\"*\"]', '2023-07-03 00:47:12', NULL, '2023-06-26 23:36:39', '2023-07-03 00:47:12');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_category` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_category` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_sku` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stock` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `long_description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_specification` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_image_1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_image_2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_image_3` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_image_4` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_image_5` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `category_id` int NOT NULL,
  `sub_category_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `user_id`, `product_name`, `product_category`, `sub_category`, `product_sku`, `price`, `slug`, `stock`, `long_description`, `short_description`, `product_specification`, `product_image_1`, `product_image_2`, `product_image_3`, `product_image_4`, `product_image_5`, `created_at`, `updated_at`, `category_id`, `sub_category_id`) VALUES
(4, 2, 'Wooden chair', 'chair', 'chair', '/wooden/chair', 5000, 'wooden-table', '10', 'abc', 'bcd', 'abcd', NULL, NULL, NULL, NULL, NULL, '2023-06-28 00:27:40', '2023-06-28 01:03:01', 2, 1),
(5, 2, 'Wooden table', 'chair', 'chair', '/wooden/table', 5000, 'wooden-table', '10', 'abc', 'bcd', 'abcd', 'http://127.0.0.1:8000/storage/products/1687931929_product-2.png', NULL, NULL, NULL, NULL, '2023-06-28 00:28:49', '2023-06-28 00:28:49', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `role`, `created_at`, `updated_at`) VALUES
(1, 'admin', '2023-06-27 05:15:53', '2023-06-27 05:15:53'),
(2, 'vendor', '2023-06-27 05:15:53', '2023-06-27 05:15:53'),
(3, 'customer', '2023-06-27 05:15:53', '2023-06-27 05:15:53');

-- --------------------------------------------------------

--
-- Table structure for table `sub_categories`
--

CREATE TABLE `sub_categories` (
  `id` bigint UNSIGNED NOT NULL,
  `category_id` bigint UNSIGNED NOT NULL,
  `sub_category_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_category_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_category_image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_category_content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_category_specification` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sub_categories`
--

INSERT INTO `sub_categories` (`id`, `category_id`, `sub_category_name`, `sub_category_type`, `slug`, `sub_category_image`, `sub_category_content`, `sub_category_specification`, `created_at`, `updated_at`, `user_id`) VALUES
(1, 1, 'chair', 'furniture', 'table-furniture', 'http://127.0.0.1:8000/storage/subcategories/1687869437_image (1).png', 'zbc', 'abc', '2023-06-27 07:07:17', '2023-06-27 07:27:04', 2),
(2, 1, 'chair', 'abc', 'metal-chair', 'http://127.0.0.1:8000/storage/subcategories/1687869708_image (1).png', 'abc', 'bcd', '2023-06-27 07:11:48', '2023-06-27 07:11:48', 2);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `role_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `role_id`) VALUES
(1, 'Mihir Gohil', 'mihir.itaims@gmail.com', NULL, '$2y$10$huc5c9SR4D89NMIIMPQQ6uZewasuQ.ni3RieCZuzeRExftL8HsDgW', NULL, '2023-06-22 06:36:15', '2023-06-22 06:36:15', 1),
(3, 'Mihir Gohil', 'mihir@gmail.com', NULL, '$2y$10$1N2l.XMC.cTyELjlFwPCjOCTQ/Z00bAwYAggahv85cQ5Bb9t617pC', NULL, '2023-06-22 06:39:46', '2023-06-22 06:39:46', 2),
(4, 'mihirmg', 'mihirgohil@gmail.com', NULL, '$2y$10$nZmxTZgo2BUdYbx9q.h52.5UEsQms3XB23ST9jmz.XwNaReuNU.2m', NULL, '2023-06-22 07:12:30', '2023-06-22 07:12:30', 2),
(5, 'Nikhil', 'nikhil.itaims@gmail.com', NULL, '$2y$10$RJ/Wpbqt20BfhXqaqjlQ6uidXs/8cH378Tfrt3qkHj.2o91KXEZxe', NULL, '2023-06-23 00:47:38', '2023-06-23 04:12:23', 1),
(6, 'Divyang', 'divyang.itaims@gmail.com', NULL, '$2y$10$cyPlmLyxpgeSHRPizE8IC./KYJQUYdK/cLzOkjEWlZYwBOTqCqrAS', NULL, '2023-06-23 02:25:04', '2023-06-23 02:25:04', 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `carts_user_id_foreign` (`user_id`);

--
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cart_items_cart_id_foreign` (`cart_id`),
  ADD KEY `cart_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_user_id_foreign` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_items_order_id_foreign` (`order_id`),
  ADD KEY `order_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sub_categories_category_id_foreign` (`category_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sub_categories`
--
ALTER TABLE `sub_categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `cart_items_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD CONSTRAINT `sub_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
