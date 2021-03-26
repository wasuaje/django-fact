SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `factura` DEFAULT CHARACTER SET latin1 ;
USE `factura` ;


-- -----------------------------------------------------
-- Table `factura`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `factura`.`categoria` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(250) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = MyISAM
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `factura`.`articulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `factura`.`articulo` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(250) NULL DEFAULT NULL,
  `codigo` VARCHAR(6) NULL,
  `importe` VARCHAR(45) NULL,
  `descuento` VARCHAR(45) NULL,
  `itemcol` VARCHAR(45) NULL,
  `categoria_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_item_item_grupo1_idx` (`categoria_id` ASC),
  CONSTRAINT `fk_item_item_grupo1`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `factura`.`categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = latin1;



-- -----------------------------------------------------
-- Table `factura`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `factura`.`proveedor` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(200) NULL DEFAULT NULL,
  `razon_social` VARCHAR(200) NULL DEFAULT NULL,
  `direccion` VARCHAR(500) NULL DEFAULT NULL,
  `rif` VARCHAR(15) NULL DEFAULT NULL,
  `nit` VARCHAR(15) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `tlf` VARCHAR(45) NULL DEFAULT NULL,
  `fax` VARCHAR(45) NULL DEFAULT NULL,
  `ruta_foto` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;



-- -----------------------------------------------------
-- Table `factura`.`vehiculo_marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `factura`.`vehiculo_marca` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = MyISAM
AUTO_INCREMENT = 140
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `factura`.`vehiculo_modelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `factura`.`vehiculo_modelo` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `vehiculo_marca_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_vehiculo_modelo_vehiculo_marca1_idx` (`vehiculo_marca_id` ASC))
ENGINE = MyISAM
AUTO_INCREMENT = 2639
DEFAULT CHARACTER SET = latin1;



-- -----------------------------------------------------
-- Table `factura`.`banco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `factura`.`banco` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 34
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `factura`.`forma_pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `factura`.`forma_pago` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `factura`.`tipo_doc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `factura`.`tipo_doc` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `correlativo` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `factura`.`documento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `factura`.`documento` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `correlativo` INT(11) NULL DEFAULT NULL,
  `fecha` DATE NOT NULL,
  `fecha_vencimiento` DATE NOT NULL,
  `contacto` VARCHAR(45) NULL DEFAULT NULL,
  `nota_superior` VARCHAR(500) NULL DEFAULT NULL,
  `nota_detalle` VARCHAR(500) NULL DEFAULT NULL,
  `referencia` INT(11) NULL DEFAULT NULL,
  `status` TINYINT(4) NULL DEFAULT NULL,
  `tipo_doc_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_documento_tipo_doc1_idx` (`tipo_doc_id` ASC))
