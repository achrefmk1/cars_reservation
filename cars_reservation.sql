-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : sam. 26 août 2023 à 10:42
-- Version du serveur : 8.0.27
-- Version de PHP : 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `cars_reservation`
--

-- --------------------------------------------------------

--
-- Structure de la table `agencies`
--

DROP TABLE IF EXISTS `agencies`;
CREATE TABLE IF NOT EXISTS `agencies` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `adresse` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `workDays` json NOT NULL,
  `start` time NOT NULL,
  `isEnabled` enum('yes','no') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'yes',
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `agencies_email_unique` (`email`),
  KEY `agencies_user_id_foreign` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `agencies`
--

INSERT INTO `agencies` (`id`, `name`, `adresse`, `phone`, `email`, `workDays`, `start`, `isEnabled`, `user_id`, `created_at`, `updated_at`) VALUES
(4, 'smart diagnostic', 'tunis', '22334455', 'smart_diag@gmail.com', '[\"Vendredi\", \"Mercredi\", \"Jeudi\"]', '09:00:00', 'yes', 1, '2023-08-25 20:32:11', '2023-08-25 20:32:11'),
(3, 'CAR Care', 'tunis', '22334455', 'tunis@gmail.com', '[\"Lundi\", \"Mardi\", \"Mercredi\", \"Jeudi\", \"Vendredi\", \"Samedi\"]', '08:00:00', 'yes', 1, '2023-08-22 20:24:25', '2023-08-22 20:24:25'),
(5, 'mécanoo diag', 'sousse', '22334455', 'MECANO@gmail.com', '[\"Lundi\", \"Mercredi\", \"Samedi\", \"Vendredi\"]', '08:00:00', 'yes', 1, '2023-08-25 20:33:15', '2023-08-25 20:33:15');

-- --------------------------------------------------------

--
-- Structure de la table `agency_service`
--

