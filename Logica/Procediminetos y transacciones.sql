CREATE DATABASE bolsa;
use bolsa;

CREATE TABLE user (
	id integer PRIMARY KEY AUTO_INCREMENT NOT NULL,
	name varchar(50),
	las_name varchar(50),
	email varchar(100),
	password varchar(100),
	cell int,
	fec datetime
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE categoria (
	id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
	name varchar(50),
	logo varchar(150)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE empresa (
	id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
	id_categoria int,

	name varchar(50),
	email varchar(100),
	address varchar(50),
	phone varchar(30),
	cell int,
	photo varchar(150),
	detail text,

	FOREIGN KEY (id_categoria) REFERENCES categoria(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE trabajo (
	id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
	id_empresa int,
	name varchar(50),
	detail text,
	salary float,
	fec datetime,
	fec_in datetime,
	fec_lim datetime,

	FOREIGN KEY (id_empresa) REFERENCES empresa(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE departamento (
	id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
	name varchar(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE sucursal (
	id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
	id_empresa int,
	id_departamento int,

	name varchar(50),
	address varchar(50),
	phone varchar(30),
	cell int,

	FOREIGN KEY (id_empresa) REFERENCES empresa(id),
	FOREIGN KEY (id_departamento) REFERENCES departamento(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;






delimiter //
DROP PROCEDURE IF EXISTS pSession;
CREATE PROCEDURE pSession(
	IN v_email varchar(100),
	IN v_pwd varchar(100)
)
BEGIN
	DECLARE us int(11);
	SET us = (SELECT id FROM user WHERE email LIKE v_email);
	IF(us) THEN
		IF EXISTS(SELECT id FROM user WHERE id = us AND password LIKE v_pwd) THEN
			SELECT id,'success' error FROM user WHERE id = us;
		ELSE
			SELECT 'Error: Contraseña incorrecta.' error;
		END IF;
	ELSE
		SELECT 'Error: Correo no registrado.' error;
	END IF;
END //

--PROCEDIMIENTO PARA INSERTAR A LA TABLA USER
DROP PROCEDURE IF EXISTS pInsertUser;
CREATE PROCEDURE pInsertUser (
	IN v_name varchar(50),
	IN v_las_name varchar(50),
	IN v_email varchar(100),
	IN v_password varchar(100),
	IN v_cell int
)
BEGIN
	IF NOT EXISTS(SELECT id FROM user WHERE email LIKE v_email) THEN
		INSERT INTO user VALUES(null,v_name,v_las_name,v_email,v_password,v_cell,CURRENT_TIMESTAMP);
		SELECT @@identity AS id, 'success' error;
	ELSE
		SELECT 'Error: Correo ya registrado.' error;
	END IF;
END //

--PROCEDIMIENTO PARA INSERTAR A LA TABLA CATEGORIA
DROP PROCEDURE IF EXISTS pInsertCategoria;
CREATE PROCEDURE pInsertCategoria (
	IN v_name varchar(50),
	IN v_logo varchar(150)
)
BEGIN
	IF NOT EXISTS(SELECT id FROM categoria WHERE name LIKE v_name) THEN
		INSERT INTO categoria VALUES(null,v_name,v_logo);
		SELECT @@identity AS id, 'success' error;
	ELSE
		SELECT 'Error: Nombre ya registrado.' error;
	END IF;
END //


--PROCEDIMIENTO PARA INSERTAR A LA TABLA EMPRESA
DROP PROCEDURE IF EXISTS pInsertEmpresa;
CREATE PROCEDURE pInsertEmpresa (
	IN v_id_categoria int,
	IN v_name varchar(50),
	IN v_email varchar(100),
	IN v_address varchar(50),
	IN v_phone varchar(30),
	IN v_cell int,
	IN v_photo varchar(150),
	IN v_detail text
)
BEGIN
	IF NOT EXISTS(SELECT id FROM empresa WHERE name LIKE v_name) THEN
		INSERT INTO empresa VALUES(null, v_id_categoria, v_name, v_email, v_address, v_phone, v_cell, v_photo, v_detail);
		SELECT @@identity AS id, 'success' error;
	ELSE
		SELECT 'Error: Nombre de empresa ya registrado.' error;
	END IF;
END //

--PROCEDIMIENTO PARA INSERTAR A LA TABLA TRABAJO
DROP PROCEDURE IF EXISTS pInsertTrabajo;
CREATE PROCEDURE pInsertTrabajo (
	IN v_id_empresa int,
	IN v_name varchar(50),
	IN v_detail text,
	IN v_salary float,
	IN v_fec_in datetime,
	IN v_fec_lim datetime
)
BEGIN
	INSERT INTO trabajo VALUES(null, v_id_empresa, v_name, v_detail, v_salary, v_fec_in, v_fec_lim);
	SELECT @@identity AS id, 'success' error;
END //


--PROCEDIMIENTO PARA INSERTAR A LA TABLA DEPARTAMENTO
DROP PROCEDURE IF EXISTS pInsertDepartamento;
CREATE PROCEDURE pInsertDepartamento (
	IN v_name varchar(100)
)
BEGIN
	INSERT INTO departamento VALUES(null, v_name);
	SELECT @@identity AS id, 'success' error;
END //


--PROCEDIMIENTO PARA INSERTAR A LA TABLA SUCURSAL
DROP PROCEDURE IF EXISTS pInsertSucursal;
CREATE PROCEDURE pInsertSucursal (
	IN v_id_empresa int,
	IN v_id_departamento int,
	IN v_name varchar(50),
	IN v_address varchar(50),
	IN v_phone varchar(30),
	IN v_cell int
)
BEGIN
	INSERT INTO sucursal VALUES(null, v_id_empresa, v_id_departamento, v_name, v_address, v_phone, v_cell);
	SELECT @@identity AS id, 'success' error;
END //




-- DROP PROCEDURE IF EXISTS pInsertEmpleado;
-- CREATE PROCEDURE pInsertEmpleado (
-- 	IN v_ci varchar(15),
-- 	IN v_foto varchar(30),
-- 	IN v_nombre varchar(50),
-- 	IN v_apellido varchar(50),
-- 	IN v_telefono varchar(15),
-- 	IN v_celular int,
-- 	IN v_direccion varchar(50)
-- )
-- BEGIN
-- 	IF NOT EXISTS(SELECT id FROM categoria WHERE ci LIKE v_ci) THEN
-- 		INSERT INTO categoria VALUES(null,v_ci,v_foto,v_nombre,v_apellido,v_telefono,v_celular,v_direccion);
-- 		SELECT @@identity AS id, '' error;
-- 	ELSE
-- 		SELECT 'Error: CI ya registrado.' error;
-- 	END IF;
-- END //


-- DROP PROCEDURE IF EXISTS pInsertEmpleador;
-- CREATE PROCEDURE pInsertEmpleador (
-- 	IN v_foto varchar(30),
-- 	IN v_nombre varchar(50),
-- 	IN v_apellido varchar(50),
-- 	IN v_empresa varchar(60),
-- 	IN v_correo varchar(100),
-- 	IN v_contra varchar(100),
-- 	IN v_telefono varchar(15),
-- 	IN v_celular int
-- )
-- BEGIN
-- 	IF NOT EXISTS(SELECT id FROM empleador WHERE correo LIKE v_correo) THEN
-- 		INSERT INTO empleador VALUES(null,v_foto,v_nombre,v_apellido,v_empresa,v_correo,v_contra,v_telefono,v_celular);
-- 		SELECT @@identity AS id, 'Usuario creado exitosamente :)' error;
-- 	ELSE
-- 		SELECT 'Error: Correo ya registrado.' error;
-- 	END IF;
-- END //


-- DROP PROCEDURE IF EXISTS pInsertDepartamento;
-- CREATE PROCEDURE pInsertDepartamento (
-- 	IN v_nombre varchar(50)
-- )
-- BEGIN
-- 	IF NOT EXISTS(SELECT id FROM departamento WHERE nombre LIKE v_nombre) THEN
-- 		INSERT INTO departamento VALUES(null,v_nombre);
-- 		SELECT @@identity AS id, '' error;
-- 	ELSE
-- 		SELECT 'Error: Nombre ya registrado.' error;
-- 	END IF;
-- END //


-- DROP PROCEDURE IF EXISTS pInsertMensaje;
-- CREATE PROCEDURE pInsertMensaje (
-- 	IN v_id_empleador int,
-- 	IN v_correo varchar(30),
-- 	IN v_mensaje text
-- )
-- BEGIN
-- 	INSERT INTO categoria VALUES(null,v_id_empleador,v_correo,v_mensaje,CURRENT_TIMESTAMP);
-- 	SELECT @@identity AS id, '' error;
-- END //


-- DROP PROCEDURE IF EXISTS pInsertNotificaciones;
-- CREATE PROCEDURE pInsertNotificaciones (
-- 	IN v_id_categoria int,
-- 	IN v_id_empleado int
-- )
-- BEGIN
-- 	INSERT INTO notificaciones VALUES(null,v_id_categoria,v_id_empleado,CURRENT_TIMESTAMP);
-- 	SELECT @@identity AS id, '' error;
-- END //


-- DROP PROCEDURE IF EXISTS pInsertOferta;
-- CREATE PROCEDURE pInsertOferta (
-- 	IN v_id_categoria int,
-- 	IN v_id_empleado int,
-- 	IN v_id_empleador int,
-- 	IN v_id_departamento int,
-- 	IN v_detalle text,
-- 	IN v_direccion varchar(50),
-- 	IN v_latitud varchar(150),
-- 	IN v_longitud varchar(150)
-- )
-- BEGIN
-- 	INSERT INTO departamento VALUES(null,v_id_categoria,v_id_empleado,v_id_empleador,v_id_departamento,v_detalle,v_direccion,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,v_latitud,v_longitud);
-- 	SELECT @@identity AS id, '' error;
-- END //