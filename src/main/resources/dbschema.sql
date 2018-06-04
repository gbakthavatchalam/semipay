-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;

USE `SemiPay`;

DROP TABLE IF EXISTS `Transaction`;


DROP TABLE IF EXISTS `Booking`;


DROP TABLE IF EXISTS `CurrentPrice`;


DROP TABLE IF EXISTS `PriceHistory`;


DROP TABLE IF EXISTS `Kiosk`;


DROP TABLE IF EXISTS `Station`;


DROP TABLE IF EXISTS `UPI`;


DROP TABLE IF EXISTS `Product`;


DROP TABLE IF EXISTS `UserRoleMap`;


DROP TABLE IF EXISTS `UserGroupMap`;


DROP TABLE IF EXISTS `Plan`;


DROP TABLE IF EXISTS `Vendor`;


DROP TABLE IF EXISTS `Group`;


DROP TABLE IF EXISTS `Role`;


DROP TABLE IF EXISTS `GroupRoleMap`;

DROP TABLE IF EXISTS `User`;



-- ************************************** `Plan`

CREATE TABLE `Plan`
(
 `id`             INT NOT NULL AUTO_INCREMENT,
 `name`           VARCHAR(20) NOT NULL ,
 `is_active`      BIT NOT NULL ,
 `validity`       INT NOT NULL ,
 `max_quantity`   FLOAT NOT NULL ,
 `is_top_allowed` BIT NOT NULL ,

PRIMARY KEY (`id`)
);





-- ************************************** `Vendor`

CREATE TABLE `Vendor`
(
 `id`        INT NOT NULL AUTO_INCREMENT,
 `name`      VARCHAR(45) NOT NULL ,
 `is_active` BIT NOT NULL ,

PRIMARY KEY (`id`)
);





-- ************************************** `Group`

CREATE TABLE `Group`
(
 `id`        INT NOT NULL AUTO_INCREMENT,
 `name`      VARCHAR(45) NOT NULL ,
 `is_active` BIT NOT NULL ,

PRIMARY KEY (`id`)
);





-- ************************************** `Role`

CREATE TABLE `Role`
(
 `id`        INT NOT NULL AUTO_INCREMENT,
 `name`      VARCHAR(45) NOT NULL ,
 `is_active` BIT NOT NULL ,

PRIMARY KEY (`id`)
);





-- ************************************** `GroupRoleMap`

CREATE TABLE `GroupRoleMap`
(
 `role_id`        INT NOT NULL ,
 `group_id`       INT NOT NULL ,

PRIMARY KEY (`role_id`, `group_id`)
);




-- ************************************** `User`

CREATE TABLE `User`
(
 `username`  VARCHAR(50) NOT NULL ,
 `mobileno`  BIGINT NOT NULL ,
 `email`     VARCHAR(45) NOT NULL ,
 `is_active` BIT NOT NULL ,
 `is_subscribed` BIT NOT NULL, 

PRIMARY KEY (`username`)
);





-- ************************************** `Station`

CREATE TABLE `Station`
(
 `id`          BIGINT NOT NULL AUTO_INCREMENT,
 `layout`      JSON NOT NULL ,
 `lat`         FLOAT NOT NULL ,
 `long`        FLOAT NOT NULL ,
 `address1`    VARCHAR(200) NOT NULL ,
 `address2`    VARCHAR(200) NOT NULL ,
 `city`        VARCHAR(100) NOT NULL ,
 `state`       VARCHAR(100) NOT NULL ,
 `postcode`    VARCHAR(10) NOT NULL ,
 `country`     VARCHAR(50) NOT NULL ,
 `vendor_id`   INT NOT NULL ,
 `merchant_id` VARCHAR(50) NOT NULL ,

PRIMARY KEY (`id`),
KEY `fkIdx_103` (`vendor_id`),
CONSTRAINT `FK_103` FOREIGN KEY `fkIdx_103` (`vendor_id`) REFERENCES `Vendor` (`id`),
KEY `fkIdx_107` (`merchant_id`),
CONSTRAINT `FK_107` FOREIGN KEY `fkIdx_107` (`merchant_id`) REFERENCES `User` (`username`)
);





-- ************************************** `UPI`

CREATE TABLE `UPI`
(
 `vpa_id`    VARCHAR(100) NOT NULL ,
 `is_active` BIT NOT NULL ,
 `username`  VARCHAR(50) NOT NULL ,

PRIMARY KEY (`vpa_id`, `username`),
KEY `fkIdx_84` (`username`),
CONSTRAINT `FK_84` FOREIGN KEY `fkIdx_84` (`username`) REFERENCES `User` (`username`)
);





-- ************************************** `Product`

