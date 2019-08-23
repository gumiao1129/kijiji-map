-- 
-- Database: `kijiji_data`
-- 

-- --------------------------------------------------------


SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';




-- -----------------------------------------------------
-- Schema kijiji_data
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS kijiji_data DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
USE kijiji_data ;

CREATE TABLE IF NOT EXISTS kijiji_ads (
  id BIGINT NOT NULL AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  description TEXT NULL,
  date DATE NULL,
  image VARCHAR(255) NULL,
  price VARCHAR(255) NULL,
  latitude FLOAT NULL,
  longitude FLOAT NULL,
  mapAddress VARCHAR(255) NULL,
  province VARCHAR(255) NULL,
  mapRadius VARCHAR(255) NULL,
  attributes TEXT NULL,
  url VARCHAR(255) NOT NULL,
  isDeleted BOOLEAN NOT NULL DEFAULT False,
  PRIMARY KEY (id),
  UNIQUE INDEX (id),
  FULLTEXT KEY (title, description)
) ENGINE=INNODB;
 
CREATE TABLE IF NOT EXISTS kijiji_images (
    id BIGINT NOT NULL AUTO_INCREMENT,
    ad_id BIGINT NOT NULL,
    image_url VARCHAR(255) NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_ads_images
      FOREIGN KEY (ad_id)
      REFERENCES kijiji_ads (id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
) ENGINE = INNODB;
