-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema BibliotecaEscolar
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema BibliotecaEscolar
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BibliotecaEscolar` DEFAULT CHARACTER SET utf8 ;
USE `BibliotecaEscolar` ;

-- -----------------------------------------------------
-- Table `BibliotecaEscolar`.`bibliotecario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BibliotecaEscolar`.`bibliotecario` ;

CREATE TABLE IF NOT EXISTS `BibliotecaEscolar`.`bibliotecario` (
  `id_bibliotecario` INT NOT NULL,
  `nombre` VARCHAR(70) NOT NULL,
  `rut` VARCHAR(20) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(20) NULL,
  PRIMARY KEY (`id_bibliotecario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BibliotecaEscolar`.`alumno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BibliotecaEscolar`.`alumno` ;

CREATE TABLE IF NOT EXISTS `BibliotecaEscolar`.`alumno` (
  `id_alumno` INT NOT NULL,
  `nombre` VARCHAR(70) NOT NULL,
  `rut` VARCHAR(20) NOT NULL,
  `direccion` VARCHAR(75) NOT NULL,
  `telefono` VARCHAR(10) NOT NULL,
  `correo` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_alumno`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BibliotecaEscolar`.`prestamo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BibliotecaEscolar`.`prestamo` ;

CREATE TABLE IF NOT EXISTS `BibliotecaEscolar`.`prestamo` (
  `id_prestamo` INT NOT NULL,
  `numero_prestamo` VARCHAR(45) NOT NULL,
  `fecha_prestamo` DATETIME NOT NULL,
  `fecha_devolucion` DATETIME NOT NULL,
  `bibliotecario_id_bibliotecario` INT NOT NULL,
  `alumno_id_alumno` INT NOT NULL,
  PRIMARY KEY (`id_prestamo`, `bibliotecario_id_bibliotecario`, `alumno_id_alumno`),
  INDEX `fk_prestamo_bibliotecario_idx` (`bibliotecario_id_bibliotecario` ASC) VISIBLE,
  INDEX `fk_prestamo_alumno1_idx` (`alumno_id_alumno` ASC) VISIBLE,
  CONSTRAINT `fk_prestamo_bibliotecario`
    FOREIGN KEY (`bibliotecario_id_bibliotecario`)
    REFERENCES `BibliotecaEscolar`.`bibliotecario` (`id_bibliotecario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prestamo_alumno1`
    FOREIGN KEY (`alumno_id_alumno`)
    REFERENCES `BibliotecaEscolar`.`alumno` (`id_alumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BibliotecaEscolar`.`libro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BibliotecaEscolar`.`libro` ;

CREATE TABLE IF NOT EXISTS `BibliotecaEscolar`.`libro` (
  `id_libro` INT NOT NULL,
  `isbn` INT(13) NOT NULL,
  `titulo` VARCHAR(75) NOT NULL,
  `autor` VARCHAR(75) NOT NULL,
  `genero` VARCHAR(25) NOT NULL,
  `año` DATETIME NOT NULL,
  PRIMARY KEY (`id_libro`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BibliotecaEscolar`.`libro_has_prestamo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BibliotecaEscolar`.`libro_has_prestamo` ;

CREATE TABLE IF NOT EXISTS `BibliotecaEscolar`.`libro_has_prestamo` (
  `libro_id_libro` INT NOT NULL,
  `prestamo_id_prestamo` INT NOT NULL,
  `prestamo_bibliotecario_id_bibliotecario` INT NOT NULL,
  `prestamo_alumno_id_alumno` INT NOT NULL,
  PRIMARY KEY (`libro_id_libro`, `prestamo_id_prestamo`, `prestamo_bibliotecario_id_bibliotecario`, `prestamo_alumno_id_alumno`),
  INDEX `fk_libro_has_prestamo_prestamo1_idx` (`prestamo_id_prestamo` ASC, `prestamo_bibliotecario_id_bibliotecario` ASC, `prestamo_alumno_id_alumno` ASC) VISIBLE,
  INDEX `fk_libro_has_prestamo_libro1_idx` (`libro_id_libro` ASC) VISIBLE,
  CONSTRAINT `fk_libro_has_prestamo_libro1`
    FOREIGN KEY (`libro_id_libro`)
    REFERENCES `BibliotecaEscolar`.`libro` (`id_libro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_libro_has_prestamo_prestamo1`
    FOREIGN KEY (`prestamo_id_prestamo` , `prestamo_bibliotecario_id_bibliotecario` , `prestamo_alumno_id_alumno`)
    REFERENCES `BibliotecaEscolar`.`prestamo` (`id_prestamo` , `bibliotecario_id_bibliotecario` , `alumno_id_alumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
