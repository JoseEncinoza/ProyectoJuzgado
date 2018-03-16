CREATE DATABASE IF NOT EXISTS `juzgado_dev` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `juzgado_dev`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dna_identity_applications`
--

CREATE TABLE IF NOT EXISTS `dna_identity_applications` (
`application_id` int(10) unsigned NOT NULL,
  `application_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dna_identity_email_credentials`
--

CREATE TABLE IF NOT EXISTS `dna_identity_email_credentials` (
`credential_id` int(10) unsigned NOT NULL,
  `application_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=13835 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dna_identity_groups`
--

CREATE TABLE IF NOT EXISTS `dna_identity_groups` (
`group_id` int(10) unsigned NOT NULL,
  `application_id` int(10) unsigned DEFAULT NULL,
  `group_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `permissions` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dna_identity_memberships`
--

CREATE TABLE IF NOT EXISTS `dna_identity_memberships` (
  `user_id` int(10) unsigned NOT NULL,
  `group_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dna_identity_tokens`
--

CREATE TABLE IF NOT EXISTS `dna_identity_tokens` (
`token_id` int(10) unsigned NOT NULL,
  `application_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration_date` datetime DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dna_identity_username_credentials`
--

CREATE TABLE IF NOT EXISTS `dna_identity_username_credentials` (
`credential_id` int(10) unsigned NOT NULL,
  `application_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dna_identity_users`
--

CREATE TABLE IF NOT EXISTS `dna_identity_users` (
`user_id` int(10) unsigned NOT NULL,
  `application_id` int(10) unsigned DEFAULT NULL,
  `description` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_photo_filename` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=13836 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `dna_identity_applications`
--
ALTER TABLE `dna_identity_applications`
 ADD PRIMARY KEY (`application_id`), ADD UNIQUE KEY `application_name_unq` (`application_name`), ADD KEY `application_name_idx` (`application_name`);

--
-- Indices de la tabla `dna_identity_email_credentials`
--
ALTER TABLE `dna_identity_email_credentials`
 ADD PRIMARY KEY (`credential_id`), ADD KEY `IDX_FC28B1F03E030ACD` (`application_id`), ADD KEY `IDX_FC28B1F0A76ED395` (`user_id`);

--
-- Indices de la tabla `dna_identity_groups`
--
ALTER TABLE `dna_identity_groups`
 ADD PRIMARY KEY (`group_id`), ADD UNIQUE KEY `UNIQ_8E1324BA77792576` (`group_name`), ADD UNIQUE KEY `group_name_unq` (`group_name`,`application_id`), ADD KEY `IDX_8E1324BA3E030ACD` (`application_id`), ADD KEY `group_name__application__idx` (`group_name`);

--
-- Indices de la tabla `dna_identity_memberships`
--
ALTER TABLE `dna_identity_memberships`
 ADD PRIMARY KEY (`user_id`,`group_id`), ADD KEY `IDX_685F296CA76ED395` (`user_id`), ADD KEY `IDX_685F296CFE54D947` (`group_id`);

--
-- Indices de la tabla `dna_identity_tokens`
--
ALTER TABLE `dna_identity_tokens`
 ADD PRIMARY KEY (`token_id`), ADD KEY `IDX_D4240C443E030ACD` (`application_id`), ADD KEY `IDX_D4240C44A76ED395` (`user_id`);

--
-- Indices de la tabla `dna_identity_username_credentials`
--
ALTER TABLE `dna_identity_username_credentials`
 ADD PRIMARY KEY (`credential_id`), ADD UNIQUE KEY `username_application_unq` (`username`,`application_id`), ADD KEY `IDX_14D5C0823E030ACD` (`application_id`), ADD KEY `IDX_14D5C082A76ED395` (`user_id`);

--
-- Indices de la tabla `dna_identity_users`
--
ALTER TABLE `dna_identity_users`
 ADD PRIMARY KEY (`user_id`), ADD UNIQUE KEY `uniqueEmail` (`email`,`application_id`), ADD KEY `IDX_DBE2D2E43E030ACD` (`application_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `dna_identity_applications`
--
ALTER TABLE `dna_identity_applications`
MODIFY `application_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `dna_identity_email_credentials`
--
ALTER TABLE `dna_identity_email_credentials`
MODIFY `credential_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13835;
--
-- AUTO_INCREMENT de la tabla `dna_identity_groups`
--
ALTER TABLE `dna_identity_groups`
MODIFY `group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `dna_identity_tokens`
--
ALTER TABLE `dna_identity_tokens`
MODIFY `token_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `dna_identity_username_credentials`
--
ALTER TABLE `dna_identity_username_credentials`
MODIFY `credential_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `dna_identity_users`
--
ALTER TABLE `dna_identity_users`
MODIFY `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13836;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `dna_identity_email_credentials`
--
ALTER TABLE `dna_identity_email_credentials`
ADD CONSTRAINT `FK_FC28B1F03E030ACD` FOREIGN KEY (`application_id`) REFERENCES `dna_identity_applications` (`application_id`),
ADD CONSTRAINT `FK_FC28B1F0A76ED395` FOREIGN KEY (`user_id`) REFERENCES `dna_identity_users` (`user_id`);

--
-- Filtros para la tabla `dna_identity_groups`
--
ALTER TABLE `dna_identity_groups`
ADD CONSTRAINT `FK_8E1324BA3E030ACD` FOREIGN KEY (`application_id`) REFERENCES `dna_identity_applications` (`application_id`);

--
-- Filtros para la tabla `dna_identity_memberships`
--
ALTER TABLE `dna_identity_memberships`
ADD CONSTRAINT `FK_685F296CA76ED395` FOREIGN KEY (`user_id`) REFERENCES `dna_identity_users` (`user_id`),
ADD CONSTRAINT `FK_685F296CFE54D947` FOREIGN KEY (`group_id`) REFERENCES `dna_identity_groups` (`group_id`);

--
-- Filtros para la tabla `dna_identity_tokens`
--
ALTER TABLE `dna_identity_tokens`
ADD CONSTRAINT `FK_D4240C443E030ACD` FOREIGN KEY (`application_id`) REFERENCES `dna_identity_applications` (`application_id`),
ADD CONSTRAINT `FK_D4240C44A76ED395` FOREIGN KEY (`user_id`) REFERENCES `dna_identity_users` (`user_id`);

--
-- Filtros para la tabla `dna_identity_username_credentials`
--
ALTER TABLE `dna_identity_username_credentials`
ADD CONSTRAINT `FK_14D5C0823E030ACD` FOREIGN KEY (`application_id`) REFERENCES `dna_identity_applications` (`application_id`),
ADD CONSTRAINT `FK_14D5C082A76ED395` FOREIGN KEY (`user_id`) REFERENCES `dna_identity_users` (`user_id`);

--
-- Filtros para la tabla `dna_identity_users`
--
ALTER TABLE `dna_identity_users`
ADD CONSTRAINT `FK_DBE2D2E43E030ACD` FOREIGN KEY (`application_id`) REFERENCES `dna_identity_applications` (`application_id`);


INSERT INTO `dna_identity_applications`(`application_id`,`application_name`) VALUES (1,'Admin'),(2,'Web');

INSERT INTO `dna_identity_users`(`user_id`,`application_id`,`description`,`email`,`profile_photo_filename`,`is_active`,`created_at`,`updated_at`) VALUES (1,1,'Admin','admin@email.com',null,1,now(),now());

INSERT INTO `dna_identity_email_credentials`(`credential_id`,`application_id`,`password`,`user_id`) VALUES (1,1,'$2y$14$BAfIpmpHy8zNRkg2y54INuJ/d6ObC5IY2lopHwSb5o/aAdzgPY4pe',1);

INSERT INTO `dna_identity_groups`(`group_id`,`application_id`,`group_name`,`permissions`) VALUES (1,1,'Administrators','[\"ROLE_ADMIN\"]'),(2,1,'Managers','[\"ROLE_ADMIN_USER_MANAGER\",\"ROLE_ADMIN_STAFF_MANAGER\",\"ROLE_ADMIN_GROUP_MANAGER\"]');

INSERT INTO `dna_identity_memberships`(`user_id`,`group_id`) VALUES (1,1);