CREATE TABLE `Product`
(
 `id`        VARCHAR(15) NOT NULL ,
 `type`      VARCHAR(10) NOT NULL ,
 `category`  VARCHAR(20) NOT NULL ,
 `vendor_id` INT NOT NULL ,
 `is_active` BIT NOT NULL ,

PRIMARY KEY (`id`),
KEY `fkIdx_73` (`vendor_id`),
CONSTRAINT `FK_73` FOREIGN KEY `fkIdx_73` (`vendor_id`) REFERENCES `Vendor` (`id`)
);





-- ************************************** `UserRoleMap`

CREATE TABLE `UserRoleMap`
(
 `username` VARCHAR(50) NOT NULL ,
 `role_id`  INT NOT NULL ,

PRIMARY KEY (`username`, `role_id`),
KEY `fkIdx_55` (`username`),
CONSTRAINT `FK_55` FOREIGN KEY `fkIdx_55` (`username`) REFERENCES `User` (`username`),
KEY `fkIdx_59` (`role_id`),
CONSTRAINT `FK_59` FOREIGN KEY `fkIdx_59` (`role_id`) REFERENCES `Role` (`id`)
);


-- ************************************** `UserGroupMap`

CREATE TABLE `UserGroupMap`
(
 `username` VARCHAR(50) NOT NULL ,
 `group_id`  INT NOT NULL ,

PRIMARY KEY (`username`, `group_id` ),
KEY `fkIdx_56` (`username`),
CONSTRAINT `FK_56` FOREIGN KEY `fkIdx_55` (`username`) REFERENCES `User` (`username`),
KEY `fkIdx_60` (`group_id`),
CONSTRAINT `FK_60` FOREIGN KEY `fkIdx_59` (`group_id`) REFERENCES `Group` (`id`)
);



-- ************************************** `Booking`

CREATE TABLE `Booking`
(
 `booking_price` FLOAT NOT NULL ,
 `booking_date`  DATETIME NOT NULL ,
 `expiry_date`   DATETIME NOT NULL ,
 `avl_limit`     FLOAT NOT NULL ,
 `is_active`     BIT NOT NULL ,
 `plan_id`       INT NOT NULL ,
 `user_id`       VARCHAR(50) NOT NULL ,
 `product_id`    VARCHAR(15) NOT NULL ,

KEY `fkIdx_169` (`plan_id`),
CONSTRAINT `FK_169` FOREIGN KEY `fkIdx_169` (`plan_id`) REFERENCES `Plan` (`id`),
KEY `fkIdx_173` (`user_id`),
CONSTRAINT `FK_173` FOREIGN KEY `fkIdx_173` (`user_id`) REFERENCES `User` (`username`),
KEY `fkIdx_177` (`product_id`),
CONSTRAINT `FK_177` FOREIGN KEY `fkIdx_177` (`product_id`) REFERENCES `Product` (`id`)
);





-- ************************************** `CurrentPrice`

CREATE TABLE `CurrentPrice`
(
 `station_id` BIGINT NOT NULL ,
 `product_id` VARCHAR(15) NOT NULL ,
 `price`      FLOAT NOT NULL ,

PRIMARY KEY (`station_id`, `product_id`),
KEY `fkIdx_144` (`station_id`),
CONSTRAINT `FK_144` FOREIGN KEY `fkIdx_144` (`station_id`) REFERENCES `Station` (`id`),
KEY `fkIdx_148` (`product_id`),
CONSTRAINT `FK_148` FOREIGN KEY `fkIdx_148` (`product_id`) REFERENCES `Product` (`id`)
);





-- ************************************** `PriceHistory`

CREATE TABLE `PriceHistory`
(
 `station_id` BIGINT NOT NULL ,
 `product_id` VARCHAR(15) NOT NULL ,
 `price`      FLOAT NOT NULL ,
 `date`       DATE NOT NULL ,

KEY `fkIdx_132` (`station_id`),
CONSTRAINT `FK_132` FOREIGN KEY `fkIdx_132` (`station_id`) REFERENCES `Station` (`id`),
KEY `fkIdx_136` (`product_id`),
CONSTRAINT `FK_136` FOREIGN KEY `fkIdx_136` (`product_id`) REFERENCES `Product` (`id`)
);





-- ************************************** `Kiosk`

CREATE TABLE `Kiosk`
(
 `id`         BIGINT NOT NULL AUTO_INCREMENT,
 `product_id` VARCHAR(15) NOT NULL ,
 `station_id` BIGINT NOT NULL ,
 `worker_id`  VARCHAR(50) NOT NULL ,

PRIMARY KEY (`id`),
KEY `fkIdx_115` (`product_id`),
CONSTRAINT `FK_115` FOREIGN KEY `fkIdx_115` (`product_id`) REFERENCES `Product` (`id`),
KEY `fkIdx_119` (`station_id`),
CONSTRAINT `FK_119` FOREIGN KEY `fkIdx_119` (`station_id`) REFERENCES `Station` (`id`),
KEY `fkIdx_123` (`worker_id`),
CONSTRAINT `FK_123` FOREIGN KEY `fkIdx_123` (`worker_id`) REFERENCES `User` (`username`)
);