DROP TABLE IF EXISTS `agency_service`;
CREATE TABLE IF NOT EXISTS `agency_service` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `agency_id` bigint UNSIGNED NOT NULL,
  `service` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `period` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `times` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `agency_service_agency_id_foreign` (`agency_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `agency_service`
--

INSERT INTO `agency_service` (`id`, `agency_id`, `service`, `period`, `times`, `created_at`, `updated_at`) VALUES
(4, 1, 'lavage', '1', 6, '2023-08-22 21:34:12', '2023-08-22 21:34:12'),
(3, 1, 'vidange', '2', 2, '2023-08-22 21:33:56', '2023-08-22 21:33:56'),
(5, 3, 'lavage', '2', 5, '2023-08-24 05:13:01', '2023-08-24 05:13:01'),
(6, 3, 'vidange', '2', 2, '2023-08-24 05:13:43', '2023-08-25 20:30:05');

-- --------------------------------------------------------

--
-- Structure de la table `cars`
--

DROP TABLE IF EXISTS `cars`;
CREATE TABLE IF NOT EXISTS `cars` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `marque` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `year` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `matricule` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isEnabled` enum('yes','no') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'yes',
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cars_user_id_foreign` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cars`
--

INSERT INTO `cars` (`id`, `marque`, `year`, `model`, `matricule`, `isEnabled`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'mercedes', '2022', 'E63s', '213TU1234', 'yes', 1, '2023-08-19 20:42:22', '2023-08-19 20:54:20'),
(2, 'bmw', '2022', 'm5 F90', '230 tu 1234', 'yes', 2, '2023-08-21 18:13:03', '2023-08-21 18:13:14'),
(3, 'mercedes', '2022', 'E63s', '201TU201', 'yes', 4, '2023-08-25 20:34:22', '2023-08-25 20:34:22');

-- --------------------------------------------------------

--
-- Structure de la table `day_offs`
--

DROP TABLE IF EXISTS `day_offs`;
CREATE TABLE IF NOT EXISTS `day_offs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `agency_id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `day_offs_agency_id_foreign` (`agency_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `day_offs`
--

INSERT INTO `day_offs` (`id`, `agency_id`, `date`, `name`, `created_at`, `updated_at`) VALUES
(1, 1, '2023-09-01', 'aid Fitr', '2023-08-24 03:08:52', '2023-08-24 03:09:40'),
(2, 3, '2023-08-24', 'aid idhha', '2023-08-24 03:36:20', '2023-08-24 03:36:20');

-- --------------------------------------------------------

--
-- Structure de la table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(4, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(5, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(6, '2016_06_01_000004_create_oauth_clients_table', 1),
(7, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(8, '2019_08_19_000000_create_failed_jobs_table', 1),
(9, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(10, '2023_08_16_202516_create_agencies_table', 1),
(11, '2023_08_16_225440_create_cars_table', 1),
(16, '2023_08_17_000113_create_agency_service_table', 2),
(17, '2023_08_23_155513_create_rdv_table', 3),
(18, '2023_08_24_035619_create_day_offs_table', 4);

-- --------------------------------------------------------

--
-- Structure de la table `oauth_access_tokens`
--

DROP TABLE IF EXISTS `oauth_access_tokens`;
CREATE TABLE IF NOT EXISTS `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `client_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('7075d1f75d10917209c024bf8f0f9c80b6983ebb24f5a74e5d822e2ea1b6dfcab66341df5ab8401a', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 16:43:48', '2023-08-19 16:43:48', '2024-08-19 17:43:48'),
('e5a1b0111a2fca2664d1a8875128bca744d10503409c65d415f604dc4a373499d2b300a173b5a5cf', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 16:53:30', '2023-08-19 16:53:30', '2024-08-19 17:53:30'),
('300794d0abf6ecdda52424807c780d3339c316640eac97e73ae36003f36b418a472ea9e587de0218', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 16:54:00', '2023-08-19 16:54:00', '2024-08-19 17:54:00'),
('e7c7cda7e83ac6e16ccbc3a3f0cd2f4459a4063e083602c4dd2ff8bfa6f8ccd98d9aaf2762d8bb01', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 16:54:31', '2023-08-19 16:54:31', '2024-08-19 17:54:31'),
('09a47791c856fb13807eef0785e438af689ac0c0223aa2c381a973ba9f9f5c0ace0bd883243a980e', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 16:56:15', '2023-08-19 16:56:15', '2024-08-19 17:56:15'),
('65705bad1211bf46d9c2792a97f7afd0b7ae1a1c38735f8ab7e0a75f901d9f49c62918a2ebe8569b', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 16:57:16', '2023-08-19 16:57:16', '2024-08-19 17:57:16'),
('d38b34ecf5a7c98f2474cfbe1b689b4d5af0912c6550f8fc921d7131b4d4a846c57268be7ca1caa2', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 16:59:22', '2023-08-19 16:59:22', '2024-08-19 17:59:22'),
('92eabe8d2f2da3028d9efd30537d825afc5fa5306732efb1f759ddd7d49372565f7aea5fbfbf8bc1', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 17:35:19', '2023-08-19 17:35:19', '2024-08-19 18:35:19'),
('a5677ea705c5f87321c6169cd57c08dc83d30d8f3b0ea2b3eada8da612c4f4d20ca1674bcd4a4cba', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 17:35:33', '2023-08-19 17:35:33', '2024-08-19 18:35:33'),
('2cafc9519f0dd38c03a3665c0b89a47e3d399f7ba91a7525289557fc8fa1f2cd4535ffbb11c6eb20', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 17:35:55', '2023-08-19 17:35:55', '2024-08-19 18:35:55'),
('3cbb734aea86e0863c29fa2e036dc243887619acfcadc389a5ca00ce61bd70f924e016c58b34581d', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 17:36:50', '2023-08-19 17:36:50', '2024-08-19 18:36:50'),
('74527628be7ce60ac1a11a5c800e6f92d125faf5d55d0b452928de4ae63428ebbab503dbc752e60d', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 17:37:03', '2023-08-19 17:37:03', '2024-08-19 18:37:03'),
('51e0bf131628f57cb853e4dce3f88ad1eaa0ea913787d43c608f6a5e657bee5a19e4e591e4a52ae3', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 17:37:29', '2023-08-19 17:37:29', '2024-08-19 18:37:29'),
('eb46e1f238592896499f0de952260d8d3233a56635911c705d5f8e6da8648d6b5e98a22fc55ecf9b', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 17:37:47', '2023-08-19 17:37:47', '2024-08-19 18:37:47'),
('4602f10994a784bc23c93b887fe0b3644347a2421bcb240d8ebc9e1a51d5f0f0ed2d827551e5b047', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 19:26:33', '2023-08-19 19:26:33', '2024-08-19 20:26:33'),
('ac540bd82e14a69ed5ff2c719ca99a95a9285dc02a4cd6a968b5be88c3ebaf92a24b227b3867e6e3', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 19:27:35', '2023-08-19 19:27:35', '2024-08-19 20:27:35'),
('4a0ead81f690d9feb686533a37acabd583ad55359efd03d883f9e5d5af4203815ba520725d5bc383', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 19:28:59', '2023-08-19 19:28:59', '2024-08-19 20:28:59'),
('4a32b8c95580b50d7ece110f2313a0216ab903258991abe77d64a0899ce9482c0c5a36719abd4245', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 19:32:15', '2023-08-19 19:32:15', '2024-08-19 20:32:15'),
('ca91c1c111ae1075adcdc2694c015d7695d820a6b1ff2154b992cfc81d4387be696c0b8b51488dc5', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 19:32:41', '2023-08-19 19:32:41', '2024-08-19 20:32:41'),
('e08554c87b316afd7f53269b9eaad6ece32de60d31ee35fbb6ffa5f5f6336457ce8a510c405bcf23', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 19:34:07', '2023-08-19 19:34:07', '2024-08-19 20:34:07'),
('fa6a7a912aaf8c62b745a9286e4b039867b401f23b10358fbe4d96a6baae1b670c98b4eb4eb3c6c7', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 19:36:24', '2023-08-19 19:36:24', '2024-08-19 20:36:24'),
('3cdac421e190ec2151dbec27ccb303183a654854587d2b57c5835d9bd7e078bfd18e157541bae46a', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 19:38:51', '2023-08-19 19:38:51', '2024-08-19 20:38:51'),
('b909f5d902cde32f646b2194336d0b70a8b0edeb3eafc39a4da078782871f1fc745b17290c753e9d', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 20:28:21', '2023-08-19 20:28:22', '2024-08-19 21:28:21'),
('0a86a5d2b7876bb058e578be8a7f6bd3599a8d7252b370004884f8116dea892baf1365acce956800', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 20:28:57', '2023-08-19 20:28:57', '2024-08-19 21:28:57'),
('f95a4715b0b13b3246cd3445b844524daaf79e0ce54b433aeba34c72cc3113577a7bc30883cfffdb', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 20:40:52', '2023-08-19 20:40:52', '2024-08-19 21:40:52'),
('6e9106e57246d81589d58371b7f6ccb871eb3e93021e2252e9c74505023ea0694f74b4707ba16d21', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 20:41:07', '2023-08-19 20:41:07', '2024-08-19 21:41:07'),
('3304c5878c479cdf486556313fbb0bc62ab0b1874e05df1efb4f03fc40a23d28de143bd9afa7e3a8', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 20:41:51', '2023-08-19 20:41:51', '2024-08-19 21:41:51'),
('4571ea928c6c9ae80f6f357655540448782ff353d26d405e4aceadf7b082d608ff685274dea40292', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 20:42:55', '2023-08-19 20:42:55', '2024-08-19 21:42:55'),
('9faee0c3a5037064797f4d561867d05bc792b0191800d9977a9ac8dd9ded6e873c5bbc8bd061cb24', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 20:43:58', '2023-08-19 20:43:58', '2024-08-19 21:43:58'),
('99ae15ffcdc48a39e650948cab3e221630eee35c152924075ed2da0419672dafd7a3cd8bf2fb610f', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 20:47:50', '2023-08-19 20:47:50', '2024-08-19 21:47:50'),
('d029914452d9012b99251de59d2480a95003060f26a3513afc7e5f5b53164bed8da24f15b33c1002', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 20:49:40', '2023-08-19 20:49:40', '2024-08-19 21:49:40'),
('163df18b20e11aa29e5e91c100a5cd93a786967a68f0d8d4f65db7ec40e63ca756691278f3a00ce7', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 20:50:42', '2023-08-19 20:50:42', '2024-08-19 21:50:42'),
('7ffc3afd4dedf42db6df85747da6acbfc19a5c33d5aec543f23c9634a27b52f0a237658886125850', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 20:51:03', '2023-08-19 20:51:03', '2024-08-19 21:51:03'),
('9664e9606d0e4a74fb344cba7e89bbc95836d2b12c7dedca0df571e73b026334aba27fcaa19eb6c2', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 20:54:14', '2023-08-19 20:54:14', '2024-08-19 21:54:14'),
('9242711ddde266d66f1e53af66dd2760db7267ba1a2313b9ee52a191743724fb287e47e920ed244c', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-19 20:55:12', '2023-08-19 20:55:12', '2024-08-19 21:55:12'),
('b580f144e453f1732579c5bdc3261705eb2b6d2b12e25c4966aea32eead4e9becbb1c60e83c35e36', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-20 16:58:14', '2023-08-20 16:58:14', '2024-08-20 17:58:14'),
('e90672af29fc8e015156b4f2b7aed0c69dd22ebaa7200719dcac74556338fd025efebc48fe5ee247', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-20 17:53:31', '2023-08-20 17:53:31', '2024-08-20 18:53:31'),
('9390a2d9ea30119d854362a133a95f45d93348f8b778c4a11a7ef3c394c34f07bd8745c16ded2dc9', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-20 17:55:20', '2023-08-20 17:55:20', '2024-08-20 18:55:20'),
('3443eb482b76e7d3b31aad944e940a8499f6ff9196e6c35573440c37e304c81f5e474d90f9acdf86', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-20 17:56:03', '2023-08-20 17:56:03', '2024-08-20 18:56:03'),
('8b586f4891642899c61ed86eeda4fad85c4ce9ea84db8cdc6088d6f705d4964adeb3c69062f018ff', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-20 17:57:28', '2023-08-20 17:57:28', '2024-08-20 18:57:28'),
('efde4f2a570fdc03736f5cd7cee4761f3c10fd89ca4fecd5f2d0c552b3467f9bc596b8116c12837d', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-20 18:03:37', '2023-08-20 18:03:37', '2024-08-20 19:03:37'),
('a3e27d5a96b312e118244f564cd4d9f16a6735d393c98a7249ec8cb3b2dec609326beb820fbe2a0c', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-20 18:04:11', '2023-08-20 18:04:11', '2024-08-20 19:04:11'),
('3dddc299dba11231cd4b0ee7e19396ae29614a2c00c722dfe750117335441e5540a185553da81198', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-20 18:04:34', '2023-08-20 18:04:34', '2024-08-20 19:04:34'),
('66bf311c66e61984d310f2030f9eff9447922f3f76952e4e87c21fd8bb6b6c3cbba9ca7891f41e0d', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-20 18:07:37', '2023-08-20 18:07:37', '2024-08-20 19:07:37'),
('400a073e8edff18bfee32dc542bf48435fafe1e918e705cffdfdbed270e436386db8c29f384ddb55', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-20 18:09:21', '2023-08-20 18:09:21', '2024-08-20 19:09:21'),
('ad43204aa939a7eb61fdb3368178db4bae827d4408cf688516216d6546fb67dc3507403dae3021d3', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-20 18:13:26', '2023-08-20 18:13:26', '2024-08-20 19:13:26'),
('f982d5eff5998cf53d70bbb7bdbef89a08ba4946eb3100b45cd20aa62b4eab2d84dee88588ab3f04', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-20 18:15:30', '2023-08-20 18:15:30', '2024-08-20 19:15:30'),
('6ad9a22ba68dd79dff0c884d116ecd8b8e350d8b145b3648d7214e5c49a8d8d99f49ec84a720f094', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-20 18:17:31', '2023-08-20 18:17:31', '2024-08-20 19:17:31'),
('6cb62b15f447bf0f77e9fefc651d9b24c4ff9b24c579643f3855771cae26555fad6ac4c676676d6d', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-20 18:19:28', '2023-08-20 18:19:28', '2024-08-20 19:19:28'),
('bb65d64b98d03af2437642ef2cd13512da75e5f74a275c1550a6eaa61d41a5cb9286f8ed37bc6521', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-20 18:22:20', '2023-08-20 18:22:20', '2024-08-20 19:22:20'),
('8940d7e4b4c47068847e2bc8b04cfae0939e2c5306db86f2eb9f49b3ecaa9f1ba7e37d92962dfca6', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-20 18:22:35', '2023-08-20 18:22:35', '2024-08-20 19:22:35'),
('2c8132eeae25edddd43492dc408da3ed77db5e5aa5652e49ddcb4d0193c0c26c9ac436ab9ab2f3a4', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-20 19:17:50', '2023-08-20 19:17:50', '2024-08-20 20:17:50'),
('f1acdb944507395528667536325347db54c6be87ca731cc121e1772dbb49ab1bdac3f45c4055efb4', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-20 19:20:01', '2023-08-20 19:20:01', '2024-08-20 20:20:01'),
('dde3e6558fd9409c935dabc903a3d52fee51aab63b3d946c04055e20bd238ccd794e41e24059fa42', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-20 19:21:29', '2023-08-20 19:21:29', '2024-08-20 20:21:29'),
('1262d8768e7e111325be59a291f08bc08f21150ca519de3cb4694d1802a034f4a7e2b32e81e44a77', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-20 19:21:52', '2023-08-20 19:21:52', '2024-08-20 20:21:52'),
('2bace7b0b95d3fbc6ae5e5568ecf243f9982ff135f7492cedb214b1235387f8b416c514f3c9f3302', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-20 19:22:59', '2023-08-20 19:22:59', '2024-08-20 20:22:59'),
('570f6e6bc4bd79e785453c18aa0383a8c193c326bfa6467ce5da7f2e44621afd2b9993b3db6c7358', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-20 19:23:27', '2023-08-20 19:23:27', '2024-08-20 20:23:27'),
('23e227aba3529bbe39e581e88fa4215672d026cc149b0c51793985e7e3b0d7df820443c209eff01c', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-20 19:25:21', '2023-08-20 19:25:21', '2024-08-20 20:25:21'),
('71bfb459bc5495a52a3991227a9863e31a4ad5ae69a828ed81526d7b335d5f564253d9fa53ee7a35', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-21 15:34:20', '2023-08-21 15:34:20', '2024-08-21 16:34:20'),
('667fe0446ffa806873e01deae4a71fabbab39a5da1e7bc288b43840efe6079b9ebc363d69533389e', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-21 15:35:08', '2023-08-21 15:35:08', '2024-08-21 16:35:08'),
('5fe8db53221d6273909d60ad769e48622308b11eeb54c065cce2f7a29664cdc7005326894ca86b0b', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-21 15:35:59', '2023-08-21 15:35:59', '2024-08-21 16:35:59'),
('948330fe1cfc332d2112d048140680cc7a5b11201751d5729db54eacef6a158a5de7c9726eb82c69', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-21 15:36:10', '2023-08-21 15:36:10', '2024-08-21 16:36:10'),
('0dce2969c2b73fb64b6d18cb7bffc9ffb701289be45c1031f7013b34f4c44e1d2ba7182c6227b528', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-21 15:40:45', '2023-08-21 15:40:45', '2024-08-21 16:40:45'),
('eb1d4a64c030fd82801b2d81e77833108d27550afb50d8f472b91a14a8459372aa8ac305e307ea21', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-21 15:43:04', '2023-08-21 15:43:04', '2024-08-21 16:43:04'),
('f85be5c8f79c2f6dfa968fd7f8ca6663292a9d42459f4455aba3a1e0b36e993ed064878246f594a5', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-21 15:43:52', '2023-08-21 15:43:52', '2024-08-21 16:43:52'),
('3a6d1b82b368e5e915b85a32c1fa8d0dd172e988e6b32af3b31afb11fd9286873543e94cbcd05bfc', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-21 15:44:18', '2023-08-21 15:44:18', '2024-08-21 16:44:18'),
('c7144d294b3ad471c02d841318f60085da5fbc4e5f9c7ce40a15147b6c3afeddbaaf2492bca2ddc3', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-21 15:47:05', '2023-08-21 15:47:05', '2024-08-21 16:47:05'),
('c965326dc94aa50808f72b5e7d39ca8d508894fe1904aa86add7999ba543f479d84d535feb1006e9', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-21 15:47:19', '2023-08-21 15:47:19', '2024-08-21 16:47:19'),
('b17b460f1d3081b55d862fdb142032da39165c9bdca99ded608877f6adad50a972d81957329fb273', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-21 15:54:37', '2023-08-21 15:54:37', '2024-08-21 16:54:37'),
('44384622560e90c4ff6a2620820ab458dcfdf163ea42f592a798b503b84df653b55c4e744dc642df', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-21 16:37:07', '2023-08-21 16:37:07', '2024-08-21 17:37:07'),
('ce22aa3818ecb54e9736189de8eb5d02d5b8dcb331a12f02e89e5abba9a2fc31d9ac2662d04f3f70', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-21 16:37:39', '2023-08-21 16:37:39', '2024-08-21 17:37:39'),
('2edf9ebfc6cb34d6b6b246352a681e8b13da16a9c413f336085d0c780614241a926e6523dc88f077', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-21 16:39:05', '2023-08-21 16:39:05', '2024-08-21 17:39:05'),
('cd85cdd65cc4bacf2722d9c1ad7a7521cb43f94a6c4b6a3551d2b561829fad1ed5ebd8bd8b27370d', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-21 16:41:10', '2023-08-21 16:41:10', '2024-08-21 17:41:10'),
('90bd9e34c0f060cc0ff8dfe89f748531788c18a41ea74d1c0f5c8cfe13364260b2173e791a934ecb', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-21 16:42:54', '2023-08-21 16:42:54', '2024-08-21 17:42:54'),
('10e8ac8ec0089f66feefbbc8df598d73bdbc4519bf92323648ff6ce9526270cb63bfc386fbf9a74a', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-21 18:07:05', '2023-08-21 18:07:06', '2024-08-21 19:07:05'),
('b278f22025623701882fbd059eb22d7e0c97ece653de983d2fa8f32d962efea3d860afa28afb2ac5', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-21 18:23:44', '2023-08-21 18:23:44', '2024-08-21 19:23:44'),
('0b4cca2a4d111c9b09e6c26ae6c344f74bf163b7454fdb48e6ddd78081127970ebbdb34bde466021', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-22 18:34:51', '2023-08-22 18:34:51', '2024-08-22 19:34:51'),
('c3387028f11c60979117c92fd8ab13a0ab0c290f5ca741eaaff047f45b27912b5bf7948dfa257051', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-22 18:38:20', '2023-08-22 18:38:20', '2024-08-22 19:38:20'),
('16cf7f3a55ac91384c7fbd63713e252014990b68c5c5631daa23f72faf5f939855ff0a5c0d101d75', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-22 20:33:31', '2023-08-22 20:33:31', '2024-08-22 21:33:31'),
('d1cb08fe2f4a38e1d4497b6064a76f7d8e391e1dbb890c1d512d9c1fb0a791725d96e3377c5c43ea', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-22 22:51:40', '2023-08-22 22:51:40', '2024-08-22 23:51:40'),
('c665ee23b7390ca7b5e0a54be8f2cb428de829229adf2777d8e4b96bfef1b4adb04516de7fbce781', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-22 22:53:01', '2023-08-22 22:53:01', '2024-08-22 23:53:01'),
('106d1c6fdef59d8dc18a923c085d2a6d6db3d06e6bc84fd3b3da6c69faa787fa8cf0d4f2a4392f37', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-22 22:55:27', '2023-08-22 22:55:27', '2024-08-22 23:55:27'),
('999f3caa4284eb9eef7efe21ab6c3fcfda51a139a2a19f7c18c23d99048cd9645d8ce2cd6d6627a1', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-22 22:56:05', '2023-08-22 22:56:05', '2024-08-22 23:56:05'),
('d8b8bf40b16411acde3f95b4663d17bbddcf84c7d3db1f58abec2e4651c9d49a8d103428a8055b23', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-22 22:57:14', '2023-08-22 22:57:14', '2024-08-22 23:57:14'),
('dbbff196235aee41b10d360eeb98a84df218be9a953839b7a5640f278eaaaff5ef49f18a1f45508e', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-22 23:07:55', '2023-08-22 23:07:55', '2024-08-23 00:07:55'),
('86875cc8bd0e8699b5d91250d904a3c60189a41075f7275b1a61282b596233608f419a5f0f7d0d96', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-23 14:15:51', '2023-08-23 14:15:51', '2024-08-23 15:15:51'),
('f626019581c09f69ea580ceb73fd82d1c6c1ae6211c346562fd7b8b9c7af2e31bd9a67d9a2abeb6a', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-23 14:16:56', '2023-08-23 14:16:56', '2024-08-23 15:16:56'),
('8449788acecbe45f6ec61cf5d77208a4d8a6fe60075955bf06d8437b77c8121acf80b9a567a95041', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-23 14:26:09', '2023-08-23 14:26:09', '2024-08-23 15:26:09'),
('a27815abad2975edc57e1988a44d270f13699fd9e7421fa8a75c5b2f3e56a62d322b9116308f18f6', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-23 14:26:41', '2023-08-23 14:26:41', '2024-08-23 15:26:41'),
('136a2c82ca7603f5b153bac81ab434e08faec21f9df4b4bddd7fa4530807e45cc208f75cfb729fae', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-23 14:30:17', '2023-08-23 14:30:17', '2024-08-23 15:30:17'),
('b6ea3551091bfe5263b51084bd03b1b2a55d0f3f533a1504f3dfd98b5dfc2cb0c46f6cad10982394', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-23 14:30:53', '2023-08-23 14:30:53', '2024-08-23 15:30:53'),
('39af8b1db129c154427a301da19c5ecdd32bc50d7f2657c673e12d161e4e3ac786165fc05e1d4b0e', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-23 14:31:31', '2023-08-23 14:31:31', '2024-08-23 15:31:31'),
('7f8cd1dba73fc72ae7a3580973c6c35769cee670b324c3f2d48491c6f52275c9bf8eb18585562ce2', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-23 14:35:22', '2023-08-23 14:35:23', '2024-08-23 15:35:22'),
('7c5d2630711a488d164ca5f6e5b67fda0d68864c839328fd0a2d9ad30e1421b3cccd5ff274b560ab', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-23 14:41:53', '2023-08-23 14:41:53', '2024-08-23 15:41:53'),
('d99ae741b1eb9451bcfcd8156ea8f37883c2c8f9935dc2b02811c2d7d49afc25ef6cd2f42418bea7', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-23 14:43:58', '2023-08-23 14:43:58', '2024-08-23 15:43:58'),
('683518b9b2edb06f86225fa7a41ecd237414188624de34bd6f0f573edcdf0855c5b87946f7c71c17', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-23 14:44:18', '2023-08-23 14:44:18', '2024-08-23 15:44:18'),
('78ed35cfcdb357dd28d0767332116332f8c4c7eeab8e46274573f46e5b03aadac2fab4ca21f42a27', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-23 14:45:58', '2023-08-23 14:45:58', '2024-08-23 15:45:58'),
('4018208f1e9652e94d4d86d3528dbdf7aae0b72328ab75bd6a65f3ff3bd04dadc3d27834c7e46e88', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-23 14:52:38', '2023-08-23 14:52:38', '2024-08-23 15:52:38'),
('0380816ca22672e2669779ad1970ed0d80148e3530a815805a2c995f04ff1395629dd84520bc2284', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-23 14:53:16', '2023-08-23 14:53:16', '2024-08-23 15:53:16'),
('f9279108cf860f36e2c0fa77f53ae370b02d68ec6d8892cf9a88f8bac71c8b99a8cc0b2517edc3fd', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-23 21:05:12', '2023-08-23 21:05:12', '2024-08-23 22:05:12'),
('dcd583cf1db7b2b7dfc26a1bc0bef610f448a37a6004feca0f66ddbb3cfa35bfa731262c6cb17b82', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 03:07:04', '2023-08-24 03:07:04', '2024-08-24 04:07:04'),
('1e393f2f9de532889c2d123bc936ac1a1f29124a1715bb42ef3bcb926829e9e1729c6e7f77ae4009', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 03:17:07', '2023-08-24 03:17:07', '2024-08-24 04:17:07'),
('ffc5dc2a2383fc0b25cc7ead279e2a978bdbcccfc2cc5030d22b1fa8434539ff84344349972de690', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 03:20:00', '2023-08-24 03:20:00', '2024-08-24 04:20:00'),
('714b74dc5952611ad25a1a316493e3b8ad783cefc55ea18ada20efb96921c0492ba31b3806feb10b', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 03:20:18', '2023-08-24 03:20:18', '2024-08-24 04:20:18'),
('177d7f6be0d69bfa25f2331d03683885f6db90d2782906de911613c8aadb2bdfa7279e17b3a3ab21', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 03:21:18', '2023-08-24 03:21:18', '2024-08-24 04:21:18'),
('12751a21b68f1d6b3d373efc993b0f11a9cf389fdafff66aea0bbe13a58269bae424c7b247044b59', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 03:22:22', '2023-08-24 03:22:22', '2024-08-24 04:22:22'),
('e35739ea05eeac398625574272512297aace3ca96fb0ef8304819fb1c01cab2af92fbe637855e9b6', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 03:23:37', '2023-08-24 03:23:37', '2024-08-24 04:23:37'),
('7d9e5377f77c014557cb3113a4fc768cb33793f959e1818ec5daef41423d1a7f1445d2feedd85ddb', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 03:26:03', '2023-08-24 03:26:03', '2024-08-24 04:26:03'),
('dd26f3a829d5c9ed83f18d28ec3a816a80226294e99af4e95b2054eb12af40ae27efb237f2e38508', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 03:28:25', '2023-08-24 03:28:25', '2024-08-24 04:28:25'),
('9d9a3966ca6e620d2af7889bc3f81bf608b321be64869cab65483c12a436e8d892cf1297e29afc48', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 03:29:16', '2023-08-24 03:29:16', '2024-08-24 04:29:16'),
('8d8e0261fa7a70f1dfd4c0f9f0dfb900058a1ad2e00e9e53e3ffb0252343f0d3fc96b5904907a258', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 03:31:56', '2023-08-24 03:31:56', '2024-08-24 04:31:56'),
('5ac3f4b90fe48697313ce8b6bf2e5b773825d939deb4083c3f1b98c3beef5447f2ce475e5b351792', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 03:32:32', '2023-08-24 03:32:32', '2024-08-24 04:32:32'),
('8fece7b1d61babe8a99f4635e768df108f58aa100c5e7f769390bfbd43b04f5393f8dec1353d6171', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 03:33:15', '2023-08-24 03:33:15', '2024-08-24 04:33:15'),
('5effa2dee946faf3cb75675f148d9cfdc439a858a23e58e63325552a41cd69458773f0b1dd3c3282', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 03:36:05', '2023-08-24 03:36:05', '2024-08-24 04:36:05'),
('d1f24f35982e568523553d38630d125794fec125e592f5149da9e8229c6f21dcb7bec2da5205f7ec', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 03:37:29', '2023-08-24 03:37:29', '2024-08-24 04:37:29'),
('4716cccc611c3cb660c582509c72d048236e4c94ddad26bd704bda723c74f0bf3501cf17b7ebbe6e', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 03:41:03', '2023-08-24 03:41:03', '2024-08-24 04:41:03'),
('875ad8f89202d898735ca55173ef7f23b2544bcc1922e9f39d9860896524320d4fd820ce614cdca5', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 03:43:41', '2023-08-24 03:43:41', '2024-08-24 04:43:41'),
('8cf5213154c684e45b45a38bed0e249d897612c2f2e1a164a52f0c73fceece7d620f70413d3b4df9', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 04:13:09', '2023-08-24 04:13:09', '2024-08-24 05:13:09'),
('e9aa9521b645a6279152e16ffd9f09c8556fd26d5a3e028e3c1cb0119e160ceeed255513dfc84530', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 04:16:05', '2023-08-24 04:16:05', '2024-08-24 05:16:05'),
('9bb061cc3df282fd9f6dcf175b29b4ae2abdb7ef12430110f73ee3461df453a8af0813cd906bd70a', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 04:18:35', '2023-08-24 04:18:35', '2024-08-24 05:18:35'),
('f5acbad70ffaddb5919f815348b674cfa7bddc1a8e3f66ed7fc2407fd89d87820ed4aebf08d389bc', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 04:21:10', '2023-08-24 04:21:10', '2024-08-24 05:21:10'),
('2831ef5c1ef3e0399a1ff5175f42539db5eff09f7bbe2a70ec8937ebece18b78748313a57b048e66', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 04:21:58', '2023-08-24 04:21:58', '2024-08-24 05:21:58'),
('4619cb6d6e74ad2f3f3f115ae39808b319e261c8c44cdb82fa7e624ac4eec0bded287e1ef375c37b', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 04:22:20', '2023-08-24 04:22:20', '2024-08-24 05:22:20'),
('8b351c4043e306867dfc6ab514a9ffb7ab83e279c742e76d8104363a234df8aad5685847ad0ddea4', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 04:42:18', '2023-08-24 04:42:18', '2024-08-24 05:42:18'),
('6a1d66858c14a84eda225831ced2c82b528a017f7184b1f79da938a93e285ce391cfc64d95b5c5b8', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 04:42:40', '2023-08-24 04:42:40', '2024-08-24 05:42:40'),
('3024fbacc3e41028475bfbff13439825d3407d4c51937a8efe64e9baddc89e1b937773c770d209e5', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 04:42:57', '2023-08-24 04:42:57', '2024-08-24 05:42:57'),
('23e5c96c45a200ca20dd1b7f781048544f4221588e0b559f39b6dc4f9b7f0896bfdc4b74a4074884', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 05:03:40', '2023-08-24 05:03:40', '2024-08-24 06:03:40'),
('04b68245f9f96fa11c269c67291c94088de525e406de3aa9a3ecef7fcd9401cee1974e6e9d187685', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 05:05:21', '2023-08-24 05:05:21', '2024-08-24 06:05:21'),
('13d598b6507ffe2aea6a1eb66e21111e883696eb1d87f56f97fa2818d31a782d593aebc7f0968b6f', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 05:06:08', '2023-08-24 05:06:08', '2024-08-24 06:06:08'),
('d2f88786405c0fd9274396080360ecf5298b8b34dd6a9d985cbecaa882edf73d3af87bee99a488b8', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 05:06:54', '2023-08-24 05:06:54', '2024-08-24 06:06:54'),
('719bf59b93f84642dbb4a1cb18de3f1d2967ee6eb1e3a68ba541e1f36b4dbf6c8291e99d86facf54', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 05:08:02', '2023-08-24 05:08:02', '2024-08-24 06:08:02'),
('36166fde5bf2621b4643cf27fab9a55a2c248f3bc9755a8c02ad803c4f73bd4484ec3623b0818827', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 05:10:27', '2023-08-24 05:10:27', '2024-08-24 06:10:27'),
('662becbfb25cf9ced2cc1bafee8f563fda5b45e79638b856b26623a4b4b84a34007dd2a79a458eab', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 05:12:47', '2023-08-24 05:12:47', '2024-08-24 06:12:47'),
('6a203c509315bed9f69073f8341583dbfe8a29e44f2f44ea75ca62bac3634b00629617baa47c25fe', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 05:13:30', '2023-08-24 05:13:30', '2024-08-24 06:13:30'),
('05e717b447d1f0bb1e50d25a539c6ba40853d7bffcb1827bc809f3e939b765749a7e152feafc4128', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 17:30:04', '2023-08-24 17:30:04', '2024-08-24 18:30:04'),
('6db027cb2bcb39eaf25d80bdbfc4b51270e303c24fbb4737490dc605ba21c0cd36f2e2d534ec7583', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-24 17:38:49', '2023-08-24 17:38:49', '2024-08-24 18:38:49'),
('0636fff786188b2d16041c03b70da07a78c0e82d8c5585301a90871b717732a8d93bf285921949f9', 4, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 02:35:39', '2023-08-25 02:35:39', '2024-08-25 03:35:39'),
('6464cf910da534b26368efe4207c9011801d15dc85410a94b0781de5624308f96e16eccd3b061a59', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 02:37:09', '2023-08-25 02:37:09', '2024-08-25 03:37:09'),
('3e8ae290dae59d2a0a40336ebfbc35abe692ef6d8f2f7791cce751ff822837f0eceb81599946dae6', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 02:38:00', '2023-08-25 02:38:00', '2024-08-25 03:38:00'),
('33cabfcb2d9c412df28437b72fa9c960490c8c297e6ef4e3cc44edeb3c8b363af412beb4e0e2ba96', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 02:38:22', '2023-08-25 02:38:22', '2024-08-25 03:38:22'),
('01c6e720d1d065da2849e4a78293e5937c350cf4311f5f10e83ec8006fd47c4dbfee3d60d184db2e', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 02:40:22', '2023-08-25 02:40:22', '2024-08-25 03:40:22'),
('3fe3d0b499e8c89776ed6edfa4a3d46ead1f426ae00d310cab476330a6aeddd6e1cc99e5c14c0522', 4, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 02:42:02', '2023-08-25 02:42:02', '2024-08-25 03:42:02'),
('e6a5d2b143cb090ef0257392b1cc695cddf27acf3ad955f2886cdd0a53afe4983a0326bcb99d0c7b', 4, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 02:42:50', '2023-08-25 02:42:50', '2024-08-25 03:42:50'),
('89a08aeb495f1e7fc27c622047b5bd9c3ade9c46d4e9ac13aae4260d285d95f3e6b1a0da108636fe', 5, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 02:44:46', '2023-08-25 02:44:46', '2024-08-25 03:44:46'),
('f6939b225efc69125d4ac5a5c063c6367e1fad8ac7ebfedbdc62a629a02e2ce1175ad37912876a83', 5, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 02:45:36', '2023-08-25 02:45:36', '2024-08-25 03:45:36'),
('282be2be33ab4d5de3c47a3f3d7d375a2d7b178de76aa2534e2ce3c4c3f8fd80ebff937e6dee4e7e', 5, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 02:47:05', '2023-08-25 02:47:05', '2024-08-25 03:47:05'),
('80b1afff3fe893fd5723064ff7a7838d4fc05110b094ac15d01a8b4b00891827f6e8ee25de2589f7', 5, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 02:48:00', '2023-08-25 02:48:00', '2024-08-25 03:48:00'),
('d0744cabde76223bd7042a0a3922584bdcb5168da79b12d4a0900df553e55931b6c085c397aaaa55', 5, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 02:49:02', '2023-08-25 02:49:02', '2024-08-25 03:49:02'),
('08561e2bc104d1e25434c5b24c3cfe9eef56d42b04cf26aa8388739e4e371a2da416a36f812de26a', 5, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 02:49:33', '2023-08-25 02:49:33', '2024-08-25 03:49:33'),
('97a5bab3d0d36d2f3f15f9be0265e26cb5361cb23c07c3cfccb3bd7836478c11adc1a7a3a1389ab3', 5, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 02:50:55', '2023-08-25 02:50:56', '2024-08-25 03:50:55'),
('581a67bb236a8b533c795df20a3a08d4ce5e41485307238e1c3faa853e088d598187428c74fcdaae', 5, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 02:53:58', '2023-08-25 02:53:58', '2024-08-25 03:53:58'),
('cbe144ab200eec92e31323b61d3f9a826901d3709ac3ef4c5234596e9306db77362ba61f0f145912', 5, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 02:55:21', '2023-08-25 02:55:21', '2024-08-25 03:55:21'),
('f83326db1d50ae593c2bec4919d4492699cf8932eeee2b5ed229b60c2418a768aa38c2f20cb70427', 5, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 02:55:39', '2023-08-25 02:55:39', '2024-08-25 03:55:39'),
('d361e88f288672263f1b2822222be8fa372c2d38cc8424d7d55682ecc3f0cb0eac482941958112ef', 5, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 02:57:05', '2023-08-25 02:57:05', '2024-08-25 03:57:05'),
('a9fb9fb62128e62473c04d346a572550ed57275d72c549dbaa6fdb05c05b50a024f620769b992883', 5, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 02:58:08', '2023-08-25 02:58:08', '2024-08-25 03:58:08'),
('3c1168e251fcd8084eae2e151df8c784cdadbafd885f1d32126a0bd6ca1bbdeb962c22a3fb6382f6', 5, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:07:51', '2023-08-25 03:07:51', '2024-08-25 04:07:51'),
('f327f159e20c942703e08f9aaf82a06f8d7383194d5444bcba1296b387b312d38631c14e20e8fc68', 5, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:08:11', '2023-08-25 03:08:11', '2024-08-25 04:08:11'),
('c9fefa4e3ea4ecd49bc2d51c2e6519a5f0868c2c84e817f206242fd7fb72ea98c50924527af84450', 5, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:09:18', '2023-08-25 03:09:18', '2024-08-25 04:09:18'),
('985477a0cf00ff61a6d9f7bc35572962a923c699d4729182c698d923139c6e43720b944fefcaf864', 5, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:10:09', '2023-08-25 03:10:09', '2024-08-25 04:10:09'),
('dbd0bc337e6bfd68dc7765012656900846d0c954dfb795554ce903de1b92d85fe99e659eedadee10', 5, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:11:10', '2023-08-25 03:11:10', '2024-08-25 04:11:10'),
('90ea0a45b28ebeebb0e1ecfa452b60af404d1fdc23cbe408c3a9f48e0ca1e9f86fd6d3632f6cf327', 5, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:11:54', '2023-08-25 03:11:54', '2024-08-25 04:11:54'),
('23491575bb3801adb30d84257796b70a7ff3e75ff5129de39bb59f718bf06e62952afd43ce124dfd', 5, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:12:34', '2023-08-25 03:12:34', '2024-08-25 04:12:34'),
('2d84c16811f33dc2c88808ff7ca62d807a93f8fe1d299003bba09ebce452d7b70af3379db053a84a', 5, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:13:47', '2023-08-25 03:13:47', '2024-08-25 04:13:47'),
('a26c98e4ddf8a789b6b55aff30a68b8aecaeddabac393b84805621e1dcf8cd67d1c35fa9e15c7bc6', 5, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:14:55', '2023-08-25 03:14:55', '2024-08-25 04:14:55'),
('01ef723ee82148e0e502c69e91a97d3296ab5d0dc64a069a150e268335e8e94f51bc525d71e32ad1', 5, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:15:26', '2023-08-25 03:15:26', '2024-08-25 04:15:26'),
('004214e35275c6bd4492364c64cbd71fa93f9b1c3c4775aa071f152cc25a26176660d57df0d1700b', 4, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:16:31', '2023-08-25 03:16:31', '2024-08-25 04:16:31'),
('3e9aac76fae361a0f85e87a7121e1596e113ab760cfca03183afe8aac83ab10bc40c74b3d7b1fa38', 4, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:19:01', '2023-08-25 03:19:01', '2024-08-25 04:19:01'),
('97354084ee725d0a08c13584bfa143e8e343ffd308be6c7e809d0d5ec6784d3d443d3357da2006bd', 4, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:19:39', '2023-08-25 03:19:39', '2024-08-25 04:19:39'),
('fb8abde2e4f1dff7cc37f279b7e45aca7e45ae63616a6def41d3c34e21c794696e0db6d6fbb7fdbe', 4, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:20:59', '2023-08-25 03:20:59', '2024-08-25 04:20:59'),
('5887c41b93e7b3aebf3b2bb4ed7b633eeaf4fd245cbc211387942a897b04c5dc8cc41e24ba174be8', 4, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:22:04', '2023-08-25 03:22:04', '2024-08-25 04:22:04'),
('cd157654903455507eb13357d27660f3208a84a6e9642cef373c98ca7523c6f0231b58560057099a', 4, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:22:35', '2023-08-25 03:22:35', '2024-08-25 04:22:35'),
('e86aa3dac6ed3564f8af5aa9b0647bdb8aa05036cb653bad1300f2edf71c69a5c10553a80b44f10f', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:23:12', '2023-08-25 03:23:12', '2024-08-25 04:23:12'),
('92575978a17b373b3dbd5cf0000352f1e9a989f3b5279e8f86b2b3b2c827fc7fb63223d34eec5cd4', 5, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:23:22', '2023-08-25 03:23:22', '2024-08-25 04:23:22'),
('f0c79b93d3c1f113d9f0e90a8694ac713a6cfe218bf9b37c0bae9b36447bb2016bff2a4190c4fa24', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:24:09', '2023-08-25 03:24:09', '2024-08-25 04:24:09'),
('e98eee28491ee385bed79bfdb571e44cd8146cd8f2536122fa81e9e0ce0d5da52de98ae19fdb6e6b', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:27:28', '2023-08-25 03:27:28', '2024-08-25 04:27:28'),
('5e631ab749849ddbebbe2818a96dc96bb9bcbfd02a6aad19803137a3cbb44182c7434ffb3ab38fcb', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:27:46', '2023-08-25 03:27:46', '2024-08-25 04:27:46'),
('49de302c3976837b318c7689a71ca6b67b0b4505e8cfa565ff4977413cc950bd91e5b7bc16e12ac4', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:29:01', '2023-08-25 03:29:01', '2024-08-25 04:29:01'),
('4edb5bc62b2e95343eca9e5f64920ce19022e86aab7c834de0eaa04afbc5c37e64b9c55124968f40', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:31:57', '2023-08-25 03:31:57', '2024-08-25 04:31:57'),
('700ba8272ab4c4272c22c622683ddbf99ae82bc9de8f7e614e64663921a08a79ace416f5a994d273', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:33:18', '2023-08-25 03:33:18', '2024-08-25 04:33:18'),
('b17990ecf69f541af9ca8fe0267b485fce041ca784c98a4081657f3cff6ac84107011d385984852f', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:34:06', '2023-08-25 03:34:06', '2024-08-25 04:34:06'),
('e39d35e4e4c8e6edcd15163288acef48c55324cb33eb259c3987f2a3262f2d84b5707cb181336521', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:35:15', '2023-08-25 03:35:15', '2024-08-25 04:35:15'),
('c400b4e5ffc48d9b1ecfb5518354922c7bb4dc275808d23cea9a651b4fdc1cc46ae4b1e1f622f4b4', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:47:13', '2023-08-25 03:47:13', '2024-08-25 04:47:13'),
('237d569f6f69bfd8e502dc132bc75e38ff8be0c62315bfe1abdcc5e4915ae6f3b2f0c865669c4053', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:48:02', '2023-08-25 03:48:02', '2024-08-25 04:48:02'),
('a425d3b3fa12b14680bade189bef9efcefb27e13e7fe91c77ad4f8b39f8e0b4bf0c69868949641a1', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:48:59', '2023-08-25 03:48:59', '2024-08-25 04:48:59'),
('7da7a1a13967e06659ebe700b95bea7057cd82b9fa91aa3921113efd4e064dd90ed80738dd8c3a0b', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:50:16', '2023-08-25 03:50:16', '2024-08-25 04:50:16'),
('0a6e20c6a87e75989a4375ebae875333f0b8d2c55e9bb3331255b1a19919eba601f8a4aec6542667', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:51:39', '2023-08-25 03:51:39', '2024-08-25 04:51:39'),
('b0435b8502fb397c8416fa0c4b48d2b889f25d35d73e47ff193f127dc968904c8281021f69c94b08', 5, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:52:13', '2023-08-25 03:52:13', '2024-08-25 04:52:13'),
('66679e1d4e46bbba6e6e445d2f36e39982df622dc4694efabdf27d99f91f4328133f4ab2b0e3086b', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:52:53', '2023-08-25 03:52:53', '2024-08-25 04:52:53'),
('99e1be2905bd1e7e2aee5f3ec8d4667c60b110ed7c0a9f18be8d50de78077f0d8aa2118fd5e4473e', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:54:42', '2023-08-25 03:54:42', '2024-08-25 04:54:42'),
('7818a36cd99e8855c31f7bf2d3e93680418e6f12d4fb5a896bfb2bfb4dc2322d674ef2b78c357d40', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:55:35', '2023-08-25 03:55:35', '2024-08-25 04:55:35'),
('2cef7c82d98ff3c338488918c009f2331ea675b20a23cb5263bd551a773d57b4414809b308c26f76', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:58:03', '2023-08-25 03:58:03', '2024-08-25 04:58:03'),
('d37de2bc8880a16826590abb5c3a268fa9a63871a132c9a8c7bec46cec28c92425a2cd086a2a8947', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:58:15', '2023-08-25 03:58:15', '2024-08-25 04:58:15'),
('3cff0016eca2af525d2065735bcee583bca218a2fa9e1ff1173c491c00c03317d20755ab8d32f839', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 03:58:35', '2023-08-25 03:58:35', '2024-08-25 04:58:35'),
('c8192f18ba098134ef73c8e11ffa209c13e266f7a044569721a53aa0c0adf0ad28bfef4d83cf9f5d', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 04:01:35', '2023-08-25 04:01:35', '2024-08-25 05:01:35'),
('5998a1d719a86201513ab7add2e58ef2cbe1c0b47d56b59b0c187b67b2585c767455b3049035907e', 5, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 04:03:16', '2023-08-25 04:03:16', '2024-08-25 05:03:16'),
('30ff5ac37e0ac988da89935e0f1653eef0939e70a1e6f4538b61fbae782622e841955fe1016856a8', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 20:24:30', '2023-08-25 20:24:31', '2024-08-25 21:24:30'),
('6fe05dc09675bbd1a6b7b9bb1d30302c98b4a2893deb0218f27b35f984eb2dd7af25417c20c6f9b8', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 20:27:20', '2023-08-25 20:27:20', '2024-08-25 21:27:20'),
('cf1c6ed0af4593ea90476a396188077e784f892d132a52106edb2afe13b851b469243a3fabc5cd53', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 20:28:53', '2023-08-25 20:28:53', '2024-08-25 21:28:53'),
('641de806ec164a155eb5c8f4665dabd026da6e84ecdd66b8cb8b1d82bae20a7d3ea78462ff50d7cd', 1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 20:29:13', '2023-08-25 20:29:13', '2024-08-25 21:29:13'),
('7991a63a493fadf480fd9951fa0af0357b26509c6e1beed1dc5b1d010dfb96a52087550b91da6ea8', 4, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 20:33:54', '2023-08-25 20:33:54', '2024-08-25 21:33:54'),
('a8a33e66adcc474120cda0208233443c7b87ba8eafd44b6ce57d219d2ea3c632ebef921979ae89aa', 4, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 20:35:19', '2023-08-25 20:35:19', '2024-08-25 21:35:19'),
('6dc76b693ebd6a5ab12a7b8519f191fc95d915ec2536ba7bb310c1b73b4e131dc32703f07fac29bb', 4, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 20:35:39', '2023-08-25 20:35:39', '2024-08-25 21:35:39'),
('6fe53e2bedf05c17e1cd3a5364e8ed7eccd7ec4ec7a354ca307662a074dfe27ca2b957a9e77f622b', 4, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 20:35:57', '2023-08-25 20:35:57', '2024-08-25 21:35:57'),
('83622d0c5f1256ce29f6843a9dfae5fd2b01adf2a776fb557c36ba31ca87eeeef4bcde10317d3238', 4, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 20:37:02', '2023-08-25 20:37:02', '2024-08-25 21:37:02'),
('aed06906a877498bb15f919a36f33555bb8068bf8ba95d94904329cea7dba1ee7463285942b3cceb', 4, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 20:38:36', '2023-08-25 20:38:36', '2024-08-25 21:38:36'),
('d414dbfe3692221e424df610a7a8d5d7df5db62405e13ce89c9659bd134922a53aa8854e96922a6b', 4, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 20:41:34', '2023-08-25 20:41:34', '2024-08-25 21:41:34'),
('944bbd8a71d67f701cbb12aca92f48f3e42c79342464a62e03fa0f391679fb937e3e9852c7a28b82', 4, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', 'Laravelia', '[]', 0, '2023-08-25 20:42:37', '2023-08-25 20:42:37', '2024-08-25 21:42:37');

-- --------------------------------------------------------

--
-- Structure de la table `oauth_auth_codes`
--

DROP TABLE IF EXISTS `oauth_auth_codes`;
CREATE TABLE IF NOT EXISTS `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `client_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_auth_codes_user_id_index` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oauth_clients`
--

DROP TABLE IF EXISTS `oauth_clients`;
CREATE TABLE IF NOT EXISTS `oauth_clients` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
('99edd18f-de47-4aa0-8b68-9e69bcdb3afe', NULL, 'Laravel Personal Access Client', 'x54SbNE4ii2P4DFDuy27IzCzDCHwbwAblmJfxIIO', NULL, 'http://localhost', 1, 0, 0, '2023-08-19 16:43:41', '2023-08-19 16:43:41'),
('99edd18f-e322-4184-a8b5-ac71bc282d4b', NULL, 'Laravel Password Grant Client', 'PkLnmXJMZ5GGx9xxB874LLycxOdyh3mBRQKs5zCP', 'users', 'http://localhost', 0, 1, 0, '2023-08-19 16:43:41', '2023-08-19 16:43:41');

-- --------------------------------------------------------

--
-- Structure de la table `oauth_personal_access_clients`
--

DROP TABLE IF EXISTS `oauth_personal_access_clients`;
CREATE TABLE IF NOT EXISTS `oauth_personal_access_clients` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `client_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, '99edd18f-de47-4aa0-8b68-9e69bcdb3afe', '2023-08-19 16:43:41', '2023-08-19 16:43:41');

-- --------------------------------------------------------

--
-- Structure de la table `oauth_refresh_tokens`
--

DROP TABLE IF EXISTS `oauth_refresh_tokens`;
CREATE TABLE IF NOT EXISTS `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `rdv`
--

DROP TABLE IF EXISTS `rdv`;
CREATE TABLE IF NOT EXISTS `rdv` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `agency_id` bigint UNSIGNED NOT NULL,
  `service` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `car_id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rdv_agency_id_foreign` (`agency_id`),
  KEY `rdv_car_id_foreign` (`car_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `rdv`
--

INSERT INTO `rdv` (`id`, `agency_id`, `service`, `car_id`, `date`, `created_at`, `updated_at`) VALUES
(1, 1, 'lavage', 3, '2023-09-01', '2023-08-23 15:22:11', '2023-08-23 15:22:11');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('admin','manager','user') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `isEnabled` enum('yes','no') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'yes',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `name`, `phone`, `email`, `email_verified_at`, `password`, `role`, `isEnabled`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'admin 2', '2233456', 'admin@gmail.com', NULL, '$2y$10$Ink2jBhx9A7n7T3pEWkS9uCSxUSHRapwomPGysy4dfluhjoCd./0S', 'admin', 'no', NULL, '2023-08-19 16:42:32', '2023-08-21 18:10:13'),
(2, 'achref', '22334455', 'achref@gmail.com', NULL, '$2y$10$gggXXaN4sJTcRrXHqCjpj.Am..47G77sMuOdLKCALE0rWdYnMwfvG', 'user', 'yes', NULL, '2023-08-19 19:39:29', '2023-08-19 19:39:29'),
(3, 'rabeb', '22334455', 'rabeb@gmail.com', NULL, '$2y$10$hqRgrVJ2pkSBCuYH3bv4yeZf/AqssD0MwFq34pfT4LPK.BbSmHDhq', 'user', 'yes', NULL, '2023-08-21 18:11:09', '2023-08-21 18:11:09'),
(4, 'Salim', '22334456', 'salim@gmail.com', NULL, '$2y$10$mxUAYY22xH7yFyPYBXGz.e30/eOdRn5qO5yV7ZwRodNWlOKfvvtSC', 'user', 'yes', NULL, '2023-08-25 02:35:02', '2023-08-25 02:35:02'),
(5, 'Aymen', '22334455', 'aymen@gmail.com', NULL, '$2y$10$EDnpr/w.4pIyCpvHw.AAbeT04q/lfykqQTNt/hIJqWpjF5cM/VYFi', 'manager', 'yes', NULL, '2023-08-25 02:44:23', '2023-08-25 02:44:23');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
