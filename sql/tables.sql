CREATE SCHEMA `goodbank` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

use `goodbank`;

#***********************************************************
#*
#* Table manager ranges
#*
#***********************************************************
CREATE TABLE `manager_ranges` (
	`range_id` INT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
	`title` varchar(50) NOT NULL,
	PRIMARY KEY(`range_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


#***********************************************************
#*
#* Table client ranges
#*
#***********************************************************

CREATE TABLE `client_ranges` (
	`range_id` INT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
	`title` varchar(50) NOT NULL,
	PRIMARY KEY(`range_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


#***********************************************************
#*
#* Table communities
#*
#***********************************************************

CREATE TABLE `communities` (
	`community_id` INT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
	`community` varchar(100) NOT NULL,
	PRIMARY KEY(`community_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


#***********************************************************
#*
#* Table provinces
#*
#***********************************************************

CREATE TABLE `provinces` (
	`province_id` INT(6) UNSIGNED NOT NULL AUTO_INCREMENT,
	`province` VARCHAR(50) NOT NULL,
	PRIMARY KEY(`province_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


#***********************************************************
#*
#* Table street types
#*
#***********************************************************

CREATE TABLE `street_types` (
	`type_id` INT(6) UNSIGNED NOT NULL AUTO_INCREMENT,
	`type` VARCHAR(50) NOT NULL,
	PRIMARY KEY(`type_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


#***********************************************************
#*
#* Table account types
#*
#***********************************************************

CREATE TABLE `account_types` (
	`type_id` INT(6) UNSIGNED NOT NULL AUTO_INCREMENT,
	`type` VARCHAR(50) NOT NULL,
	PRIMARY KEY(`type_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


#***********************************************************
#*
#* Table managers
#*
#***********************************************************

CREATE TABLE `managers`(
	`manager_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
	`id_card` VARCHAR(9) NOT NULL,
	`name` VARCHAR(50) NOT NULL,
	`lastname_first` VARCHAR(50) NOT NULL,
	`lastname_second` VARCHAR(50) NOT NULL,
	`birth_date` DATE NOT NULL,
	`street_type` INT(6) UNSIGNED NOT NULL,
	`address` VARCHAR(150) NOT NULL,
	`province` INT(6) UNSIGNED NOT NULL,
	`community` INT(4) UNSIGNED NOT NULL,
	`phone_number` BIGINT(11) UNSIGNED NOT NULL,
	`manager_range` INT(4) UNSIGNED NOT NULL,
	`password` VARCHAR(128) NOT NULL,
	PRIMARY KEY(`manager_id`)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


#***********************************************************
#*
#* Constraints for managers
#*
#***********************************************************

ALTER TABLE `managers` 
ADD INDEX `managers_external_street_idx` (`street_type` ASC),
ADD INDEX `managers_external_province_idx` (`province` ASC),
ADD INDEX `managers_external_community_idx` (`community` ASC),
ADD INDEX `managers_external_range_idx` (`manager_range` ASC);
ALTER TABLE `managers` 
ADD CONSTRAINT `manager_external_street`
	FOREIGN KEY (`street_type`)
	REFERENCES `street_types` (`type_id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
ADD CONSTRAINT `manager_external_province`
	FOREIGN KEY (`province`)
	REFERENCES `provinces` (`province_id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
ADD CONSTRAINT `manager_external_community`
	FOREIGN KEY (`community`)
	REFERENCES `communities` (`community_id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
ADD CONSTRAINT `manager_external_range`
	FOREIGN KEY (`manager_range`)
	REFERENCES `manager_ranges` (`range_id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE;


#***********************************************************
#*
#* Table clients
#*
#***********************************************************

CREATE TABLE `clients`(
	`client_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
	`id_card` VARCHAR(9) NOT NULL,
	`name` VARCHAR(50) NOT NULL,
	`lastname_first` VARCHAR(50) NOT NULL,
	`lastname_second` VARCHAR(50) NOT NULL,
	`birth_date` DATE NOT NULL,
	`street_type` INT(6) UNSIGNED NOT NULL,
	`address` VARCHAR(150) NOT NULL,
	`province` INT(6) UNSIGNED NOT NULL,
	`community` INT(4) UNSIGNED NOT NULL,
	`phone_number` BIGINT(11) UNSIGNED NOT NULL,
	`client_range` INT(4) UNSIGNED NOT NULL,
	`password` VARCHAR(128) NOT NULL,
	PRIMARY KEY(`client_id`)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


#***********************************************************
#*
#* Constraints for clients
#*
#***********************************************************

ALTER TABLE `clients` 
ADD INDEX `clients_external_street_idx` (`street_type` ASC),
ADD INDEX `clients_external_province_idx` (`province` ASC),
ADD INDEX `clients_external_community_idx` (`community` ASC),
ADD INDEX `clients_external_range_idx` (`client_range` ASC);
ALTER TABLE `clients` 
ADD CONSTRAINT `clients_external_street`
	FOREIGN KEY (`street_type`)
	REFERENCES `street_types` (`type_id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
ADD CONSTRAINT `clients_external_province`
	FOREIGN KEY (`province`)
	REFERENCES `provinces` (`province_id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
ADD CONSTRAINT `clients_external_community`
	FOREIGN KEY (`community`)
	REFERENCES `communities` (`community_id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
ADD CONSTRAINT `clients_external_range`
	FOREIGN KEY (`client_range`)
	REFERENCES `client_ranges` (`range_id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE;


#***********************************************************
#*
#* Table branches
#*
#***********************************************************

CREATE TABLE `branches`(
	`branch_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
	`branch_code` INT(4) UNSIGNED NOT NULL,
	`street_type` INT(6) UNSIGNED NOT NULL,
	`address` VARCHAR(150) NOT NULL,
	`province` INT(6) UNSIGNED NOT NULL,
	`community` INT(4) UNSIGNED NOT NULL,
	`phone_number` BIGINT(11) UNSIGNED NOT NULL,
	`manager` BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY(`branch_id`)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


#***********************************************************
#*
#* Constraints for branches
#*
#***********************************************************

ALTER TABLE `branches` 
ADD INDEX `branches_external_street_idx` (`street_type` ASC),
ADD INDEX `branches_external_province_idx` (`province` ASC),
ADD INDEX `branches_external_community_idx` (`community` ASC),
ADD INDEX `branches_external_manager_idx` (`manager` ASC);
ALTER TABLE `branches` 
ADD CONSTRAINT `branches_external_street`
	FOREIGN KEY (`street_type`)
	REFERENCES `street_types` (`type_id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
ADD CONSTRAINT `branches_external_province`
	FOREIGN KEY (`province`)
	REFERENCES `provinces` (`province_id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
ADD CONSTRAINT `branches_external_community`
	FOREIGN KEY (`community`)
	REFERENCES `communities` (`community_id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
ADD CONSTRAINT `branches_external_manager`
	FOREIGN KEY (`manager`)
	REFERENCES `managers` (`manager_id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE;


#***********************************************************
#*
#* Table accounts
#*
#***********************************************************

CREATE TABLE `accounts`(
	`account_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
	`account_number` BIGINT(10) UNSIGNED NOT NULL,
	`branch` BIGINT UNSIGNED NOT NULL,
	`creation_date` DATE NOT NULL,
	`account_type` INT(6) UNSIGNED NOT NULL,
	`client_id` BIGINT UNSIGNED NOT NULL,
	`second_client_id` BIGINT UNSIGNED DEFAULT NULL,
	`third_client_id` BIGINT UNSIGNED DEFAULT NULL,
	`amount` DECIMAL(65,10) NOT NULL DEFAULT 0.0000000000,
	PRIMARY KEY(`account_id`)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


#***********************************************************
#*
#* Constraints for branches
#*
#***********************************************************

ALTER TABLE `accounts` 
ADD INDEX `accounts_external_branch_idx` (`branch` ASC),
ADD INDEX `accounts_external_account_type_idx` (`account_type` ASC),
ADD INDEX `accounts_external_client_idx` (`client_id` ASC),
ADD INDEX `accounts_external_secondary_client_idx` (`second_client_id` ASC),
ADD INDEX `accounts_external_tertiary_idx` (`third_client_id` ASC);
ALTER TABLE `accounts` 
ADD CONSTRAINT `accounts_external_branch`
	FOREIGN KEY (`branch`)
	REFERENCES `branches` (`branch_id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
ADD CONSTRAINT `accounts_external_account_type`
	FOREIGN KEY (`account_type`)
	REFERENCES `account_types` (`type_id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
ADD CONSTRAINT `accounts_external_client`
	FOREIGN KEY (`client_id`)
	REFERENCES `clients` (`client_id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
ADD CONSTRAINT `accounts_external_secondary_client`
	FOREIGN KEY (`second_client_id`)
	REFERENCES `clients` (`client_id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
ADD CONSTRAINT `accounts_external_tertiary`
	FOREIGN KEY (`third_client_id`)
	REFERENCES `clients` (`client_id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE;


#***********************************************************
#*
#* Table transactions
#*
#***********************************************************

CREATE TABLE `transactions`(
	`transaction_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
	`account` BIGINT UNSIGNED NOT NULL,
	`transaction_date` DATETIME NOT NULL,
	`amount` DECIMAL(65,10) NOT NULL DEFAULT 0.0000000000,
	`applicant` VARCHAR(150) NOT NULL,
	`concept` VARCHAR(150) DEFAULT NULL,
	PRIMARY KEY(`transaction_id`)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


#***********************************************************
#*
#* Constraints for transactions
#*
#***********************************************************

ALTER TABLE `transactions` 
ADD INDEX `transactions_external_account_idx` (`account` ASC);
ALTER TABLE `transactions` 
ADD CONSTRAINT `accounts_external_account`
	FOREIGN KEY (`account`)
	REFERENCES `accounts` (`account_id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE;
