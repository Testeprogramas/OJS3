-- Criar o database
CREATE DATABASE IF NOT EXISTS `ojs3`;

-- Use the database
USE `ojs3`;

-- Drop the table if it already exists
DROP TABLE IF EXISTS `access_keys`;

-- Create the table `access_keys`
CREATE TABLE IF NOT EXISTS `access_keys` (
  `access_key_id` bigint NOT NULL AUTO_INCREMENT,
  `context` varchar(40) NOT NULL,
  `key_hash` varchar(40) NOT NULL,
  `user_id` bigint NOT NULL,
  `assoc_id` bigint DEFAULT NULL,
  `expiry_date` datetime NOT NULL,
  PRIMARY KEY (`access_key_id`),
  KEY `access_keys_user_id` (`user_id`),
  KEY `access_keys_hash` (`key_hash`, `user_id`, `context`)
);

-- Drop the table `authors` if it exists
DROP TABLE IF EXISTS `authors`;

-- Create the table `authors`
CREATE TABLE IF NOT EXISTS `authors` (
  `author_id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(90) NOT NULL,
  `include_in_browse` smallint NOT NULL DEFAULT '1',
  `publication_id` bigint NOT NULL,
  `seq` double(8,2) NOT NULL DEFAULT '0.00',
  `user_group_id` bigint DEFAULT NULL,
  PRIMARY KEY (`author_id`),
  KEY `authors_user_group_id` (`user_group_id`),
  KEY `authors_publication_id` (`publication_id`)
);

-- Drop the table `author_settings` if it exists
DROP TABLE IF EXISTS `author_settings`;

-- Drop table if exists `author_settings`
DROP TABLE IF EXISTS `author_settings`;

CREATE TABLE IF NOT EXISTS `author_settings` (
  `author_setting_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `author_id` bigint NOT NULL,
  `locale` varchar(10) NOT NULL DEFAULT '',
  `setting_name` varchar(191) NOT NULL,
  `setting_value` mediumtext,
  PRIMARY KEY (`author_setting_id`),
  UNIQUE KEY `author_settings_unique` (`author_id`, `locale`, `setting_name`(191)),
  KEY `author_settings_author_id` (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Settings for authors.';


-- Drop the table `controlled_vocab_entries` if it exists
DROP TABLE IF EXISTS `controlled_vocab_entries`;

-- Create the table `controlled_vocab_entries`
CREATE TABLE IF NOT EXISTS `controlled_vocab_entries` (
  `controlled_vocab_entry_id` bigint NOT NULL AUTO_INCREMENT,
  `controlled_vocab_id` bigint NOT NULL,
  `seq` double(8,2) DEFAULT NULL,
  PRIMARY KEY (`controlled_vocab_entry_id`),
  KEY `controlled_vocab_entries_controlled_vocab_id` (`controlled_vocab_id`),
  KEY `controlled_vocab_entries_cv_id` (`controlled_vocab_id`, `seq`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COMMENT='The order that a word or phrase used in a controlled vocabulary should appear. For example, the order of keywords in a publication.';

-- Drop the table `controlled_vocab_entry_settings` if it exists
DROP TABLE IF EXISTS `controlled_vocab_entry_settings`;

-- Create the table `controlled_vocab_entry_settings`
CREATE TABLE IF NOT EXISTS `controlled_vocab_entry_settings` (
  `controlled_vocab_entry_setting_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `controlled_vocab_entry_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  `setting_type` varchar(6) NOT NULL,
  PRIMARY KEY (`controlled_vocab_entry_setting_id`),
  UNIQUE KEY `c_v_e_s_pkey` (`controlled_vocab_entry_id`, `locale`, `setting_name`),
  KEY `c_v_e_s_entry_id` (`controlled_vocab_entry_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COMMENT='More data about a controlled vocabulary entry, including localized properties such as the actual word or phrase.';

-- Drop the table `custom_issue_orders` if it exists
DROP TABLE IF EXISTS `custom_issue_orders`;

-- Create the table `custom_issue_orders`
CREATE TABLE IF NOT EXISTS `custom_issue_orders` (
  `custom_issue_order_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `issue_id` bigint NOT NULL,
  `journal_id` bigint NOT NULL,
  `seq` double(8,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`custom_issue_order_id`),
  UNIQUE KEY `custom_issue_orders_unique` (`issue_id`),
  KEY `custom_issue_orders_issue_id` (`issue_id`),
  KEY `custom_issue_orders_journal_id` (`journal_id`)
);
-- Drop the table `custom_section_orders` if it exists
DROP TABLE IF EXISTS `custom_section_orders`;

-- Create the table `custom_section_orders`
CREATE TABLE IF NOT EXISTS `custom_section_orders` (
  `custom_section_order_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `issue_id` bigint NOT NULL,
  `section_id` bigint NOT NULL,
  `seq` double(8,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`custom_section_order_id`),
  UNIQUE KEY `custom_section_orders_unique` (`issue_id`, `section_id`),
  KEY `custom_section_orders_issue_id` (`issue_id`),
  KEY `custom_section_orders_section_id` (`section_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COMMENT='Ordering information for sections within issues when issue-specific section ordering is specified.';
DROP TABLE IF EXISTS `contexts`;
CREATE TABLE IF NOT EXISTS `contexts` (
  `context_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `context_name` varchar(255) NOT NULL,
  `description` text,
  -- Adicione aqui os outros campos que deseja incluir na tabela 'contexts'
  PRIMARY KEY (`context_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Tabela de contextos';


-- Drop the table `data_object_tombstones` if it exists
DROP TABLE IF EXISTS `data_object_tombstones`;

-- Create the table `data_object_tombstones`
CREATE TABLE IF NOT EXISTS `data_object_tombstones` (
  `tombstone_id` bigint NOT NULL AUTO_INCREMENT,
  `data_object_id` bigint NOT NULL,
  `date_deleted` datetime NOT NULL,
  `set_spec` varchar(255) NOT NULL,
  `set_name` varchar(255) NOT NULL,
  `oai_identifier` varchar(255) NOT NULL,
  PRIMARY KEY (`tombstone_id`),
  KEY `data_object_tombstones_data_object_id` (`data_object_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COMMENT='Entries for published data that has been removed. Usually used in the OAI endpoint.';

-- Drop the table `data_object_tombstone_oai_set_objects` if it exists
DROP TABLE IF EXISTS `data_object_tombstone_oai_set_objects`;

-- Create the table `data_object_tombstone_oai_set_objects`
CREATE TABLE IF NOT EXISTS `data_object_tombstone_oai_set_objects` (
  `object_id` bigint NOT NULL AUTO_INCREMENT,
  `tombstone_id` bigint NOT NULL,
  `assoc_type` bigint NOT NULL,
  `assoc_id` bigint NOT NULL,
  PRIMARY KEY (`object_id`),
  KEY `data_object_tombstone_oai_set_objects_tombstone_id` (`tombstone_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COMMENT='Relationships between tombstones and other data that can be collected in OAI sets, e.g. sections.';

-- Drop the table `data_object_tombstone_settings` if it exists
DROP TABLE IF EXISTS `data_object_tombstone_settings`;

-- Create the table `data_object_tombstone_settings`
CREATE TABLE IF NOT EXISTS `data_object_tombstone_settings` (
  `tombstone_setting_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tombstone_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  `setting_type` varchar(6) NOT NULL COMMENT '(bool|int|float|string|object)',
  PRIMARY KEY (`tombstone_setting_id`),
  UNIQUE KEY `data_object_tombstone_settings_unique` (`tombstone_id`, `locale`, `setting_name`),
  KEY `data_object_tombstone_settings_tombstone_id` (`tombstone_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COMMENT='More data about data object tombstones, including localized content.';

-- Drop the table `dois` if it exists
DROP TABLE IF EXISTS `dois`;

-- Create the table `dois`
CREATE TABLE IF NOT EXISTS `dois` (
  `doi_id` bigint NOT NULL AUTO_INCREMENT,
  `context_id` bigint NOT NULL,
  `doi` varchar(255) NOT NULL,
  `status` smallint NOT NULL DEFAULT '1',
  PRIMARY KEY (`doi_id`),
  KEY `dois_context_id` (`context_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COMMENT='Stores all DOIs used in the system.';

-- Drop the table `doi_settings` if it exists
DROP TABLE IF EXISTS `doi_settings`;

-- Create the table `doi_settings`
CREATE TABLE IF NOT EXISTS `doi_settings` (
  `doi_setting_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `doi_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  PRIMARY KEY (`doi_setting_id`),
  UNIQUE KEY `doi_settings_unique` (`doi_id`, `locale`, `setting_name`),
  KEY `doi_settings_doi_id` (`doi_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COMMENT='More data about DOIs, including the registration agency.';

-- Drop the table `edit_decisions` if it exists
DROP TABLE IF EXISTS `edit_decisions`;

-- Create the table `edit_decisions`
CREATE TABLE IF NOT EXISTS `edit_decisions` (
  `edit_decision_id` bigint NOT NULL AUTO_INCREMENT,
  `submission_id` bigint NOT NULL,
  `review_round_id` bigint DEFAULT NULL,
  `stage_id` bigint DEFAULT NULL,
  `round` smallint DEFAULT NULL,
  `editor_id` bigint NOT NULL,
  `decision` smallint NOT NULL,
  `date_decided` datetime NOT NULL,
  PRIMARY KEY (`edit_decision_id`),
  KEY `edit_decisions_submission_id` (`submission_id`),
  KEY `edit_decisions_editor_id` (`editor_id`),
  KEY `edit_decisions_review_round_id` (`review_round_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COMMENT='Editorial decisions recorded on a submission, such as decisions to accept or decline the submission, as well as decisions to send for review, send to copyediting, request revisions, and more.';

-- Drop the table `email_log` if it exists
DROP TABLE IF EXISTS `email_log`;

-- Create the table `email_log`
CREATE TABLE IF NOT EXISTS `email_log` (
  `log_id` bigint NOT NULL AUTO_INCREMENT,
  `assoc_type` bigint NOT NULL,
  `assoc_id` bigint NOT NULL,
  `sender_id` bigint NOT NULL,
  `date_sent` datetime NOT NULL,
  `event_type` bigint DEFAULT NULL,
  `from_address` varchar(255) DEFAULT NULL,
  `recipients` text,
  `cc_recipients` text,
  `bcc_recipients` text,
  `subject` varchar(255) DEFAULT NULL,
  `body` text,
  PRIMARY KEY (`log_id`),
  KEY `email_log_assoc` (`assoc_type`, `assoc_id`)
);
-- Drop the table `email_log_users` if it exists
DROP TABLE IF EXISTS `email_log_users`;

-- Create the table `email_log_users`
CREATE TABLE IF NOT EXISTS `email_log_users` (
  `email_log_user_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `email_log_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`email_log_user_id`),
  UNIQUE KEY `email_log_user_id` (`email_log_id`, `user_id`),
  KEY `email_log_users_email_log_id` (`email_log_id`),
  KEY `email_log_users_user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COMMENT='A record of users associated with an email log entry.';

-- Drop the table `email_templates` if it exists
DROP TABLE IF EXISTS `email_templates`;

-- Create the table `email_templates`
CREATE TABLE IF NOT EXISTS `email_templates` (
  `email_id` bigint NOT NULL AUTO_INCREMENT,
  `email_key` varchar(255) NOT NULL COMMENT 'Unique identifier for this email.',
  `context_id` bigint NOT NULL,
  `alternate_to` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`email_id`),
  UNIQUE KEY `email_templates_email_key` (`email_key`, `context_id`),
  KEY `email_templates_context_id` (`context_id`),
  KEY `email_templates_alternate_to` (`alternate_to`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COMMENT='Custom email templates created by each context, and overrides of the default templates.';

-- Drop the table `email_templates_default_data` if it exists
DROP TABLE IF EXISTS `email_templates_default_data`;

-- Create the table `email_templates_default_data`
CREATE TABLE IF NOT EXISTS `email_templates_default_data` (
  `email_templates_default_data_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `email_key` varchar(255) NOT NULL COMMENT 'Unique identifier for this email.',
  `locale` varchar(14) NOT NULL DEFAULT 'en',
  `name` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `body` text,
  PRIMARY KEY (`email_templates_default_data_id`),
  UNIQUE KEY `email_templates_default_data_unique` (`email_key`, `locale`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COMMENT='Default email templates created for every installed locale.';

-- Drop the table `email_templates_settings` if it exists
DROP TABLE IF EXISTS `email_templates_settings`;

-- Create the table `email_templates_settings`
CREATE TABLE IF NOT EXISTS `email_templates_settings` (
  `email_template_setting_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `email_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  PRIMARY KEY (`email_template_setting_id`),
  UNIQUE KEY `email_templates_settings_unique` (`email_id`, `locale`, `setting_name`),
  KEY `email_templates_settings_email_id` (`email_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COMMENT='More data about custom email templates, including localized properties such as the subject and body.';

-- Drop the table `event_log` if it exists
DROP TABLE IF EXISTS `event_log`;

-- Create the table `event_log`
CREATE TABLE IF NOT EXISTS `event_log` (
  `log_id` bigint NOT NULL AUTO_INCREMENT,
  `assoc_type` bigint NOT NULL,
  `assoc_id` bigint NOT NULL,
  `user_id` bigint DEFAULT NULL COMMENT 'NULL if it''s system or automated event',
  `date_logged` datetime NOT NULL,
  `event_type` bigint DEFAULT NULL,
  `message` text,
  `is_translated` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  KEY `event_log_user_id` (`user_id`),
  KEY `event_log_assoc` (`assoc_type`, `assoc_id`)
);

-- Drop the table `event_log_settings` if it exists
DROP TABLE IF EXISTS `event_log_settings`;

-- Create the table `event_log_settings`
-- Drop table if exists `event_log_settings`
DROP TABLE IF EXISTS `event_log_settings`;

-- Drop table if exists `event_log_settings`
DROP TABLE IF EXISTS `event_log_settings`;

CREATE TABLE IF NOT EXISTS `event_log_settings` (
  `event_log_setting_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `log_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  PRIMARY KEY (`event_log_setting_id`),
  UNIQUE KEY `event_log_settings_unique` (`log_id`, `setting_name`, `locale`),
  KEY `event_log_settings_log_id` (`log_id`),
  KEY `event_log_settings_name_value` (`setting_name`(191), `setting_value`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Settings for event log.';



-- Drop the table `failed_jobs` if it exists
DROP TABLE IF EXISTS `failed_jobs`;

-- Create the table `failed_jobs`
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);

-- Drop the table `files` if it exists
DROP TABLE IF EXISTS `files`;

-- Create the table `files`
CREATE TABLE IF NOT EXISTS `files` (
  `file_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `path` varchar(255) NOT NULL,
  `mimetype` varchar(255) NOT NULL,
  PRIMARY KEY (`file_id`)
);

-- Drop the table `genres` if it exists
DROP TABLE IF EXISTS `genres`;

-- Create the table `genres`
CREATE TABLE IF NOT EXISTS `genres` (
  `genre_id` bigint NOT NULL AUTO_INCREMENT,
  `context_id` bigint NOT NULL,
  `seq` bigint NOT NULL,
  `enabled` smallint NOT NULL DEFAULT '1',
  `category` bigint NOT NULL DEFAULT '1',
  `dependent` smallint NOT NULL DEFAULT '0',
  `supplementary` smallint NOT NULL DEFAULT '0',
  `required` smallint NOT NULL DEFAULT '0' COMMENT 'Whether or not at least one file of this genre is required for a new submission.',
  `entry_key` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`genre_id`),
  KEY `genres_context_id` (`context_id`)
);

-- Drop the table `genre_settings` if it exists
DROP TABLE IF EXISTS `genre_settings`;

-- Create the table `genre_settings`
-- Drop table if exists `genre_settings`
DROP TABLE IF EXISTS `genre_settings`;

CREATE TABLE IF NOT EXISTS `genre_settings` (
  `genre_setting_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `genre_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(191) NOT NULL, -- Reduced length to fit within the limit
  `setting_value` mediumtext,
  `setting_type` varchar(6) NOT NULL COMMENT '(bool|int|float|string|object)',
  PRIMARY KEY (`genre_setting_id`),
  UNIQUE KEY `genre_settings_unique` (`genre_id`, `locale`, `setting_name`),
  KEY `genre_settings_genre_id` (`genre_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Settings for genre.';

-- Drop the table `institutional_subscriptions` if it exists
DROP TABLE IF EXISTS `institutional_subscriptions`;

-- Create the table `institutional_subscriptions`
-- Drop table if exists `institutional_subscriptions`
DROP TABLE IF EXISTS `institutional_subscriptions`;

CREATE TABLE IF NOT EXISTS `institutional_subscriptions` (
  `institutional_subscription_id` bigint NOT NULL AUTO_INCREMENT,
  `subscription_id` bigint NOT NULL,
  `institution_id` bigint NOT NULL,
  `mailing_address` varchar(255) DEFAULT NULL,
  `domain` varchar(191) DEFAULT NULL, -- Reduced length to fit within the limit
  PRIMARY KEY (`institutional_subscription_id`),
  KEY `institutional_subscriptions_subscription_id` (`subscription_id`),
  KEY `institutional_subscriptions_institution_id` (`institution_id`),
  KEY `institutional_subscriptions_domain` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Institutional Subscriptions.';

CREATE TABLE IF NOT EXISTS `user_groups` (
  `user_group_id` bigint NOT NULL AUTO_INCREMENT,
  `context_id` bigint NOT NULL,
  `role_id` bigint NOT NULL,
  `is_default` smallint NOT NULL DEFAULT '0',
  `show_title` smallint NOT NULL DEFAULT '1',
  `permit_self_registration` smallint NOT NULL DEFAULT '0',
  `permit_metadata_edit` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_group_id`),
  KEY `user_groups_user_group_id` (`user_group_id`),
  KEY `user_groups_context_id` (`context_id`),
  KEY `user_groups_role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='All defined user roles in a context, such as Author, Reviewer, Section Editor, and Journal Manager.';

CREATE TABLE IF NOT EXISTS `stages` (
  `stage_id` bigint NOT NULL AUTO_INCREMENT,
  -- colunas da tabela stages
  PRIMARY KEY (`stage_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Table to store stages.';
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` bigint NOT NULL AUTO_INCREMENT,
  -- colunas da tabela users
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='All registered users, including authentication data and profile data.';

CREATE TABLE IF NOT EXISTS `controlled_vocab_entry` (
  `controlled_vocab_entry_id` bigint NOT NULL AUTO_INCREMENT,
  -- colunas da tabela controlled_vocab_entry
  PRIMARY KEY (`controlled_vocab_entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Table for controlled vocabulary entries.';
 
-- Drop table if exists `user_group_stage`
DROP TABLE IF EXISTS `user_group_stage`;
CREATE TABLE IF NOT EXISTS `user_group_stage` (
  `user_group_stage_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `context_id` bigint UNSIGNED NOT NULL,
  `user_group_id` bigint NOT NULL,
  `stage_id` bigint NOT NULL,
  PRIMARY KEY (`user_group_stage_id`),
  UNIQUE KEY `user_group_stage_unique` (`context_id`,`user_group_id`,`stage_id`),
  KEY `user_group_stage_context_id` (`context_id`),
  KEY `user_group_stage_user_group_id` (`user_group_id`),
  KEY `user_group_stage_stage_id` (`stage_id`),
  CONSTRAINT `fk_user_group_stage_contexts` FOREIGN KEY (`context_id`) REFERENCES `contexts` (`context_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_group_stage_user_groups` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`user_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_group_stage_stages` FOREIGN KEY (`stage_id`) REFERENCES `stages` (`stage_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Quais estágios do fluxo de trabalho editorial os user_groups podem acessar.';

CREATE TABLE IF NOT EXISTS `user_groups` (
  `user_group_id` bigint NOT NULL AUTO_INCREMENT,
  `context_id` bigint NOT NULL,
  `role_id` bigint NOT NULL,
  `is_default` smallint NOT NULL DEFAULT '0',
  `show_title` smallint NOT NULL DEFAULT '1',
  `permit_self_registration` smallint NOT NULL DEFAULT '0',
  `permit_metadata_edit` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_group_id`),
  KEY `user_groups_user_group_id` (`user_group_id`),
  KEY `user_groups_context_id` (`context_id`),
  KEY `user_groups_role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='All defined user roles in a context, such as Author, Reviewer, Section Editor, and Journal Manager.';




-- --------------------------------------------------------

-- Structure of table `user_interests`
--

DROP TABLE IF EXISTS `user_interests`;
CREATE TABLE IF NOT EXISTS `user_interests` (
  `user_interest_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `controlled_vocab_entry_id` bigint NOT NULL,
  PRIMARY KEY (`user_interest_id`),
  UNIQUE KEY `user_interests_unique` (`user_id`,`controlled_vocab_entry_id`),
  KEY `user_interests_user_id` (`user_id`),
  KEY `user_interests_controlled_vocab_entry_id` (`controlled_vocab_entry_id`),
  CONSTRAINT `fk_user_interests_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_interests_controlled_vocab_entry` FOREIGN KEY (`controlled_vocab_entry_id`) REFERENCES `controlled_vocab_entry` (`controlled_vocab_entry_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Associates users with user interests (which are stored in the controlled vocabulary tables).';

-- --------------------------------------------------------

-- Structure of table `user_settings`
--

DROP TABLE IF EXISTS `user_settings`;
CREATE TABLE IF NOT EXISTS `user_settings` (
  `user_setting_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  PRIMARY KEY (`user_setting_id`),
  UNIQUE KEY `user_settings_unique` (`user_id`,`locale`,`setting_name`),
  KEY `user_settings_user_id` (`user_id`),
  KEY `user_settings_locale_setting_name_index` (`setting_name`,`locale`),
  CONSTRAINT `fk_user_settings_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='More data about users, including localized properties like their name and affiliation.';

-- --------------------------------------------------------

-- Structure of table `user_user_groups`
--

DROP TABLE IF EXISTS `user_user_groups`;
CREATE TABLE IF NOT EXISTS `user_user_groups` (
  `user_user_group_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_group_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`user_user_group_id`),
  UNIQUE KEY `user_user_groups_unique` (`user_group_id`,`user_id`),
  KEY `user_user_groups_user_group_id` (`user_group_id`),
  KEY `user_user_groups_user_id` (`user_id`),
  CONSTRAINT `fk_user_user_groups_user_groups` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`user_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_user_groups_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Maps users to their assigned user_groups.';

-- --------------------------------------------------------

-- Structure of table `versions`
--

DROP TABLE IF EXISTS `versions`;
CREATE TABLE IF NOT EXISTS `versions` (
  `version_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `major` int NOT NULL DEFAULT '0' COMMENT 'Major component of version number, e.g. the 2 in OJS 2.3.8-0',
  `minor` int NOT NULL DEFAULT '0' COMMENT 'Minor component of version number, e.g. the 3 in OJS 2.3.8-0',
  `revision` int NOT NULL DEFAULT '0' COMMENT 'Revision component of version number, e.g. the 8 in OJS 2.3.8-0',
  `build` int NOT NULL DEFAULT '0' COMMENT 'Build component of version number, e.g. the 0 in OJS 2.3.8-0',
  `date_installed` datetime NOT NULL,
  `current` smallint NOT NULL DEFAULT '0' COMMENT '1 iff the version entry being described is currently active. This permits the table to store past installation history for forensic purposes.',
  `product_type` varchar(30) DEFAULT NULL COMMENT 'Describes the type of product this row describes, e.g. "plugins.generic" (for a generic plugin) or "core" for the application itself',
  `product` varchar(30) DEFAULT NULL COMMENT 'Uniquely identifies the product this version row describes, e.g. "ojs2" for OJS 2.x, "languageToggle" for the language toggle block plugin, etc.',
  `product_class_name` varchar(80) DEFAULT NULL COMMENT 'Specifies the class name associated with this product, for plugins, or the empty string where not applicable.',
  `lazy_load` smallint NOT NULL DEFAULT '0' COMMENT '1 iff the row describes a lazy-load plugin; 0 otherwise',
  `sitewide` smallint NOT NULL DEFAULT '0' COMMENT '1 iff the row describes a site-wide plugin; 0 otherwise',
  PRIMARY KEY (`version_id`),
  UNIQUE KEY `versions_unique` (`product_type`,`product`,`major`,`minor`,`revision`,`build`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Describes the installation and upgrade version history for the application and all installed plugins.';
COMMIT;