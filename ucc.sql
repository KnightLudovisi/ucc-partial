-- phpMyAdmin SQL Dump
-- version 5.2.3deb1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 26, 2026 at 08:07 PM
-- Server version: 11.8.6-MariaDB-5ubuntu0.1 from Ubuntu
-- PHP Version: 8.5.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ucc_cms`
--

-- --------------------------------------------------------

--
-- Table structure for table `about`
--

CREATE TABLE `about` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` longtext NOT NULL,
  `featured_image` varchar(255) DEFAULT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'inactive',
  `author_id` int(10) UNSIGNED NOT NULL,
  `editor_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `audit_trail`
--

CREATE TABLE `audit_trail` (
  `id` int(10) UNSIGNED NOT NULL,
  `action` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  `entity_type` varchar(50) NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audit_trail`
--

INSERT INTO `audit_trail` (`id`, `action`, `description`, `entity_type`, `entity_id`, `user_id`, `created_at`) VALUES
(1, 'CREATE', 'Created a new post titled Title', 'University Post', 6, 1, '2026-10-24 22:37:27'),
(2, 'CREATE', 'Created a new post titled: Title', 'University Post', 7, 1, '2026-10-24 23:25:57'),
(3, 'CREATE', 'Created a new post titled: Title', 'University Post', 8, 1, '2026-10-24 23:26:20'),
(4, 'CREATE', 'Created a new post titled: Title', 'University Post - University News', 9, 1, '2026-10-24 23:42:07'),
(5, 'UPDATE', 'Updated the post titled: Title', 'University Post - University News', 1, 1, '2026-10-24 23:43:29'),
(6, 'UPDATE', 'Updated the post titled: Title', 'University Post - University News', 4, 1, '2026-10-24 23:49:16'),
(7, 'UPDATE', 'Updated the post titled: Title', 'University Post - University News', 4, 1, '2026-10-24 23:49:38'),
(8, 'UPDATE', 'Updated the post titled: Title', 'University Post - University News', 4, 1, '2026-10-24 23:50:19'),
(9, 'UPDATE', 'Updated the post titled: Title', 'University Post - University News', 4, 1, '2026-10-24 23:51:00'),
(10, 'UPDATE', 'Updated the post titled: Title', 'University Post - University News', 4, 1, '2026-10-24 23:51:26'),
(11, 'UPDATE', 'Updated the post titled: Title', 'University Post - University News', 4, 1, '2026-10-25 00:02:29'),
(12, 'UPDATE', 'Updated the post titled: Title', 'University Post - University News', 4, 1, '2026-10-25 00:02:44'),
(13, 'UPDATE', 'Updated the post titled: Title', 'University Post - University News', 4, 1, '2026-10-25 00:02:50'),
(14, 'UPDATE', 'Updated the post titled: Title', 'University Post - University News', 4, 1, '2026-10-25 00:02:59'),
(15, 'UPDATE', 'Updated the post titled: Title 2', 'University Post - University News', 4, 1, '2026-10-25 00:03:22'),
(16, 'UPDATE', 'Updated the post titled: Title 2', 'University Post - University News', 4, 1, '2026-10-25 08:21:18'),
(17, 'UPDATE', 'Updated the post titled: Title 2', 'University Post - University News', 4, 1, '2026-10-25 10:40:06'),
(18, 'UPDATE', 'Updated the post titled: Title 2', 'University Post - University News', 4, 1, '2026-10-25 10:40:38'),
(19, 'UPDATE', 'Updated the post titled: Title 2', 'University Post - University News', 4, 1, '2026-10-25 10:44:21'),
(20, 'UPDATE', 'Updated the post titled: Title 2', 'University Post - University News', 4, 1, '2026-10-25 10:45:53'),
(21, 'UPDATE', 'Updated the post titled: Title 2', 'University Post - University News', 4, 1, '2026-10-25 10:46:06'),
(22, 'UPDATE', 'Updated the post titled: Title 2', 'University Post - University News', 4, 1, '2026-10-25 10:48:18'),
(23, 'UPDATE', 'Updated the post titled: Title 2', 'University Post - University News', 8, 1, '2026-10-25 10:48:42'),
(24, 'UPDATE', 'Updated the post titled: Title 2', 'University Post - University News', 8, 1, '2026-10-25 10:49:29'),
(25, 'UPDATE', 'Updated the post titled: Title 2', 'University Post - University News', 8, 1, '2026-10-25 10:49:45'),
(26, 'UPDATE', 'Updated the post titled: Title 2', 'University Post - University News', 8, 1, '2026-10-25 11:35:20'),
(27, 'ARCHIVE', 'Archived the post titled: Title 2', 'University Post - University News', 4, 1, '2026-10-25 14:47:42'),
(28, 'ARCHIVE', 'Archived the post titled: Title', 'University Post - University News', 6, 1, '2026-10-25 14:49:09'),
(29, 'ARCHIVE', 'Archived the post titled: Title', 'University Post - University News', 7, 1, '2026-10-25 15:32:54'),
(30, 'UNARCHIVE', 'Unarchived the post titled: Title', 'University Post - University News', 7, 1, '2026-10-25 15:51:06'),
(31, 'UNARCHIVE', 'Unarchived the post titled: Title', 'University Post - University News', 6, 1, '2026-10-25 15:51:34'),
(32, 'ARCHIVE', 'Archived the post titled: Title', 'University Post - University News', 6, 1, '2026-10-25 15:52:08'),
(33, 'ARCHIVE', 'Archived the post titled: Title', 'University Post - University News', 7, 1, '2026-10-25 16:10:07'),
(34, 'UNARCHIVE', 'Unarchived the post titled: Title', 'University Post - University News', 7, 1, '2026-10-25 16:11:19'),
(35, 'UNARCHIVE', 'Unarchived the post titled: Title', 'University Post - University News', 6, 1, '2026-10-25 16:31:35'),
(36, 'DELETE', 'Deleted the post titled: Title', 'University Post - University News', 6, 1, '2026-10-25 16:32:04'),
(37, 'DELETE', 'Deleted the post titled: Title', 'University Post - University News', 7, 1, '2026-10-25 16:37:36'),
(38, 'CREATE', 'Created a new post titled: Title 3', 'University Post - Student Life', 10, 1, '2026-10-25 18:13:59'),
(39, 'UPDATE', 'Updated the post titled: Title 3', 'University Post - Student Life', 10, 1, '2026-10-25 18:15:30'),
(40, 'UPDATE', 'Updated the post titled: Title 3', 'University Post - Student Life', 10, 1, '2026-10-25 18:15:43'),
(41, 'UPDATE', 'Updated the post titled: Title 3', 'University Post - Student Life', 10, 1, '2026-10-25 18:15:54'),
(42, 'UPDATE', 'Updated the post titled: Title 3', 'University Post - Student Life', 10, 1, '2026-10-25 18:16:20'),
(43, 'UNARCHIVE', 'Unarchived the post titled: Title 2', 'University Post - University News', 4, 1, '2026-10-25 18:19:35'),
(44, 'DELETE', 'Deleted the post titled: Title 2', 'University Post - University News', 4, 1, '2026-10-25 18:19:52'),
(45, 'ARCHIVE', 'Archived the post titled: Title 3', 'University Post - Student Life', 10, 1, '2026-10-25 18:27:42'),
(46, 'DELETE', 'Deleted the post titled: Title 3', 'University Post - Student Life', 10, 1, '2026-10-25 18:28:02'),
(47, 'ARCHIVE', 'Archived the post titled: Title', 'University Post - University News', 9, 1, '2026-10-25 18:37:56'),
(48, 'UNARCHIVE', 'Unarchived the post titled: Title', 'University Post - University News', 9, 1, '2026-10-25 18:39:15'),
(49, 'ARCHIVE', 'Archived the post titled: Title', 'University Post - University News', 9, 1, '2026-10-25 18:39:36'),
(50, 'DELETE', 'Deleted the post titled: Title', 'University Post - University News', 9, 1, '2026-10-25 18:43:36'),
(51, 'ARCHIVE', 'Archived the post titled: Title 2', 'University Post - University News', 8, 1, '2026-10-25 18:45:27'),
(52, 'UNARCHIVE', 'Unarchived the post titled: Title 2', 'University Post - University News', 8, 1, '2026-10-25 18:46:04'),
(53, 'ARCHIVE', 'Archived the post titled: Title 2', 'University Post - University News', 8, 1, '2026-10-25 18:47:15'),
(54, 'DELETE', 'Deleted the post titled: Title 2', 'University Post - University News', 8, 1, '2026-10-25 18:47:36'),
(55, 'CREATE', 'Created a new post titled: Title 5', 'University Post - Community and Extension Services', 11, 1, '2026-10-25 20:32:29'),
(56, 'CREATE', 'Created a new post titled: Title 5', 'University Post - Community and Extension Services', 12, 1, '2026-10-25 20:32:47'),
(57, 'ARCHIVE', 'Archived the post titled: Title 5', 'University Post - Community and Extension Services', 11, 1, '2026-10-25 20:48:23'),
(58, 'ARCHIVE', 'Archived the post titled: Title 5', 'University Post - Community and Extension Services', 12, 1, '2026-10-25 20:48:40');

