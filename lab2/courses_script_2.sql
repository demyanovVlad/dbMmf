-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema courses
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema courses
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `courses` DEFAULT CHARACTER SET utf8 ;
USE `courses` ;

-- -----------------------------------------------------
-- Table `courses`.`professors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `courses`.`professors` (
  `ID` INT(11) NOT NULL,
  `NAME` VARCHAR(45) NOT NULL,
  `FAM` VARCHAR(45) NOT NULL,
  `PATR` VARCHAR(45) NOT NULL,
  `EXPERIENCE` INT(11) NOT NULL,
  `PHONE_NUM` INT(11) NOT NULL,
  `NUM_OF_SUB` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'The table that describes the information about professors';


-- -----------------------------------------------------
-- Table `courses`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `courses`.`payment` (
  `ID` INT(11) NOT NULL,
  `TYPE` VARCHAR(45) NOT NULL,
  `PER_HOUR` INT(11) NOT NULL COMMENT 'Payment for one subject according to its type',
  `SUBJECT` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `courses`.`capacity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `courses`.`capacity` (
  `ID` INT(11) NOT NULL,
  `GROUP_NUM` INT(11) NOT NULL,
  `HOURS` INT(11) NOT NULL COMMENT 'The number of hours which are devoted for courses by one professor',
  `SUBJECT` VARCHAR(45) NOT NULL,
  `TYPE` VARCHAR(45) NOT NULL COMMENT 'Type of session with students (lecture or practice)',
  `ID_P` INT(11) NOT NULL,
  `ID_PT` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_P_UNIQUE` (`ID` ASC),
  INDEX `fk_capacity_professors1_idx` (`ID_P` ASC),
  INDEX `fk_capacity_payment1_idx` (`ID_PT` ASC),
  CONSTRAINT `fk_capacity_professors1`
    FOREIGN KEY (`ID_P`)
    REFERENCES `courses`.`professors` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_capacity_payment1`
    FOREIGN KEY (`ID_PT`)
    REFERENCES `courses`.`payment` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'This table contains information about the load, so that it can determine which teacher with which groups is involved and how many groups he has in total';


-- -----------------------------------------------------
-- Table `courses`.`groups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `courses`.`groups` (
  `ID` INT(11) NOT NULL,
  `GROUP_NUM` INT(11) NOT NULL,
  `SPECIALITY` VARCHAR(45) NOT NULL,
  `BRANCH` VARCHAR(45) NOT NULL COMMENT 'The departments where students study ',
  `NUM_OF_S` INT(11) NOT NULL COMMENT 'Number of students in each group',
  `ID_P` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  INDEX `fk_groups_professors_idx` (`ID_P` ASC),
  CONSTRAINT `fk_groups_professors`
    FOREIGN KEY (`ID_P`)
    REFERENCES `courses`.`professors` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'The table which describes groups and connects it with its own professors';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
