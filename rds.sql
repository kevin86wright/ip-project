CREATE DATABASE  IF NOT EXISTS `ip_project`;
USE `ip_project`;

DROP TABLE IF EXISTS `addresses_tmp`;
CREATE TABLE `addresses_tmp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `networks_tmp`;
CREATE TABLE `networks_tmp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cidr` varchar(255) DEFAULT NULL,
  `nw_start` bigint DEFAULT NULL,
  `nw_end` bigint DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