-- --------------------------------------------------------

--
-- Table structure for table `calendar`
--

CREATE TABLE `calendar` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(150) NOT NULL,
  `description` longtext NOT NULL,
  `featured_image` varchar(255) DEFAULT NULL,
  `views` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `status` enum('draft','published') NOT NULL DEFAULT 'draft',
  `author_id` int(10) UNSIGNED NOT NULL,
  `editor_id` int(10) UNSIGNED DEFAULT NULL,
  `published_at` datetime NOT NULL,
  `starts_at` datetime NOT NULL,
  `ends_at` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `campuses`
--

CREATE TABLE `campuses` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `address` varchar(255) NOT NULL,
  `email` varchar(200) DEFAULT NULL,
  `contacts` text DEFAULT NULL,
  `google_maps_url` varchar(2048) NOT NULL,
  `featured_image` varchar(255) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'inactive',
  `author_id` int(10) UNSIGNED NOT NULL,
  `editor_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `class` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `class`, `created_at`, `active`) VALUES
(1, 'University News', 'university-posts', '2026-10-22 01:25:06', 1),
(2, 'Student Life', 'university-posts', '2026-10-22 01:25:06', 1),
(3, 'Community and Extension Services', 'university-posts', '2026-10-22 01:25:06', 1),
(4, 'Admission', 'university-posts', '2026-10-22 01:25:06', 1),
(5, 'Alumni', 'university-posts', '2026-10-22 01:25:06', 1),
(6, 'Careers', 'university-posts', '2026-10-22 01:25:06', 1),
(7, 'Unit News', 'unit-posts', '2026-10-22 01:25:06', 1),
(8, 'Program News', 'program-posts', '2026-10-22 01:25:06', 1),
(9, 'About UCC', 'about', '2026-10-22 01:25:06', 1),
(10, 'History', 'about', '2026-10-22 01:25:06', 1),
(11, 'New UCC', 'about', '2026-10-22 01:25:06', 1),
(12, 'Opportunities', 'about', '2026-10-22 01:25:06', 1);

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `email` varchar(200) NOT NULL,
  `phone_number` varchar(30) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'inactive',
  `author_id` int(10) UNSIGNED NOT NULL,
  `editor_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `eservices`
