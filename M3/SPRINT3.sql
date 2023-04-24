/* SPRINT MUDULO 3 BASE DE DATOS
NICOLAE VILLEGAS
FABIANA VEGA
JESUS TORRES
CRISTIAN DIAZ
*/

/* a continuación se insertan sentencias SQL para la creación de la base de datos "telovendo"
Script generados a partir del diagrama "dgtelovendo" */

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema telovendo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema telovendo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `telovendo` DEFAULT CHARACTER SET utf8 ;
USE `telovendo` ;

-- -----------------------------------------------------
-- Table `telovendo`.`proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telovendo`.`proveedores` (
  `idproveedor` INT NOT NULL AUTO_INCREMENT,
  `nombre_corporativo` VARCHAR(50) NOT NULL,
  `nombre_representante` VARCHAR(50) NOT NULL,
  `categoria` VARCHAR(50) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `telefono_fijo` VARCHAR(45) NOT NULL,
  `telefono_movil` VARCHAR(45) NOT NULL,
  `contacto` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idproveedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `telovendo`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telovendo`.`clientes` (
  `idcliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(25) NOT NULL,
  `apellido` VARCHAR(25) NOT NULL,
  `direccion` VARCHAR(50) NULL,
  PRIMARY KEY (`idcliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `telovendo`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telovendo`.`productos` (
  `idproducto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  `categoria` VARCHAR(50) NOT NULL,
  `color` VARCHAR(20) NULL,
  `stock` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idproducto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `telovendo`.`proveedoresProductos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telovendo`.`proveedoresProductos` (
  `idproveedorProducto` INT NOT NULL AUTO_INCREMENT,
  `idproveedor` INT NULL,
  `idproducto` INT NULL,
  PRIMARY KEY (`idproveedorProducto`),
  INDEX `idproveedor_idx` (`idproveedor` ASC) VISIBLE,
  INDEX `idproducto_idx` (`idproducto` ASC) VISIBLE,
  CONSTRAINT `idproveedor`
    FOREIGN KEY (`idproveedor`)
    REFERENCES `telovendo`.`proveedores` (`idproveedor`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `idproducto`
    FOREIGN KEY (`idproducto`)
    REFERENCES `telovendo`.`productos` (`idproducto`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Fin SCRIPT  del diagrama "dgtelovendo"

-- Deben crear un usuario con privilegios para crear, eliminar y modificar tablas, insertar registros.
CREATE USER 'admintelovendo'@'localhost' IDENTIFIED BY '123';
GRANT ALL PRIVILEGES ON telovendo.* TO 'admintelovendo'@'localhost';

-- Agregue 5 proveedores a la base de datos.
INSERT INTO proveedores(nombre_corporativo, nombre_representante, categoria, email, telefono_fijo,telefono_movil,contacto) VALUES
('proveedor 1', 'representante 1','electronica', 'email1@proveedor1.com','+56211111111','+56911111111','contacto 1'),
('proveedor 2', 'representante 2','electronica', 'email2@proveedor2.com','+56222222222','+56922222222','contacto 2'),
('proveedor 3', 'representante 3','electronica', 'email3@proveedor3.com','+56233333333','+56933333333','contacto 3'),
('proveedor 4', 'representante 4','luminarias', 'email4@proveedor4.com','+56244444444','+56944444444','contacto 4'),
('proveedor 5', 'representante 5','electricidad', 'email5@proveedor5.com','+56255555555','+56955555555','contacto 5');

  /*TeLoVendo tiene actualmente muchos clientes, pero nos piden que ingresemos solo 5 para probar la
nueva base de datos. Cada cliente tiene un nombre, apellido, dirección (solo pueden ingresar una).*/
INSERT INTO clientes(nombre, apellido, direccion) VALUES
('monbre_cliente 1', 'apellido_cliente 1','direccion 1'),
('monbre_cliente 2', 'apellido_cliente 2','direccion 2'),
('monbre_cliente 3', 'apellido_cliente 3','direccion 3'),
('monbre_cliente 4', 'apellido_cliente 4','direccion 4'),
('monbre_cliente 5', 'apellido_cliente 5','direccion 5');

/* TeLoVendo tiene diferentes productos. Ingrese 10 productos y su respectivo stock. Cada producto tiene
información sobre su precio, su categoría, proveedor y color. Los productos pueden tener muchos
proveedores*/

INSERT INTO productos(nombre, precio, categoria,color,stock) VALUES
('producto 1',100000.00,'electronica','AZUL',1000),
('producto 2',200000.00,'electronica','NEGRO',1200),
('producto 3',300000.00,'electronica','VERDE',1300),
('producto 4',400000.00,'electronica','NEGRO',1400),
('producto 5',500000.00,'luminarias','NEGRO',1500),
('producto 6',600000.00,'luminarias','AZUL',1600),
('producto 7',700000.00,'luminarias','AZUL',1700),
('producto 8',800000.00,'electricidad','CAFE',1800),
('producto 9',900000.00,'electricidad','CAFE',1900),
('producto 10',100100.00,'electricidad','CAFE',1001);

-- Se insertan registros de proveedor-productos
INSERT INTO proveedoresproductos (idProveedor, idProducto) VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(1,3),
(1,5),
(2,4);

-- Exploración de la base de datos "telovendo"
  
-- Cuál es la categoría de productos que más se repite.
SELECT categoria, count(idproducto) AS CANTIDAD FROM productos GROUP BY categoria ORDER BY CANTIDAD DESC;
-- La categoría que mas se repite es la "electronica"

-- Cuáles son los productos con mayor stock
SELECT * FROM productos ORDER BY stock DESC;
-- Los productos con mas stock son 'producto 9' y 'producto 8'

-- Qué color de producto es más común en nuestra tienda.
SELECT color, count(idproducto) as cantidad FROM productos GROUP BY color ORDER BY cantidad DESC;
-- Los Colores mas comunes son el CAFE, AZUL Y NEGRO

-- Cual o cuales son los proveedores con menor stock de productos.
SELECT pv.nombre_corporativo as PROVEEDOR, SUM(stock) as STOCK 
FROM proveedores as pv INNER JOIN proveedoresproductos as pp
ON pv.idproveedor=pp.idproveedor INNER JOIN productos pr
ON pp.idproducto=pr.idproducto
GROUP BY PROVEEDOR
ORDER BY STOCK;
-- El Proveedor con menor stock es proveedor 3 con 1300 unidades

-- Por último: Cambien la categoría de productos más popular por ‘Electrónica y computación’.
UPDATE productos SET categoria='Electrónica y computación' WHERE categoria='electronica';
select * from productos;