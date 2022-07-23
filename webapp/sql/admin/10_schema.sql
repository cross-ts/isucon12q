USE `isuports`;

DROP TABLE IF EXISTS `tenant`;
DROP TABLE IF EXISTS `id_generator`;
DROP TABLE IF EXISTS `visit_history`;

CREATE TABLE `tenant` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `display_name` VARCHAR(255) NOT NULL,
  `created_at` BIGINT NOT NULL,
  `updated_at` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8mb4;

CREATE TABLE `id_generator` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `stub` CHAR(1) NOT NULL DEFAULT '',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `stub` (`stub`)
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8mb4;

CREATE TABLE `visit_history` (
  `player_id` VARCHAR(255) NOT NULL,
  `tenant_id` BIGINT UNSIGNED NOT NULL,
  `competition_id` VARCHAR(255) NOT NULL,
  `created_at` BIGINT NOT NULL,
  `updated_at` BIGINT NOT NULL,
  INDEX `tenant_id_idx` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8mb4;

CREATE TABLE `visit_history2` (
  `player_id` varchar(255) NOT NULL,
  `tenant_id` bigint unsigned NOT NULL,
  `competition_id` varchar(255) NOT NULL,
  `min_created_at` bigint NOT NULL,
  PRIMARY KEY `pk` (`tenant_id`, `competition_id`, `player_id`, `min_created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO visit_history2 (`tenant_id`, `competition_id`, `player_id`, `min_created_at`)
SELECT tenant_id, competition_id, player_id, MIN(created_at)
FROM visit_history GROUP BY tenant_id, competition_id, player_id;