--

CREATE TABLE `eservices` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` longtext NOT NULL,
  `url` varchar(2048) NOT NULL,
  `featured_image` varchar(255) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'inactive',
  `author_id` int(10) UNSIGNED NOT NULL,
  `editor_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `officials`
--

CREATE TABLE `officials` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `position` varchar(150) NOT NULL,
  `biography` longtext DEFAULT NULL,
  `featured_image` varchar(255) DEFAULT NULL,
  `order_number` int(10) UNSIGNED NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'inactive',
  `author_id` int(10) UNSIGNED NOT NULL,
  `editor_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(150) NOT NULL,
  `excerpt` text NOT NULL,
  `content` longtext NOT NULL,
  `featured_image` varchar(255) DEFAULT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `views` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `status` enum('draft','published') NOT NULL DEFAULT 'draft',
  `author_id` int(10) UNSIGNED NOT NULL,
  `editor_id` int(10) UNSIGNED DEFAULT NULL,
  `published_at` datetime NOT NULL,
  `expires_at` datetime NOT NULL,
  `archived_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `title`, `excerpt`, `content`, `featured_image`, `category_id`, `views`, `status`, `author_id`, `editor_id`, `published_at`, `expires_at`, `archived_at`, `created_at`, `updated_at`, `active`) VALUES
