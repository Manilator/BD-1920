-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,
NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema FNAC
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema FNAC
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `FNAC` ;
USE `FNAC` ;

-- -----------------------------------------------------
-- Table `FNAC`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FNAC`.`Cliente` (
  `id_cliente` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `data_subscricao` DATE NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telemovel` VARCHAR(45) NOT NULL,
  `distrito` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FNAC`.`Compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FNAC`.`Compra` (
  `id_compra` INT NOT NULL,
  `montante` DECIMAL(6,2) NOT NULL,
  `loja` VARCHAR(45) NOT NULL,
  `data_hora` DATETIME NOT NULL,
  `id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_compra`),
  INDEX `fk_Compra_Cliente_idx` (`id_cliente` ASC),
  CONSTRAINT `fk_Compra_Cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `FNAC`.`Cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FNAC`.`Artigo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FNAC`.`Artigo` (
  `id_artigo` INT NOT NULL COMMENT 'Aplicável a todos',
  `titulo` VARCHAR(100) NOT NULL COMMENT 'Aplicável a todos',
  `tipo` VARCHAR(10) NOT NULL,
  `preco` DECIMAL(4,2) NOT NULL COMMENT 'Aplicável a todos',
  `ano` INT NOT NULL COMMENT 'Aplicável a todos',
  `classificacao` INT NOT NULL COMMENT 'Classificação de 1-10\nAplicável a todos',
  PRIMARY KEY (`id_artigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FNAC`.`Stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FNAC`.`Stock` (
  `id_artigo` INT NOT NULL,
  `loja` VARCHAR(45) NOT NULL,
  `qtd_disponivel` INT NOT NULL,
  `distrito` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`id_artigo`, `loja`),
  CONSTRAINT `fk_Stock_Artigo1`
    FOREIGN KEY (`id_artigo`)
    REFERENCES `FNAC`.`Artigo` (`id_artigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FNAC`.`Compra_de_X_Artigos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FNAC`.`Compra_de_X_Artigos` (
  `id_compra` INT NOT NULL,
  `id_artigo` INT NOT NULL,
  `quantidade` INT NOT NULL,
  INDEX `fk_Compra_has_Artigo_Artigo1_idx` (`id_artigo` ASC),
  INDEX `fk_Compra_has_Artigo_Compra1_idx` (`id_compra` ASC),
  CONSTRAINT `fk_Compra_has_Artigo_Compra1`
    FOREIGN KEY (`id_compra`)
    REFERENCES `FNAC`.`Compra` (`id_compra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Compra_has_Artigo_Artigo1`
    FOREIGN KEY (`id_artigo`)
    REFERENCES `FNAC`.`Artigo` (`id_artigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FNAC`.`Filme`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FNAC`.`Filme` (
  `id_artigo` INT NOT NULL,
  `duracao` INT NOT NULL COMMENT 'Duração de um filme em minutos',
  `realizador` VARCHAR(45) NOT NULL COMMENT 'Falta mostrar atores\nAplicável ao Filme',
  `genero` VARCHAR(25) NOT NULL COMMENT 'Género - aplicável ao livro, filme, ou jogo.',
  PRIMARY KEY (`id_artigo`),
  CONSTRAINT `fk_Filme_Artigo1`
    FOREIGN KEY (`id_artigo`)
    REFERENCES `FNAC`.`Artigo` (`id_artigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FNAC`.`Musica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FNAC`.`Musica` (
  `id_artigo` INT NOT NULL,
  `genero_musical` VARCHAR(25) NOT NULL COMMENT 'Género - Musica',
  `artista` VARCHAR(45) NOT NULL COMMENT 'Artista - Musica',
  `formato` VARCHAR(25) NOT NULL COMMENT 'CD\nVinil\n...\nAplicável à Música',
  PRIMARY KEY (`id_artigo`),
  CONSTRAINT `fk_Musica_Artigo1`
    FOREIGN KEY (`id_artigo`)
    REFERENCES `FNAC`.`Artigo` (`id_artigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FNAC`.`Jogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FNAC`.`Jogo` (
  `id_artigo` INT NOT NULL,
  `plataforma` VARCHAR(15) NOT NULL COMMENT 'PC\nPS4\nXBOX\n...\nAplicável ao Jogo',
  `idade_min` INT NOT NULL COMMENT 'Idade mínima permitida\nAplicável a Jogo e Filme',
  `publisher` VARCHAR(45) NOT NULL COMMENT 'Aplicável ao Jogo',
  `n_jogadores_max` INT NOT NULL COMMENT 'Aplicável ao Jogo',
  `genero` VARCHAR(45) NOT NULL COMMENT 'Género - aplicável ao livro, filme, ou jogo.',
  PRIMARY KEY (`id_artigo`),
  CONSTRAINT `fk_Jogo_Artigo1`
    FOREIGN KEY (`id_artigo`)
    REFERENCES `FNAC`.`Artigo` (`id_artigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FNAC`.`Livro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FNAC`.`Livro` (
  `id_artigo` INT NOT NULL,
  `autor` VARCHAR(45) NOT NULL COMMENT 'Autor do livro',
  `genero` VARCHAR(25) NOT NULL COMMENT 'Género - aplicável ao livro, filme, ou jogo.',
  `editora` VARCHAR(45) NOT NULL COMMENT 'Editora do livro',
  `n_paginas` INT NOT NULL COMMENT 'Nº de páginas do livro',
  PRIMARY KEY (`id_artigo`),
  CONSTRAINT `fk_Livro_Artigo1`
    FOREIGN KEY (`id_artigo`)
    REFERENCES `FNAC`.`Artigo` (`id_artigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
