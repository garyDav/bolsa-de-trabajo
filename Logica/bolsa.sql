CREATE DATABASE bolsa;
use bolsa;

CREATE TABLE empleado (
	id integer PRIMARY KEY AUTO_INCREMENT NOT NULL,
	ci varchar(15),
	foto varchar(30),
	nombre varchar(50),
	apellido varchar(50),
	telefono varchar(15),
	celular integer,
	direccion varchar(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE empleador (
	id integer PRIMARY KEY AUTO_INCREMENT NOT NULL,
	foto varchar(30),
	nombre varchar(50),
	apellido varchar(50),
	empresa varchar(60),
	correo varchar(20),
	contra varchar(30),
	telefono varchar(15),
	celular integer
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE categoria (
	id integer PRIMARY KEY AUTO_INCREMENT NOT NULL,
	nombre varchar(50),
	logo varchar(30)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE departamento (
	id integer PRIMARY KEY AUTO_INCREMENT NOT NULL,
	nombre varchar(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE oferta (
	id integer PRIMARY KEY AUTO_INCREMENT NOT NULL,
	id_categoria integer,
	id_empleado integer,
	id_empleador integer,
	id_departamento integer,
	detalle text,
	direccion varchar(50),
	fecha_in datetime,
	fecha_lim datetime,
	latitud varchar(150),
	longitud varchar(150),
	FOREIGN KEY (id_categoria) REFERENCES categoria(id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (id_empleado) REFERENCES empleado(id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (id_empleador) REFERENCES empleador(id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (id_departamento) REFERENCES departamento(id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE notificaciones (
	id integer PRIMARY KEY AUTO_INCREMENT NOT NULL,
	id_categoria integer,
	id_empleado integer,
	fecha datetime,

	FOREIGN KEY (id_categoria) REFERENCES categoria(id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (id_empleado) REFERENCES empleado(id) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;



CREATE TABLE mensaje (
	id integer PRIMARY KEY AUTO_INCREMENT NOT NULL,
	id_empleador integer,
	correo varchar(30),
	mensaje text,
	fecha datetime,

	FOREIGN KEY (id_empleador) REFERENCES empleador(id) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;