(4, 'Title 2', 'Excerpt 2', 'Content 2', NULL, 1, 0, 'draft', 1, 1, '2026-10-25 00:00:00', '2026-10-25 00:00:00', NULL, '2026-10-24 22:35:59', '2026-10-25 18:19:52', 0),
(6, 'Title', 'Excerpt', 'Content', NULL, 1, 0, 'draft', 1, 1, '2026-10-25 00:00:00', '2026-10-25 00:00:00', NULL, '2026-10-24 22:37:27', '2026-10-25 16:32:04', 0),
(7, 'Title', 'Excerpt', 'Content', NULL, 1, 0, 'draft', 1, 1, '2026-10-25 00:00:00', '2026-10-25 00:00:00', NULL, '2026-10-24 23:25:57', '2026-10-25 16:37:36', 0),
(8, 'Title 2', 'Excerpt 2', 'Content 2', 'bf6093f4da380c06b20a994a548466fb.webp', 1, 0, 'draft', 1, 1, '2026-10-25 00:00:00', '2026-10-25 00:00:00', '2026-10-25 18:47:15', '2026-10-24 23:26:20', '2026-10-25 18:47:36', 0),
(9, 'Title', 'Excerpt', 'Content', NULL, 1, 0, 'draft', 1, 1, '2026-10-25 00:00:00', '2026-10-25 00:00:00', '2026-10-25 18:39:36', '2026-10-24 23:42:07', '2026-10-25 18:43:36', 0),
(10, 'Title 3', 'Excerpt 3', 'Content 3', '1ee05f593fde0b49f99d07c7c38038db.webp', 2, 0, 'published', 1, 1, '2026-10-26 00:00:00', '2026-10-26 00:00:00', '2026-10-25 18:27:42', '2026-10-25 18:13:59', '2026-10-25 18:28:02', 0),
(11, 'Title 5', 'Excerpt 5', 'Content 5', NULL, 3, 0, 'published', 1, 1, '2026-10-26 00:00:00', '2026-10-26 00:00:00', '2026-10-25 20:48:23', '2026-10-25 20:32:29', '2026-10-25 20:48:23', 1),
(12, 'Title 5', 'Excerpt 5', 'Content 5', '61a067af9ff6c181e4f7e05ed21dae07.webp', 3, 0, 'published', 1, 1, '2026-10-26 00:00:00', '2026-10-26 00:00:00', '2026-10-25 20:48:40', '2026-10-25 20:32:47', '2026-10-25 20:48:40', 1);

-- --------------------------------------------------------

--
-- Table structure for table `post_views`
--

