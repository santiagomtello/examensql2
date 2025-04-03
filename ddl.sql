-- Active: 1743685642141@@127.0.0.1@3306@sakilacampus


CREATE TABLE IF NOT EXISTS film_text (
    film_id SMALLINT  PRIMARY KEY,
    title VARCHAR(255),
    description TEXT
);

CREATE TABLE If NOT EXISTS categoria (
    id_categoria TINYINT UNSIGNED  PRIMARY KEY,
    nombre VARCHAR(25),
    ultima_actualizacion TIMESTAMP
);
CREATE TABLE IF NOT EXISTS actor (
    id_actor SMALLINT UNSIGNED  PRIMARY KEY,
    nombre VARCHAR(45),
    apellidos VARCHAR(45),
    ultima_actualizacion TIMESTAMP
);

CREATE TABLE IF NOT EXISTS idioma (
    id_idioma TINYINT UNSIGNED  PRIMARY KEY,
    nombre CHAR(20),
    ultima_actualizacion TIMESTAMP
);


CREATE TABLE IF NOT EXISTS pais (
    id_pais SMALLINT UNSIGNED  PRIMARY KEY,
    nombre VARCHAR(50),
    ultima_actualizacion TIMESTAMP
);
CREATE TABLE IF NOT EXISTS ciudad (
    id_ciudad SMALLINT UNSIGNED  PRIMARY KEY,
    nombre VARCHAR(50),
    id_pais SMALLINT UNSIGNED,
    Foreign Key (id_pais) REFERENCES pais(id_pais),
    ultima_actualizacion TIMESTAMP
);
CREATE TABLE IF NOT EXISTS direccion (
    id_direccion SMALLINT UNSIGNED  PRIMARY KEY,
    direccion VARCHAR(50),
    direccion2 VARCHAR(50),
    distrito VARCHAR(20),
    id_ciudad SMALLINT UNSIGNED,
    Foreign Key (id_ciudad) REFERENCES ciudad(id_ciudad),
    codigo_postal VARCHAR(10),
    telefono VARCHAR (20),
    ultima_actualizacion TIMESTAMP
);

CREATE TABLE IF NOT EXISTS pelicula (
    id_pelicula SMALLINT UNSIGNED  PRIMARY KEY,
    titulo VARCHAR(255),
    descripcion TEXT,
    anyo_lanzamiento YEAR,
    id_idioma TINYINT UNSIGNED,
    Foreign Key (id_idioma) REFERENCES idioma(id_idioma),
    id_idioma_original TINYINT UNSIGNED,
    Foreign Key (id_idioma) REFERENCES idioma(id_idioma),
    duracion_alquiler TINYINT UNSIGNED,
    rental_rate DECIMAL(4,2),
    duracion SMALLINT UNSIGNED,
    replacement_cost DECIMAL(5,2),
    clasificacion ENUM('G','PG','PG-13','R','NC-17'),
    caracteristicas_especiales SET('Trailers','Commentaries','Deleted Scenes', 'Behind the Scenes'),
    ultima_actualizacion TIMESTAMP
);


CREATE TABLE IF NOT EXISTS pelicula_categoria (
    id_pelicula SMALLINT UNSIGNED,
    Foreign Key (id_pelicula) REFERENCES pelicula(id_pelicula),
    id_categoria TINYINT UNSIGNED,
    Foreign Key (id_categoria) REFERENCES categoria(id_categoria),
    ultima_actualizacion TIMESTAMP

);

CREATE TABLE IF NOT EXISTS pelicula_actor (
    id_actor SMALLINT UNSIGNED PRIMARY KEY,
    Foreign Key (id_actor) REFERENCES actor(id_actor),
    id_pelicula SMALLINT UNSIGNED,
    Foreign Key (id_pelicula) REFERENCES pelicula(id_pelicula),
        ultima_actualizacion TIMESTAMP

);



CREATE TABLE IF NOT EXISTS almacen(
    id_almacen TINYINT UNSIGNED  PRIMARY KEY,
    id_direccion SMALLINT UNSIGNED,
    Foreign Key (id_direccion) REFERENCES direccion(id_direccion)
);

CREATE TABLE IF NOT EXISTS empleado (
    id_empleado TINYINT UNSIGNED  PRIMARY KEY,
    nombre VARCHAR(45),
    apellidos VARCHAR(45),
    id_direccion SMALLINT UNSIGNED,
    Foreign Key (id_direccion) REFERENCES direccion(id_direccion),
    imagen BLOB,
    email VARCHAR(50),
    id_almacen TINYINT UNSIGNED,
    Foreign Key (id_almacen) REFERENCES almacen(id_almacen),
    activo TINYINT(1),
    username VARCHAR(16),
    password VARCHAR(40),
    ultima_actualizacion TIMESTAMP
);

DROP TABLE almacen

ALTER TABLE almacen ADD id_empleado_jefe TINYINT UNSIGNED

ALTER TABLE almacen ADD CONSTRAINT fk_almacen Foreign Key (id_empleado_jefe) REFERENCES empleado(id_empleado)

ALTER TABLE  almacen ADD ultima_actualizacion TIMESTAMP

CREATE TABLE IF NOT EXISTS inventario(
    id_inventario MEDIUMINT UNSIGNED  PRIMARY KEY,
    id_pelicula SMALLINT UNSIGNED,
    Foreign Key (id_pelicula) REFERENCES pelicula(id_pelicula),
    id_almacen TINYINT UNSIGNED,
    Foreign Key (id_almacen) REFERENCES almacen(id_almacen),
    ultima_actualizacion TIMESTAMP
);


CREATE TABLE IF NOT EXISTS cliente(
    id_cliente SMALLINT UNSIGNED  PRIMARY KEY,
    id_almacen TINYINT UNSIGNED,
    Foreign Key (id_almacen) REFERENCES almacen(id_almacen),
    nombre VARCHAR(45),
    apellido VARCHAR(45),
    email VARCHAR(50),
    id_direccion SMALLINT UNSIGNED,
    Foreign Key (id_direccion) REFERENCES direccion(id_direccion),
    activo TINYINT(1),
    fecha_creacion DATETIME,
    ultima_actualizacion TIMESTAMP
);


CREATE TABLE IF NOT EXISTS alquiler(
    id_alquiler INT  PRIMARY KEY,
    fecha_alquiler DATETIME,
    id_inventario MEDIUMINT UNSIGNED,
    id_cliente SMALLINT UNSIGNED,
    fecha_devolucion DATETIME,
    id_empleado TINYINT UNSIGNED,
    ultima_actualizacion TIMESTAMP,
    Foreign Key (id_inventario) REFERENCES inventario(id_inventario),
    Foreign Key (id_cliente) REFERENCES cliente(id_cliente),
    Foreign Key (id_empleado) REFERENCES empleado(id_empleado)
);

CREATE TABLE IF NOT EXISTS pago(
    id_pago SMALLINT UNSIGNED  PRIMARY KEY,
    id_cliente SMALLINT UNSIGNED,
    id_empleado TINYINT UNSIGNED,
    id_alquiler INT ,
    total DECIMAL(5,2),
    fecha_pago DATETIME,
    ultima_actualizacion TIMESTAMP,
    Foreign Key (id_cliente) REFERENCES cliente(id_cliente),
    Foreign Key (id_empleado) REFERENCES empleado(id_empleado),
    Foreign Key (id_alquiler) REFERENCES alquiler(id_alquiler)
);

