/* EJERCICIO GRUPAL  M3AE05ABPRO
	/Nicolae Villegas
    /Fabiana Vega
    /Jesús Torres
    /Cristian Díaz
*/

-- DESARROLLO
-- Parte 1: Crear entorno de trabajo
-- Crear una base de datos
CREATE DATABASE telovendo;
use telovendo;

-- Crear un usuario con todos los privilegios para trabajar con la base de datos recién creada.
CREATE USER 'admintelovendo'@'localhost' IDENTIFIED BY '123';
GRANT ALL PRIVILEGES ON telovendo.* TO 'admintelovendo'@'localhost';

-- Parte 2: Crear dos tablas.
/* La primera almacena a los usuarios de la aplicación
 (id_usuario, nombre, apellido, contraseña, zona horaria (por defecto UTC-3), género y teléfono de contacto). */
 
 CREATE TABLE usuarios (
	id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    contraseña VARCHAR(10) NOT NULL,
    zona_horaria VARCHAR(5) DEFAULT 'UTC-3',
    genero ENUM ('M','F','O'),
    telefono_contacto VARCHAR(30) NOT NULL
);
 
/* La segunda tabla almacena información relacionada a la fecha-hora de ingreso de los usuarios a la plataforma
(id_ingreso, id_usuario y la fecha-hora de ingreso (por defecto lafecha-hora actual)). */

CREATE TABLE ingresos (
	id_ingreso INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fyh_ingreso TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/* Parte 3: Modificación de la tabla
- Modifique el UTC por defecto.Desde UTC-3 a UTC-2. */
ALTER TABLE usuarios MODIFY COLUMN zona_horaria VARCHAR(50) DEFAULT 'UTC-2';
DESCRIBE usuarios;

/* Parte 4: Creación de registros.
- Para cada tabla crea 8 registros. */

-- Insert tabla usuarios
INSERT INTO usuarios(nombre, apellido, contraseña, genero, telefono_contacto) VALUES
('NombreUsuario 1', 'ApellidoUsuario 1','1111111111', 1,'+56911111111'),
('NombreUsuario 2', 'ApellidoUsuario 2','2222222222', 2,'+56911111111'),
('NombreUsuario 3', 'ApellidoUsuario 3','3333333333', 3,'+56911111111'),
('NombreUsuario 4', 'ApellidoUsuario 4','4444444444', 1,'+56911111111'),
('NombreUsuario 5', 'ApellidoUsuario 5','5555555555', 2,'+56911111111'),
('NombreUsuario 6', 'ApellidoUsuario 6','6666666666', 3,'+56911111111'),
('NombreUsuario 7', 'ApellidoUsuario 7','7777777777', 1,'+56911111111'),
('NombreUsuario 8', 'ApellidoUsuario 8','8888888888', 2,'+56911111111');
-- Verifica la inserción
SELECT * FROM usuarios;

-- Insert tabla ingresos
INSERT INTO ingresos(id_usuario) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8);
-- Verifica la inserción
SELECT * FROM ingresos;

/* Parte 5: Justifique cada tipo de dato utilizado. ¿Es el óptimo en cada caso? 
Tabla "usuarios"
	campo id_usuario INT AUTO_INCREMENT PRIMARY KEY
    Para un campo "código" el tipo numérico es la mejor opción ya que las BBDD realcionales son mas eficientes
    en el manejo de este tipo de datos. Que sea AUTO_INCREMENT permite asegurar que los usuarios sean únicos.
    
    nombre VARCHAR(30) NOT NULL
    apellido VARCHAR(30) NOT NULL
    contraseña VARCHAR(10) NOT NULL
    zona_horaria VARCHAR(5) DEFAULT 'UTC-3'
    telefono_contacto VARCHAR(30) NOT NULL
    En estos campos alfanuméricos la mejor opción son del tipo VARCHAR ya que su contenido tiene largo variable y
    es tolerante a las letras mayúsculas y minúsculas.
    Los límites asignados son los suficientemente largos y NOT NULL nos aseguran que los registros contengan la información.
    En el caso de "zona_horaria" se le asignó el valor por defecto 'UTC-3' según el requerimiento.
    
    genero ENUM ('M','F','O')
    Para asignara el género concordamos que esta información solo necesita una letra representativa y no la palabra completa.
    La clausala ENUM nos permite darle las alternativas necesarias a los usuarios y tiene la flexibilidad de poder agregar
    mas enunciados a la lista. Además esto ahora espacio en el almacenamiento.

Tabla "ingresos"
	id_ingreso INT AUTO_INCREMENT PRIMARY KEY
    Explicación identica a usuarios.id_usuarios
    
    id_usuario INT NOT NULL,
    Explicación identica a usuarios.id_usuarios aunque en este caso no es necesario asignarlo como llave primaria.
    
    fyh_ingreso TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    La clausula TIMESTAMP nos permite asiganr un tipo de dato idóneo para manejar fechas y horas juntas.
    La clausula DEFAULT CURRENT_TIMESTAMP nos permite asignar por defecto la fecha y hora actual al momento
    de la inserción de nuevos registros.
*/
 
/* Parte 6: Creen una nueva tabla llamada Contactos
(id_contacto, id_usuario, numero de telefono, correo electronico). */

CREATE TABLE contactos (
	id_contacto INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    numero_telefono VARCHAR(30) NOT NULL,
    correo_electronico VARCHAR(255) NOT NULL
);

-- Parte 7: Modifique la columna teléfono de contacto, para crear un vínculo entre la tabla Usuarios y la tabla Contactos.
/* El requerimiento de esta parte está mal redactado o incompleto. ¿cual sería la tabla principal y secundaria?
No se puede vicular la tabla usuarios y contactos solo modificando el campo usuarios.telefono_contacto porque no es la clave primaria.
Para crear un vínculo entre las 2 tablas se modificará la llave primaria de la tabla usuarios para cnvertirla en una llave primaria compuesta.ALTER */

-- 1 Eliminamos el AUTOINCREMENT
ALTER TABLE usuarios MODIFY id_usuario INT NOT NULL;
-- 2 Eliminamos la actual clave primaria
ALTER TABLE usuarios DROP PRIMARY KEY;
-- 3 Creamos una nueva Primary key incluyendo a usuarios.telefono_contacto
ALTER TABLE usuarios ADD PRIMARY KEY (id_usuario,telefono_contacto);
-- 4 Agregamos el AUTOINCREMENT
ALTER TABLE usuarios MODIFY id_usuario INT AUTO_INCREMENT;
-- Verificamos las modificaciones
DESCRIBE usuarios;

-- Ahora creamos el vínculo entre contactos y usuarios
ALTER TABLE contactos ADD FOREIGN KEY (id_usuario,numero_telefono) REFERENCES usuarios (id_usuario,telefono_contacto);
-- Verificamos las modificaciones
DESCRIBE contactos;

-- Link de github https://github.com/cada-github/trgrp_grupo2