CREATE TABLE `post_views` (
  `post_id` int(10) UNSIGNED NOT NULL,
  `visitor_id` char(32) NOT NULL,
  `viewed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `programs`
--

CREATE TABLE `programs` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `vision` longtext NOT NULL,
  `mission` longtext NOT NULL,
  `unit_id` int(10) UNSIGNED NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'inactive',
  `author_id` int(10) UNSIGNED NOT NULL,
  `editor_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `program_posts`
--

CREATE TABLE `program_posts` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(150) NOT NULL,
  `excerpt` text NOT NULL,
  `content` longtext NOT NULL,
  `featured_image` varchar(255) DEFAULT NULL,
  `program_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `views` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `status` enum('draft','published') NOT NULL DEFAULT 'draft',
  `author_id` int(10) UNSIGNED NOT NULL,
  `editor_id` int(10) UNSIGNED DEFAULT NULL,
  `published_at` datetime NOT NULL,
  `expires_at` datetime NOT NULL,
  `archived_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `program_post_views`
--

CREATE TABLE `program_post_views` (
  `post_id` int(10) UNSIGNED NOT NULL,
  `visitor_id` char(32) NOT NULL,
  `viewed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `regents`
--

CREATE TABLE `regents` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `position` varchar(150) NOT NULL,
  `biography` longtext DEFAULT NULL,
  `featured_image` varchar(255) DEFAULT NULL,
  `order_number` int(10) UNSIGNED NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'inactive',
  `author_id` int(10) UNSIGNED NOT NULL,
  `editor_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `dean` varchar(150) NOT NULL,
  `dean_image` varchar(255) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'inactive',
  `author_id` int(10) UNSIGNED NOT NULL,
  `editor_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `unit_info`
--

CREATE TABLE `unit_info` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` longtext NOT NULL,
  `unit_id` int(10) UNSIGNED NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'inactive',
  `author_id` int(10) UNSIGNED NOT NULL,
  `editor_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `unit_posts`
--

CREATE TABLE `unit_posts` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(150) NOT NULL,
  `excerpt` text NOT NULL,
  `content` longtext NOT NULL,
  `featured_image` varchar(255) DEFAULT NULL,
  `unit_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `views` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `status` enum('draft','published') NOT NULL DEFAULT 'draft',
  `author_id` int(10) UNSIGNED NOT NULL,
  `editor_id` int(10) UNSIGNED DEFAULT NULL,
  `published_at` datetime NOT NULL,
  `expires_at` datetime NOT NULL,
  `archived_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `unit_post_views`
--

CREATE TABLE `unit_post_views` (
  `post_id` int(10) UNSIGNED NOT NULL,
  `visitor_id` char(32) NOT NULL,
  `viewed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('superadmin','dean','program head') NOT NULL,
  `unit_id` int(10) UNSIGNED DEFAULT NULL,
  `program_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `role`, `unit_id`, `program_id`, `created_at`, `active`) VALUES
(1, 'mky', 'doren.markjerald.bscs2024@gmail.com', '$2y$12$g6LV1KdcYK7Wc7IwdxoODuo4/VhkZyHeLSEN1M9xx7tIvSNh5Qnj.', 'superadmin', NULL, NULL, '2026-10-22 01:27:40', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `about`
--
ALTER TABLE `about`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_about_category` (`category_id`),
  ADD KEY `fk_about_author` (`author_id`),
  ADD KEY `fk_about_editor` (`editor_id`);

--
-- Indexes for table `audit_trail`
--
ALTER TABLE `audit_trail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_audit_logs_user` (`user_id`);

--
-- Indexes for table `calendar`
--
ALTER TABLE `calendar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_calendar_author` (`author_id`),
  ADD KEY `fk_calendar_editor` (`editor_id`);

--
-- Indexes for table `campuses`
--
ALTER TABLE `campuses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_campuses_author` (`author_id`),
  ADD KEY `fk_campuses_editor` (`editor_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_contacts_author` (`author_id`),
  ADD KEY `fk_contacts_editor` (`editor_id`);

--
-- Indexes for table `eservices`
--
ALTER TABLE `eservices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_eservices_author` (`author_id`),
  ADD KEY `fk_eservices_editor` (`editor_id`);

--
-- Indexes for table `officials`
--
ALTER TABLE `officials`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_officials_author` (`author_id`),
  ADD KEY `fk_officials_editor` (`editor_id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_posts_category` (`category_id`),
  ADD KEY `fk_posts_author` (`author_id`),
  ADD KEY `fk_posts_editor` (`editor_id`);

--
-- Indexes for table `post_views`
--
ALTER TABLE `post_views`
  ADD PRIMARY KEY (`post_id`,`visitor_id`);

--
-- Indexes for table `programs`
--
ALTER TABLE `programs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_programs_unit` (`unit_id`),
  ADD KEY `fk_programs_author` (`author_id`),
  ADD KEY `fk_programs_editor` (`editor_id`);

--
-- Indexes for table `program_posts`
--
ALTER TABLE `program_posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_program_posts_program` (`program_id`),
  ADD KEY `fk_program_posts_category` (`category_id`),
  ADD KEY `fk_program_posts_author` (`author_id`),
  ADD KEY `fk_program_posts_editor` (`editor_id`);

--
-- Indexes for table `program_post_views`
--
ALTER TABLE `program_post_views`
  ADD PRIMARY KEY (`post_id`,`visitor_id`);

--
-- Indexes for table `regents`
--
ALTER TABLE `regents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_regents_author` (`author_id`),
  ADD KEY `fk_regents_editor` (`editor_id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_units_author` (`author_id`),
  ADD KEY `fk_units_editor` (`editor_id`);

--
-- Indexes for table `unit_info`
--
ALTER TABLE `unit_info`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_unit_info_unit` (`unit_id`),
  ADD KEY `fk_unit_info_author` (`author_id`),
  ADD KEY `fk_unit_info_editor` (`editor_id`);

--
-- Indexes for table `unit_posts`
--
ALTER TABLE `unit_posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_unit_posts_unit` (`unit_id`),
  ADD KEY `fk_unit_posts_category` (`category_id`),
  ADD KEY `fk_unit_posts_author` (`author_id`),
  ADD KEY `fk_unit_posts_editor` (`editor_id`);

--
-- Indexes for table `unit_post_views`
--
ALTER TABLE `unit_post_views`
  ADD PRIMARY KEY (`post_id`,`visitor_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_users_username` (`username`),
  ADD UNIQUE KEY `uq_users_email` (`email`),
  ADD KEY `fk_users_unit` (`unit_id`),
  ADD KEY `fk_users_program` (`program_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `about`
--
ALTER TABLE `about`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `audit_trail`
--
ALTER TABLE `audit_trail`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `calendar`
--
ALTER TABLE `calendar`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `campuses`
--
ALTER TABLE `campuses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `eservices`
--
ALTER TABLE `eservices`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `officials`
--
ALTER TABLE `officials`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `programs`
--
ALTER TABLE `programs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `program_posts`
--
ALTER TABLE `program_posts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `regents`
--
ALTER TABLE `regents`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `unit_info`
--
ALTER TABLE `unit_info`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `unit_posts`
--
ALTER TABLE `unit_posts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `about`
--
ALTER TABLE `about`
  ADD CONSTRAINT `fk_about_author` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_about_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `fk_about_editor` FOREIGN KEY (`editor_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `audit_trail`
--
ALTER TABLE `audit_trail`
  ADD CONSTRAINT `fk_audit_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `calendar`
--
ALTER TABLE `calendar`
  ADD CONSTRAINT `fk_calendar_author` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_calendar_editor` FOREIGN KEY (`editor_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `campuses`
--
ALTER TABLE `campuses`
  ADD CONSTRAINT `fk_campuses_author` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_campuses_editor` FOREIGN KEY (`editor_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `contacts`
--
ALTER TABLE `contacts`
  ADD CONSTRAINT `fk_contacts_author` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_contacts_editor` FOREIGN KEY (`editor_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `eservices`
--
ALTER TABLE `eservices`
  ADD CONSTRAINT `fk_eservices_author` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_eservices_editor` FOREIGN KEY (`editor_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `officials`
--
ALTER TABLE `officials`
  ADD CONSTRAINT `fk_officials_author` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_officials_editor` FOREIGN KEY (`editor_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `fk_posts_author` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_posts_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `fk_posts_editor` FOREIGN KEY (`editor_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `post_views`
--
ALTER TABLE `post_views`
  ADD CONSTRAINT `fk_post_views_post` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`);

--
-- Constraints for table `programs`
--
ALTER TABLE `programs`
  ADD CONSTRAINT `fk_programs_author` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_programs_editor` FOREIGN KEY (`editor_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_programs_unit` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`);

--
-- Constraints for table `program_posts`
--
ALTER TABLE `program_posts`
  ADD CONSTRAINT `fk_program_posts_author` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_program_posts_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `fk_program_posts_editor` FOREIGN KEY (`editor_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_program_posts_program` FOREIGN KEY (`program_id`) REFERENCES `programs` (`id`);

--
-- Constraints for table `program_post_views`
--
ALTER TABLE `program_post_views`
  ADD CONSTRAINT `fk_program_post_views_post` FOREIGN KEY (`post_id`) REFERENCES `program_posts` (`id`);

--
-- Constraints for table `regents`
--
ALTER TABLE `regents`
  ADD CONSTRAINT `fk_regents_author` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_regents_editor` FOREIGN KEY (`editor_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `units`
--
ALTER TABLE `units`
  ADD CONSTRAINT `fk_units_author` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_units_editor` FOREIGN KEY (`editor_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `unit_info`
--
ALTER TABLE `unit_info`
  ADD CONSTRAINT `fk_unit_info_author` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_unit_info_editor` FOREIGN KEY (`editor_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_unit_info_unit` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`);

--
-- Constraints for table `unit_posts`
--
ALTER TABLE `unit_posts`
  ADD CONSTRAINT `fk_unit_posts_author` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_unit_posts_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `fk_unit_posts_editor` FOREIGN KEY (`editor_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_unit_posts_unit` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`);

--
-- Constraints for table `unit_post_views`
--
ALTER TABLE `unit_post_views`
  ADD CONSTRAINT `fk_unit_post_views_post` FOREIGN KEY (`post_id`) REFERENCES `unit_posts` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_program` FOREIGN KEY (`program_id`) REFERENCES `programs` (`id`),
  ADD CONSTRAINT `fk_users_unit` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
