delimiter //

--PROCEDIMIENTO PARA INSERTAR A LA TABLA CATEGORIA
DROP PROCEDURE IF EXISTS pInsertCategoria;
CREATE PROCEDURE pInsertCategoria (
	IN v_nombre varchar(50),
	IN v_logo varchar(30)
)
BEGIN
	IF NOT EXISTS(SELECT id FROM categoria WHERE nombre LIKE v_nombre) THEN
		INSERT INTO categoria VALUES(null,v_nombre,v_logo);
		SELECT @@identity AS id, '' error;
	ELSE
		SELECT 'Error: Nombre ya registrado.' error;
	END IF;
END //


DROP PROCEDURE IF EXISTS pInsertEmpleado;
CREATE PROCEDURE pInsertEmpleado (
	IN v_ci varchar(15),
	IN v_foto varchar(30),
	IN v_nombre varchar(50),
	IN v_apellido varchar(50),
	IN v_telefono varchar(15),
	IN v_celular int,
	IN v_direccion varchar(50)
)
BEGIN
	IF NOT EXISTS(SELECT id FROM categoria WHERE ci LIKE v_ci) THEN
		INSERT INTO categoria VALUES(null,v_ci,v_foto,v_nombre,v_apellido,v_telefono,v_celular,v_direccion);
		SELECT @@identity AS id, '' error;
	ELSE
		SELECT 'Error: CI ya registrado.' error;
	END IF;
END //


DROP PROCEDURE IF EXISTS pInsertEmpleador;
CREATE PROCEDURE pInsertEmpleador (
	IN v_foto varchar(30),
	IN v_nombre varchar(50),
	IN v_apellido varchar(50),
	IN v_empresa varchar(60),
	IN v_correo varchar(20),
	IN v_contra varchar(30),
	IN v_telefono varchar(15),
	IN v_celular int
)
BEGIN
	IF NOT EXISTS(SELECT id FROM empleador WHERE correo LIKE v_correo) THEN
		INSERT INTO empleador VALUES(null,v_foto,v_nombre,v_apellido,v_empresa,v_correo,v_contra,v_telefono,v_celular);
		SELECT @@identity AS id, '' error;
	ELSE
		SELECT 'Error: Correo ya registrado.' error;
	END IF;
END //


DROP PROCEDURE IF EXISTS pInsertDepartamento;
CREATE PROCEDURE pInsertDepartamento (
	IN v_nombre varchar(50)
)
BEGIN
	IF NOT EXISTS(SELECT id FROM departamento WHERE nombre LIKE v_nombre) THEN
		INSERT INTO departamento VALUES(null,v_nombre);
		SELECT @@identity AS id, '' error;
	ELSE
		SELECT 'Error: Nombre ya registrado.' error;
	END IF;
END //


DROP PROCEDURE IF EXISTS pInsertMensaje;
CREATE PROCEDURE pInsertMensaje (
	IN v_id_empleador int,
	IN v_correo varchar(30),
	IN v_mensaje text
)
BEGIN
	INSERT INTO categoria VALUES(null,v_id_empleador,v_correo,v_mensaje,CURRENT_TIMESTAMP);
	SELECT @@identity AS id, '' error;
END //


DROP PROCEDURE IF EXISTS pInsertNotificaciones;
CREATE PROCEDURE pInsertNotificaciones (
	IN v_id_categoria int,
	IN v_id_empleado int
)
BEGIN
	INSERT INTO notificaciones VALUES(null,v_id_categoria,v_id_empleado,CURRENT_TIMESTAMP);
	SELECT @@identity AS id, '' error;
END //


DROP PROCEDURE IF EXISTS pInsertOferta;
CREATE PROCEDURE pInsertOferta (
	IN v_id_categoria int,
	IN v_id_empleado int,
	IN v_id_empleador int,
	IN v_id_departamento int,
	IN v_detalle text,
	IN v_direccion varchar(50),
	IN v_latitud varchar(150),
	IN v_longitud varchar(150)
)
BEGIN
	INSERT INTO departamento VALUES(null,v_id_categoria,v_id_empleado,v_id_empleador,v_id_departamento,v_detalle,v_direccion,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,v_latitud,v_longitud);
	SELECT @@identity AS id, '' error;
END //