-- ************************************** `Transaction`

CREATE TABLE `Transaction`
(
 `id`         VARCHAR(200) NOT NULL ,
 `quantity`   FLOAT NOT NULL ,
 `date`       DATETIME NOT NULL ,
 `tap`        FLOAT NOT NULL ,
 `cep`        FLOAT NOT NULL ,
 `status`     VARCHAR(20) NOT NULL ,
 `vpa_id`     VARCHAR(100) NOT NULL ,
 `station_id` BIGINT NOT NULL ,
 `kiosk_id`   BIGINT NOT NULL ,
 `product_id` VARCHAR(15) NOT NULL ,
 `user_id`    VARCHAR(50) NOT NULL ,

PRIMARY KEY (`id`),
KEY `fkIdx_190` (`vpa_id`),
CONSTRAINT `FK_190` FOREIGN KEY `fkIdx_190` (`vpa_id`) REFERENCES `UPI` (`vpa_id`),
KEY `fkIdx_199` (`station_id`),
CONSTRAINT `FK_199` FOREIGN KEY `fkIdx_199` (`station_id`) REFERENCES `Station` (`id`),
KEY `fkIdx_203` (`kiosk_id`),
CONSTRAINT `FK_203` FOREIGN KEY `fkIdx_203` (`kiosk_id`) REFERENCES `Kiosk` (`id`),
KEY `fkIdx_207` (`product_id`),
CONSTRAINT `FK_207` FOREIGN KEY `fkIdx_207` (`product_id`) REFERENCES `Product` (`id`),
KEY `fkIdx_211` (`user_id`),
CONSTRAINT `FK_211` FOREIGN KEY `fkIdx_211` (`user_id`) REFERENCES `User` (`username`)
);




-- ********************************** Vendor Data

INSERT INTO Vendor (`name`, `is_active`)  VALUES ("BP", 1);
INSERT INTO Vendor (`name`, `is_active`)  VALUES ("HP", 1);
INSERT INTO Vendor (`name`, `is_active`)  VALUES ("IndianOil", 1);
INSERT INTO Vendor (`name`, `is_active`)  VALUES ("Reliance", 1);
INSERT INTO Vendor (`name`, `is_active`)  VALUES ("Essar", 1);


-- ********************************** Product Data

INSERT INTO Product (`id`, `type`, `category`, `vendor_id`, `is_active`) VALUES ("C1PLBP", "Petrol", "NM", 1, 1);
INSERT INTO Product (`id`, `type`, `category`, `vendor_id`, `is_active`) VALUES ("C2PLBP", "Petrol", "Speed", 1, 1);
INSERT INTO Product (`id`, `type`, `category`, `vendor_id`, `is_active`) VALUES ("C1DLBP", "Diesel", "NM", 1, 1);
INSERT INTO Product (`id`, `type`, `category`, `vendor_id`, `is_active`) VALUES ("C2DLBP", "Diesel", "Speed", 1, 1);

INSERT INTO Product (`id`, `type`, `category`, `vendor_id`, `is_active`) VALUES ("C1PLHP", "Petrol", "NM", 2, 1);
INSERT INTO Product (`id`, `type`, `category`, `vendor_id`, `is_active`) VALUES ("C2PLHP", "Petrol", "Power", 2, 1);
INSERT INTO Product (`id`, `type`, `category`, `vendor_id`, `is_active`) VALUES ("C1DLHP", "Diesel", "NM", 2, 1);
INSERT INTO Product (`id`, `type`, `category`, `vendor_id`, `is_active`) VALUES ("C2DLHP", "Diesel", "TurboJet", 2, 1);

INSERT INTO Product (`id`, `type`, `category`, `vendor_id`, `is_active`) VALUES ("C1PLIO", "Petrol", "NM", 3, 1);
INSERT INTO Product (`id`, `type`, `category`, `vendor_id`, `is_active`) VALUES ("C2PLIO", "Petrol", "XtraPremium", 3, 1);
INSERT INTO Product (`id`, `type`, `category`, `vendor_id`, `is_active`) VALUES ("C1DLIO", "Diesel", "NM", 3, 1);
INSERT INTO Product (`id`, `type`, `category`, `vendor_id`, `is_active`) VALUES ("C2DLIO", "Diesel", "XtraMile", 3, 1);