ENGINE = MyISAM
AUTO_INCREMENT = 93
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `factura`.`cobros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `factura`.`cobros` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `fecha` DATE NULL DEFAULT NULL,
  `referencia` VARCHAR(45) NULL DEFAULT NULL,
  `monto` FLOAT NULL DEFAULT NULL,
  `descripcion` VARCHAR(45) NULL DEFAULT NULL,
  `status` TINYINT(4) NULL DEFAULT NULL,
  `forma_pago_id` INT(11) NOT NULL,
  `documento_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cobro_det_forma_pago1_idx` (`forma_pago_id` ASC),
  INDEX `fk_cobro_det_documento1_idx` (`documento_id` ASC),
  CONSTRAINT `fk_cobro_det_forma_pago1`
    FOREIGN KEY (`forma_pago_id`)
    REFERENCES `factura`.`forma_pago` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cobro_det_documento1`
    FOREIGN KEY (`documento_id`)
    REFERENCES `factura`.`documento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `factura`.`documento_det`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `factura`.`documento_det` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(200) NULL DEFAULT NULL,
  `cantidad` TINYINT(4) NULL DEFAULT NULL,
  `importe` FLOAT NULL DEFAULT NULL,
  `descuento` FLOAT NULL DEFAULT NULL,
  `total` FLOAT NULL DEFAULT NULL,
  `nota` VARCHAR(45) NULL DEFAULT NULL,
  `documento_id` INT(11) NOT NULL,
  `item_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_documento_det_documento1_idx` (`documento_id` ASC),
  INDEX `fk_documento_det_item1_idx` (`item_id` ASC),
  CONSTRAINT `fk_documento_det_documento1`
    FOREIGN KEY (`documento_id`)
    REFERENCES `factura`.`documento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_documento_det_item1`
    FOREIGN KEY (`item_id`)
    REFERENCES `factura`.`articulo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 359
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `factura`.`pagos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `factura`.`pagos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `fecha` DATE NULL DEFAULT NULL,
  `referencia` VARCHAR(45) NULL DEFAULT NULL,
  `monto` FLOAT NULL DEFAULT NULL,
  `descripcion` VARCHAR(45) NULL DEFAULT NULL,
  `documento_id` INT(11) NOT NULL,
  `forma_pago_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pagos_documento1_idx` (`documento_id` ASC),
  INDEX `fk_pagos_forma_pago1_idx` (`forma_pago_id` ASC),
  CONSTRAINT `fk_pagos_documento1`
    FOREIGN KEY (`documento_id`)
    REFERENCES `factura`.`documento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pagos_forma_pago1`
    FOREIGN KEY (`forma_pago_id`)
    REFERENCES `factura`.`forma_pago` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `factura`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `factura`.`persona` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `cedula` VARCHAR(45) NULL DEFAULT NULL,
  `nombres` VARCHAR(45) NULL DEFAULT NULL,
  `apellidos` VARCHAR(45) NULL DEFAULT NULL,
  `ruta_foto` VARCHAR(500) NULL DEFAULT NULL,
  `sexo` VARCHAR(1) NULL DEFAULT NULL,
  `user` VARCHAR(45) NULL DEFAULT NULL,
  `password` VARCHAR(45) NULL DEFAULT NULL,
  `cf_cargo_id` INT(11) NOT NULL,
  `tlf_hab` VARCHAR(45) NULL DEFAULT NULL,
  `tlf_cel` VARCHAR(45) NULL DEFAULT NULL,
  `direccion` VARCHAR(500) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_mt_persona_cf_cargo1` (`cf_cargo_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `factura`.`vehiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `factura`.`vehiculo` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `placa` VARCHAR(45) NULL DEFAULT NULL,
  `color` VARCHAR(45) NULL DEFAULT NULL,
  `serial_motor` VARCHAR(45) NULL DEFAULT NULL,
  `serial_caja` VARCHAR(45) NULL DEFAULT NULL,
  `serial_carroceria` VARCHAR(45) NULL DEFAULT NULL,
  `nro_ejes` TINYINT(4) NULL DEFAULT NULL,
  `nro_ruedas` TINYINT(4) NULL DEFAULT NULL,
  `kilometraje` INT(11) NULL DEFAULT NULL,
  `ruta_foto` VARCHAR(500) NULL DEFAULT NULL,
  `vehiculo_modelo_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_vehiculo_vehiculo_modelo1_idx` (`vehiculo_modelo_id` ASC),
  CONSTRAINT `fk_vehiculo_vehiculo_modelo1`
    FOREIGN KEY (`vehiculo_modelo_id`)
    REFERENCES `factura`.`vehiculo_modelo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `factura`.`persona_documento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `factura`.`persona_documento` (
  `persona_id` INT(11) NOT NULL,
  `documento_id` INT(11) NOT NULL,
  PRIMARY KEY (`persona_id`, `documento_id`),
  INDEX `fk_persona_has_documento_documento1_idx` (`documento_id` ASC),
  INDEX `fk_persona_has_documento_persona1_idx` (`persona_id` ASC),
  CONSTRAINT `fk_persona_has_documento_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `factura`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_persona_has_documento_documento1`
    FOREIGN KEY (`documento_id`)
    REFERENCES `factura`.`documento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `factura`.`documento_proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `factura`.`documento_proveedor` (
  `documento_id` INT(11) NOT NULL,
  `proveedor_id` INT(11) NOT NULL,
  PRIMARY KEY (`documento_id`, `proveedor_id`),
  INDEX `fk_documento_has_proveedor_proveedor1_idx` (`proveedor_id` ASC),
  INDEX `fk_documento_has_proveedor_documento1_idx` (`documento_id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `factura`.`persona_vehiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `factura`.`persona_vehiculo` (
  `persona_id` INT(11) NOT NULL,
  `vehiculo_id` INT(11) NOT NULL,
  PRIMARY KEY (`persona_id`, `vehiculo_id`),
  INDEX `fk_persona_has_vehiculo_vehiculo1_idx` (`vehiculo_id` ASC),
  INDEX `fk_persona_has_vehiculo_persona1_idx` (`persona_id` ASC),
  CONSTRAINT `fk_persona_has_vehiculo_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `factura`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_persona_has_vehiculo_vehiculo1`
    FOREIGN KEY (`vehiculo_id`)
    REFERENCES `factura`.`vehiculo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `factura`.`pagos_banco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `factura`.`pagos_banco` (
  `pagos_id` INT(11) NOT NULL,
  `banco_id` INT(11) NOT NULL,
  PRIMARY KEY (`pagos_id`, `banco_id`),
  INDEX `fk_pagos_has_banco_banco1_idx` (`banco_id` ASC),
  INDEX `fk_pagos_has_banco_pagos1_idx` (`pagos_id` ASC),
  CONSTRAINT `fk_pagos_has_banco_pagos1`
    FOREIGN KEY (`pagos_id`)
    REFERENCES `factura`.`pagos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pagos_has_banco_banco1`
    FOREIGN KEY (`banco_id`)
    REFERENCES `factura`.`banco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `factura`.`cobros_banco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `factura`.`cobros_banco` (
  `cobros_id` INT(11) NOT NULL,
  `banco_id` INT(11) NOT NULL,
  PRIMARY KEY (`cobros_id`, `banco_id`),
  INDEX `fk_cobros_has_banco_banco1_idx` (`banco_id` ASC),
  INDEX `fk_cobros_has_banco_cobros1_idx` (`cobros_id` ASC),
  CONSTRAINT `fk_cobros_has_banco_cobros1`
    FOREIGN KEY (`cobros_id`)
    REFERENCES `factura`.`cobros` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cobros_has_banco_banco1`
    FOREIGN KEY (`banco_id`)
    REFERENCES `factura`.`banco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `factura`.`inventario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `factura`.`inventario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(1) NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `fecha` DATE NOT NULL,
  `cantidad` BIGINT(20) NULL,
  `articulo_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_inventario_articulo1_idx` (`articulo_id` ASC),
  CONSTRAINT `fk_inventario_articulo1`
    FOREIGN KEY (`articulo_id`)
    REFERENCES `factura`.`articulo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
