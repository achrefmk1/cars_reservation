-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : dim. 27 août 2023 à 14:44
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
  `end` time NOT NULL,
  `isEnabled` enum('yes','no') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'yes',
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `agencies_email_unique` (`email`),
  KEY `agencies_user_id_foreign` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `agencies`
--

INSERT INTO `agencies` (`id`, `name`, `adresse`, `phone`, `email`, `workDays`, `start`, `end`, `isEnabled`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'Car Cleaner', 'Khezama sousse', '22334455', 'carc@gmail.com', '[\"Lundi\", \"Mardi\", \"Mercredi\", \"Jeudi\", \"Vendredi\"]', '08:00:00', '17:00:00', 'yes', 2, '2023-08-27 07:02:17', '2023-08-27 07:02:30');

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
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `agency_service`
--

INSERT INTO `agency_service` (`id`, `agency_id`, `service`, `period`, `times`, `created_at`, `updated_at`) VALUES
(1, 1, 'Lavage', '2', 3, '2023-08-27 07:26:06', '2023-08-27 07:26:06');

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
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cars`
--

INSERT INTO `cars` (`id`, `marque`, `year`, `model`, `matricule`, `isEnabled`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'Mercedes', '2020', 'E63s', '201TU212', 'yes', 3, '2023-08-27 07:22:38', '2023-08-27 07:22:38');

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
(1, 1, '2023-09-02', 'test', '2023-08-27 08:05:41', '2023-08-27 08:05:41'),
(2, 1, '2023-08-23', 'ryjrgyj', '2023-08-27 13:33:29', '2023-08-27 13:33:29');

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
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(12, '2023_08_17_000113_create_agency_service_table', 1),
(13, '2023_08_23_155513_create_rdv_table', 1),
(14, '2023_08_24_035619_create_day_offs_table', 1);

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
('3893f55186375145f1a1b34aa95e2b5fef11d808c1a1e121ce78c13dfd3bb7c21dc84cf20702b2b2', 1, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 06:48:58', '2023-08-27 06:48:58', '2024-08-27 07:48:58'),
('665d45abcf4510294b6fbb799612518581de6d4b2ac82862fbeefc15cff5bd64424d48c9a3c59f26', 2, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 06:56:01', '2023-08-27 06:56:01', '2024-08-27 07:56:01'),
('3da2368bcba86f61be34e7613ce2ae220c00897699d7f766af381554f71dbd75ea0acdce218625d0', 2, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 06:59:07', '2023-08-27 06:59:07', '2024-08-27 07:59:07'),
('e57ebee1a9a7a3e123a48d0381e7b213d37a1d96b9f7d3bad1a88c45429e21cf25a1a1f12e4a8c8d', 2, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 07:01:36', '2023-08-27 07:01:36', '2024-08-27 08:01:36'),
('b73df1e6bf0b4c2b30cc3adda134ba8db90a7c44e615d44f0029fd88c112e7cb4ccfcf70f3370371', 2, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 07:04:02', '2023-08-27 07:04:02', '2024-08-27 08:04:02'),
('3116ac7eb0ac20de5322618e9325a1d97535c6b7273f2485f24ed033531ad48836885ea4f0966db5', 2, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 07:07:19', '2023-08-27 07:07:19', '2024-08-27 08:07:19'),
('0712fe814757cf21aa56ec44dff5cd67480cc08b7ec9c081cf7797fc3358be5ab52f483b05f1f889', 2, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 07:10:10', '2023-08-27 07:10:10', '2024-08-27 08:10:10'),
('c5df39cf80619ce51a9a15168fa994a98b741b4410afd3c581d5a037a185d6e81c319e12e614b4f0', 2, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 07:11:06', '2023-08-27 07:11:06', '2024-08-27 08:11:06'),
('f77d1f608daee9e5a4b49fdacedb5d53c912af6432af2aede9f81abd55009bc17a74a35e8e94fc56', 2, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 07:12:47', '2023-08-27 07:12:47', '2024-08-27 08:12:47'),
('aa09edfa59ed1344f1ce6d2dfb956ce4bc4276b01a7d293ad797d3123ee33b03d5a0d26b276a9985', 2, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 07:13:39', '2023-08-27 07:13:39', '2024-08-27 08:13:39'),
('75b5a9f1f19774f42fd1196f5072cd8202050f42715c9486a1247241bc981da85bd41349ff8a254f', 1, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 07:13:53', '2023-08-27 07:13:53', '2024-08-27 08:13:53'),
('4b3afac32e0f6dc287d3d67c8b6e0d7216a8d22077d9800c844fb4bda729f94da6c9826088397303', 1, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 07:21:32', '2023-08-27 07:21:32', '2024-08-27 08:21:32'),
('46443691003ef0f4a57c1ab4c3993ec14bd9ffd687969f0705310b79f6b3e7c37566a663cebf8303', 3, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 07:22:11', '2023-08-27 07:22:11', '2024-08-27 08:22:11'),
('319040ed830572d2295ff1bc25cecca80e19ac269411ca864d831d46fa0b34620593d368705068c2', 3, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 07:23:24', '2023-08-27 07:23:24', '2024-08-27 08:23:24'),
('7cb91f9ae3cd0d06757fda32afe78415d4aab4c86c9fd95bea7cb69c538438f40f3a88b2eb24a1c3', 2, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 07:23:38', '2023-08-27 07:23:38', '2024-08-27 08:23:38'),
('227b6362c5acbd1e8da9fa48af35ac97ff59f67d6fe9d25f0616b268e8285b8553e7379bd0717ac7', 2, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 07:25:51', '2023-08-27 07:25:51', '2024-08-27 08:25:51'),
('f538a89826ec26f90a15f3e2fc5ee3884191a7198ea9f58e16c26dfecd746c907cba91dbc24ae28f', 3, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 07:26:17', '2023-08-27 07:26:17', '2024-08-27 08:26:17'),
('f0ec21e13dc401e6c92118b4c32a8537e04c73f893c04b7a4ed1e81f78f43f1db33b6f05ee2fc8e9', 3, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 07:33:41', '2023-08-27 07:33:41', '2024-08-27 08:33:41'),
('c185b3bfd2605c362801da80f932f9d7897d028047b155b6ebc0fec7d0c9b4e853644cb5f8c7c6b7', 2, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 08:04:20', '2023-08-27 08:04:20', '2024-08-27 09:04:20'),
('d69b63d7de692fdfd08914f2652a3ac3c36be7149d89a1cfb3daa2e5570ffcd1d366e48b5f074856', 3, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 09:24:20', '2023-08-27 09:24:20', '2024-08-27 10:24:20'),
('873833d03b1e4e3b11fad5bd9e83bf646f3074ff0b51be8f6a51f3c632e872047ea669a593731e8d', 3, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 09:26:06', '2023-08-27 09:26:06', '2024-08-27 10:26:06'),
('d1e1983ed9457b035cf08f056c5f16f82a57e66354eb9764d8d2d7141c4cf79aa019a56199fed81d', 3, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 09:27:23', '2023-08-27 09:27:23', '2024-08-27 10:27:23'),
('8605dd409e66dc81ac249533970c486ce9b22e20c6a2bdd2b96df4515aea3890df28c0a0636485ec', 3, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 09:28:08', '2023-08-27 09:28:08', '2024-08-27 10:28:08'),
('d86ae8878aa0080ebca52bd5c605a83dc3a30b4b52916ebd976730fd48d3186b669a563a90db52ee', 3, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 09:30:50', '2023-08-27 09:30:50', '2024-08-27 10:30:50'),
('0a59ef02b3ce1a34e4467b9330e073001843f26a330b5a8823fea994b3769cd3e246617ebd720900', 3, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 09:33:02', '2023-08-27 09:33:02', '2024-08-27 10:33:02'),
('82902bae60b9070013866bd61cfa1e508c4b4fd428850a7b77c6c54a4e08d095437dfa8db093e7e2', 3, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 09:35:36', '2023-08-27 09:35:36', '2024-08-27 10:35:36'),
('7ab7e83e599fe51c29cf62acc06eb956ebdeb753fd48a30af8036f7cb411ff62b9f26b459c4b4bda', 3, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 09:36:12', '2023-08-27 09:36:12', '2024-08-27 10:36:12'),
('4c960e3d23124abea61cf2245e02c4067442e10a7e225cff85f20918ef48a4a878fb693b04867bb3', 3, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 09:38:31', '2023-08-27 09:38:31', '2024-08-27 10:38:31'),
('d750882bd564e7195f55a888d788bd79b5d8fef84921ed6c47bf21e502865a315a3bf1c3786d62a1', 3, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 09:39:15', '2023-08-27 09:39:15', '2024-08-27 10:39:15'),
('c21894111e5337ac7b573d5b361c5fa38e24186c26658c926c26e8e746f498be321426ca80ad1f89', 3, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 09:41:19', '2023-08-27 09:41:19', '2024-08-27 10:41:19'),
('e9bc4bbece1e6988235e1c16fccd1bb441643cbc77a388c3ac4e818f868f54b84abd4d87b7e2d5ea', 3, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 12:26:15', '2023-08-27 12:26:16', '2024-08-27 13:26:15'),
('fbb692749b43de57487766cb1e7f8a79207a977d144e98f8c4b07cf78da3d00b8efd7f757da55174', 3, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 12:28:27', '2023-08-27 12:28:27', '2024-08-27 13:28:27'),
('fbea4977869b5a88930f0ffb58188b20dcf10bb9b3059839dee6248d75cd5c6f4b838baf361e20b2', 3, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 12:41:29', '2023-08-27 12:41:29', '2024-08-27 13:41:29'),
('7a18a1dce9af842c014d98e255c601f2414617253a21230d9226cf5646efd5742deed8a0fd68ed55', 3, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 12:41:59', '2023-08-27 12:41:59', '2024-08-27 13:41:59'),
('434d94e8e30cb8b95fc82b9e9110b00879ae2cf79f57005bf31489a35b0988d41ab3c22702e4c0b1', 3, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 12:42:39', '2023-08-27 12:42:39', '2024-08-27 13:42:39'),
('a1641671b296d8db36387694d1f23c7e277bbafdcd715f9652a46802724275c295ede96783373c34', 3, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 12:43:03', '2023-08-27 12:43:03', '2024-08-27 13:43:03'),
('76c07fbedeac27bab4ad6523411cfc9dc8347925b4c26a1c48011e5ea6ea74b8b85473bb5da16e46', 2, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 12:45:59', '2023-08-27 12:45:59', '2024-08-27 13:45:59'),
('1478a8115f800af4e58c17372e8cb0666ba1ddec5de4cadecb4cf77a5768cbe18c46e07ded95920d', 2, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 12:46:13', '2023-08-27 12:46:13', '2024-08-27 13:46:13'),
('42813aaadf1b0c84efe14475d6b88f73667e0a014a5b59aec67b3c33c7d727960267fa5cb5fda0f7', 2, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 12:51:11', '2023-08-27 12:51:11', '2024-08-27 13:51:11'),
('e26c81f2f3bcee71a4c3d5f7204ea189b49f4968d22e64a4c96ec9cf8cb15c0c7e4a66138b05daab', 2, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 12:53:33', '2023-08-27 12:53:33', '2024-08-27 13:53:33'),
('b96c0e37b4020a991a9a8a8dd2a541dba616ba44371d4dda38fd427f70983e4638753bc1ba0e5dc8', 2, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 12:54:53', '2023-08-27 12:54:53', '2024-08-27 13:54:53'),
('cc1278a360d42eb33ed27284bd72b462d659930475a03f5666563a09e39868ea0a491e43c29a3f38', 2, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 12:56:24', '2023-08-27 12:56:24', '2024-08-27 13:56:24'),
('8d107c989e22adca458933c711d84e7e3e76b4c660145693c53bc129e4ffff6291cc3ca904d77abf', 2, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 13:06:36', '2023-08-27 13:06:36', '2024-08-27 14:06:36'),
('3a05432021ae6ddbdf8274df0d9d4364a129433045facb67d487d2f0ace56d38fdd772c86ddd9cf6', 2, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 13:19:32', '2023-08-27 13:19:32', '2024-08-27 14:19:32'),
('2e0a48a99e776d370b482fc01045d9cf101b366b946cde7dae97e1dfbe4d193d24ce30c8672b871d', 1, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 13:20:00', '2023-08-27 13:20:00', '2024-08-27 14:20:00'),
('906b1b37ed6fa0c1e2992afc3279c30ef81116ecb435fe9c9a36648bc02531e0cabdba523036eff9', 1, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 13:22:33', '2023-08-27 13:22:33', '2024-08-27 14:22:33'),
('6ea42df523c57134c287da3178df7020dcb153df957a3e580ab10b4891730051984ad7b36ddebb9f', 2, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 13:23:03', '2023-08-27 13:23:03', '2024-08-27 14:23:03'),
('87b8ad66d6ab0c978831914395486d25fa0b36b7f59d53628798c50a763fccdf61093f3e61176c12', 2, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 13:23:32', '2023-08-27 13:23:32', '2024-08-27 14:23:32'),
('b2db64c42aed0affb4e6dc6c0de51699f872eb50f76f905e6069d5e3ad0a03af6ac5f3155cb27ebd', 2, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 13:25:19', '2023-08-27 13:25:19', '2024-08-27 14:25:19'),
('647c88025666ca738a9ff92722e7a4cc2ec3160b16546eafbffe2ca20099834eca667d8726bfa17a', 2, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 13:28:25', '2023-08-27 13:28:25', '2024-08-27 14:28:25'),
('e79225245e3eccfd52b4c05064f8e80ba1d919ec6a4c77aaf02300eda8527de3a8443d78bac357f8', 2, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 13:30:05', '2023-08-27 13:30:05', '2024-08-27 14:30:05'),
('073b6f60f5b2ae8ab97f787de4d90aef0904731c8cb75ff55248c7449abd6a7df70eb8493e505318', 2, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', 'Laravelia', '[]', 0, '2023-08-27 13:33:13', '2023-08-27 13:33:13', '2024-08-27 14:33:13');

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
('99fd148c-f94f-41d7-b05c-cfb3b14f3750', NULL, 'Laravel Personal Access Client', 'pVz8A86dnyZvUbNshBd8AOa8DH93esb96gc6dACg', NULL, 'http://localhost', 1, 0, 0, '2023-08-27 06:48:25', '2023-08-27 06:48:25'),
('99fd148d-3f8c-47eb-9499-1888103246e5', NULL, 'Laravel Password Grant Client', 'ohjcZ5YbH9QGHQ5oeWyyFInC8RS5iIFaJNJPEfk4', 'users', 'http://localhost', 0, 1, 0, '2023-08-27 06:48:25', '2023-08-27 06:48:25'),
('99fd149b-9c0e-471a-97be-c809ab6c8e7b', NULL, 'Laravel Personal Access Client', 'uPkp6r7nCzIeyvt1QFHgfmtlZQQ9ljth8I85TjrN', NULL, 'http://localhost', 1, 0, 0, '2023-08-27 06:48:35', '2023-08-27 06:48:35'),
('99fd149b-a2c5-44fe-9057-4d87c401f22b', NULL, 'Laravel Password Grant Client', 'i3jXUaO0TAPZxBaHfAbft6p9HAkXnslTAB371Jp5', 'users', 'http://localhost', 0, 1, 0, '2023-08-27 06:48:35', '2023-08-27 06:48:35');

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
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, '99fd148c-f94f-41d7-b05c-cfb3b14f3750', '2023-08-27 06:48:25', '2023-08-27 06:48:25'),
(2, '99fd149b-9c0e-471a-97be-c809ab6c8e7b', '2023-08-27 06:48:35', '2023-08-27 06:48:35');

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
  `start` time NOT NULL,
  `end` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rdv_agency_id_foreign` (`agency_id`),
  KEY `rdv_car_id_foreign` (`car_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `rdv`
--

INSERT INTO `rdv` (`id`, `agency_id`, `service`, `car_id`, `date`, `start`, `end`, `created_at`, `updated_at`) VALUES
(4, 1, 'lavage', 1, '2023-09-01', '08:00:00', '10:00:00', '2023-08-27 09:31:49', '2023-08-27 09:31:49'),
(2, 1, 'lavage', 1, '2023-09-01', '08:00:00', '10:00:00', '2023-08-27 09:07:05', '2023-08-27 09:07:05'),
(3, 1, 'lavage', 1, '2023-09-01', '08:00:00', '10:00:00', '2023-08-27 09:07:07', '2023-08-27 09:07:07'),
(5, 1, 'Lavage', 1, '2023-09-04', '08:00:00', '10:00:00', '2023-08-27 09:41:50', '2023-08-27 09:41:50');

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
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `name`, `phone`, `email`, `email_verified_at`, `password`, `role`, `isEnabled`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'admin', '22334455', 'admin@gmail.com', NULL, '$2y$10$CHAvcvryXM8q9ZXly6.vrOQqX1.AZy2yv0QmoN66Kg5PhkaDDwere', 'admin', 'yes', NULL, '2023-08-27 06:45:05', '2023-08-27 06:45:05'),
(2, 'Aymen', 'aymen@gmail.com', 'aymen@gmail.com', NULL, '$2y$10$cX3Kb/oHEudRe762p216le4gkngDapiRVxu9YZtyb6hZTMYxeGXeS', 'manager', 'yes', NULL, '2023-08-27 06:55:50', '2023-08-27 06:55:50'),
(3, 'Salim', '22334455', 'salim@gmail.com', NULL, '$2y$10$.kKmWTm9VdP81681rI096uV1INHnuUJ4H7zs87nX0.prKgWpP04RS', 'user', 'yes', NULL, '2023-08-27 07:22:03', '2023-08-27 07:22:03');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
