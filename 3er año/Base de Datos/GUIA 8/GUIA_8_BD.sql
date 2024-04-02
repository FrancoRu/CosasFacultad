--GUIA SQL FCYT BD

USE DB_PRACTICA;

--TABLAS
--Cree las tablas como se muestra en la estructura, incluyendo claves primarias y foráneas
CREATE TABLE CLIENTES(
	CLI_Codigo INT NOT NULL,
	CLI_RazonSocial VARCHAR(255) NOT NULL,
	CLI_Tipo_Documento int NOT NULL,
	CLI_NumDocumento INT NOT NULL,
	CLI_FechaNacimiento DATE,
	CLI_estado CHAR,
	CONSTRAINT PK_CLI PRIMARY KEY(CLI_Codigo)
);

CREATE TABLE TIP_DNI(
	TDC_Codigo INT NOT NULL,
	TDC_Descripcion VARCHAR(10) NOT NULL,
	CONSTRAINT PK_TIP PRIMARY KEY(TDC_Codigo)
);

CREATE TABLE DOMICILIO_CLIENTE(
	DOM_CodCliente INT NOT NULL,
	DOM_Cod INT NOT NULL,
	DOM_Domicilio VARCHAR(255),
	DOM_CodLocalidad VARCHAR(10) NOT NULL,
	DOM_Principal VARCHAR(255) NOT NULL,
	CONSTRAINT PK_DOM PRIMARY KEY(DOM_Cod),
	CONSTRAINT FK_CLIENTE FOREIGN KEY(DOM_CodCliente) REFERENCES CLIENTES(CLI_Codigo)
);

CREATE TABLE ARTICULO (
    ART_Codigo INT NOT NULL,
    ART_Descripcion VARCHAR(255) NOT NULL,
    ART_TipoArticulo VARCHAR(255) NOT NULL,
    ART_Estado VARCHAR(12) NOT NULL,
    CONSTRAINT PK_ART PRIMARY KEY (ART_Codigo)
);

CREATE TABLE FACTURA_CABECERA (
    FAC_Codigo INT NOT NULL,
    FAC_Sucursal VARCHAR(20) NOT NULL,
    FAC_Numero INT NOT NULL,
    FAC_Fecha DATE NOT NULL,
    FAC_CodCliente INT NOT NULL,
    CONSTRAINT PK_FAC PRIMARY KEY (FAC_Codigo)
);

CREATE TABLE FACTURA_ITEM (
    ITEM_ID INT IDENTITY(1,1) PRIMARY KEY,
    ITEM_CodFactura INT NOT NULL,
    ITEM_CodArticulo INT NOT NULL,
    ITEM_Cantidad INT NOT NULL,
    ITEM_PrecioUnitario DECIMAL(4,2),
    CONSTRAINT FK_ID_FA FOREIGN KEY (ITEM_CodFactura) REFERENCES FACTURA_CABECERA (FAC_Codigo),
    CONSTRAINT FK_ID_AR FOREIGN KEY (ITEM_CodArticulo) REFERENCES ARTICULO (ART_Codigo)
);


DROP TABLE FACTURA_ITEM;

--Insertar registros en todas las tablas. (Probar ambas formas)
--CLIENTES
INSERT INTO CLIENTES (CLI_Codigo, CLI_RazonSocial, CLI_Tipo_Documento, CLI_NumDocumento, CLI_FechaNacimiento, CLI_estado)
VALUES
(1, 'Juan Pérez', 1, 12345, '1990-05-15', 'A'),
(2, 'María Rodríguez', 2, 54321, '1985-02-20', 'D'),
(3, 'Carlos López', 1, 98765, '1992-07-10', 'D'),
(4, 'Laura Martínez', 2, 24680, '1988-11-30', 'D'),
(5, 'Pedro García', 1, 13579, '1980-09-25', 'A'),
(6, 'Ana Sánchez', 2, 86420, '1995-03-05', 'A'),
(7, 'José González', 1, 10101, '1975-12-12', 'A'),
(8, 'Sofía Fernández', 2, 20202, '1987-04-18', 'A'),
(9, 'Manuel Ramírez', 1, 30303, '1998-08-22', 'A'),
(10, 'Isabel Díaz', 2, 40404, '1990-01-02', 'A'),
(11, 'Luis Torres', 1, 50505, '1982-06-14', 'A'),
(12, 'Elena Vargas', 2, 60606, '1994-10-29', 'A'),
(13, 'Javier Mendoza', 1, 70707, '1983-03-07', 'D'),
(14, 'Paula Ortega', 2, 80808, '1997-09-08', 'A'),
(15, 'Miguel Silva', 1, 90909, '1986-12-23', 'A'),
(16, 'Carmen Paredes', 2, 11111, '1993-04-03', 'A'),
(17, 'Andrés Rivera', 1, 22222, '1984-08-11', 'A'),
(18, 'Rosa Castillo', 2, 33333, '1996-02-28', 'A'),
(19, 'Fernando Soto', 1, 44444, '1981-05-08', 'A'),
(20, 'Pilar Navarro', 2, 55555, '1991-09-16', 'D');


INSERT INTO CLIENTES (CLI_Codigo, CLI_RazonSocial, CLI_Tipo_Documento, CLI_NumDocumento, CLI_FechaNacimiento, CLI_estado)
VALUES
(21, 'Roberto Nahuel Navarro', 2, 12312, '1981-12-26', 'A');


SELECT CLI_Codigo, CLI_RazonSocial, CLI_Tipo_Documento, CLI_NumDocumento, CLI_FechaNacimiento, CLI_estado FROM CLIENTES;
--TIPO DOCUMENTO
INSERT INTO TIP_DNI (TDC_Codigo, TDC_Descripcion)
VALUES
(1, 'DNI'),
(2, 'CUIT');

SELECT TDC_Codigo, TDC_Descripcion FROM TIP_DNI

--DOMICILIOS
INSERT INTO DOMICILIO_CLIENTE (DOM_CodCliente, DOM_Cod, DOM_Domicilio, DOM_CodLocalidad, DOM_Principal)
VALUES
(1, 1, 'Calle Entre Ríos 123', '3100', 'SI'),
(2, 2, 'Avenida Paraná 456', '3101', 'SI'),
(3, 3, 'Calle Gualeguaychú 789', '3102', 'NO'),
(4, 4, 'Calle Colón 101', '3103', 'NO'),
(5, 5, 'Avenida Concordia 202', '3104', 'SI'),
(6, 6, 'Calle Villaguay 303', '3105', 'SI'),
(7, 7, 'Avenida Federal 404', '3106', 'SI'),
(8, 8, 'Calle La Paz 505', '3107', 'NO'),
(9, 9, 'Calle Concepción del Uruguay 606', '3108', 'SI'),
(10, 10, 'Avenida Victoria 707', '3109', 'SI'),
(11, 11, 'Calle Gualeguay 808', '3110', 'SI'),
(12, 12, 'Avenida San José 909', '3111', 'NO'),
(13, 13, 'Calle Nogoyá 111', '3112', 'SI'),
(14, 14, 'Avenida Villaguaychú 222', '3113', 'SI'),
(15, 15, 'Calle Federación 333', '3114', 'SI'),
(16, 16, 'Calle Islas del Ibicuy 444', '3115', 'SI'),
(17, 17, 'Avenida Diamante 555', '3116', 'NO'),
(18, 18, 'Calle Santa Elena 666', '3117', 'SI'),
(19, 19, 'Avenida Rosario del Tala 777', '3118', 'SI'),
(20, 20, 'Calle La Criolla 888', '3119', 'NO');

SELECT * FROM DOMICILIO_CLIENTE;

--PRODUCTOS

ALTER TABLE ARTICULO
ALTER COLUMN ART_Estado VARCHAR(9);

INSERT INTO ARTICULO (ART_Codigo, ART_Descripcion, ART_TipoArticulo, ART_Estado)
VALUES
(1, 'iPhone 13 Pro', 'Teléfono móvil', 'ACTIVO'),
(2, 'MacBook Air', 'Computadora portátil', 'ACTIVO'),
(3, 'Samsung 4K Smart TV', 'Televisor', 'DESACTIVO'),
(4, 'PlayStation 5', 'Consola de videojuegos', 'ACTIVO'),
(5, 'Bose Noise Cancelling Headphones 700', 'Auriculares', 'DESACTIVO'),
(6, 'Nike Air Max 270', 'Zapatillas deportivas', 'ACTIVO'),
(7, 'Instant Pot Duo Nova', 'Electrodoméstico de cocina', 'ACTIVO'),
(8, 'Dyson V11 Absolute Pro', 'Aspiradora', 'DESACTIVO'),
(9, 'Canon EOS 5D Mark IV', 'Cámara digital', 'ACTIVO'),
(10, 'Sony WH-1000XM4', 'Auriculares', 'DESACTIVO'),
(11, 'KitchenAid Artisan Stand Mixer', 'Batidora de pie', 'ACTIVO'),
(12, 'iRobot Roomba 980', 'Robot aspiradora', 'DESACTIVO'),
(13, 'Samsung Galaxy Tab S7', 'Tableta', 'ACTIVO'),
(14, 'Levi`s 501 Original Fit Jeans', 'Ropa', 'ACTIVO'),
(15, 'Philips Hue White and Color Ambiance Starter Kit', 'Iluminación inteligente', 'ACTIVO'),
(16, 'LG OLED TV CX Series', 'Televisor', 'DESACTIVO'),
(17, 'Apple AirPods Pro', 'Auriculares', 'ACTIVO'),
(18, 'Nike Sportswear Club Fleece Hoodie', 'Ropa', 'DESACTIVO'),
(19, 'Cuisinart DFP-14BCNY Food Processor', 'Procesador de alimentos', 'ACTIVO'),
(20, 'Sony PlayStation 4', 'Consola de videojuegos', 'ACTIVO'),
(21, 'Samsung Galaxy S21 Ultra', 'Teléfono móvil', 'ACTIVO'),
(22, 'Bose SoundLink Revolve', 'Altavoz Bluetooth', 'ACTIVO'),
(23, 'Nespresso Vertuo Plus Coffee and Espresso Maker', 'Cafetera', 'DESACTIVO'),
(24, 'Fujifilm Instax Mini 11', 'Cámara instantánea', 'ACTIVO'),
(25, 'Dell XPS 13', 'Computadora portátil', 'DESACTIVO'),
(26, 'Adidas Ultraboost', 'Zapatillas deportivas', 'ACTIVO'),
(27, 'Samsung Family Hub Refrigerator', 'Refrigerador inteligente', 'ACTIVO'),
(28, 'iRobot Braava jet m6', 'Robot trapeador', 'DESACTIVO'),
(29, 'Canon EOS Rebel T7i', 'Cámara digital', 'ACTIVO'),
(30, 'Lululemon Align Pant II', 'Ropa deportiva', 'DESACTIVO');

SELECT ART_Codigo, ART_Descripcion, ART_TipoArticulo, ART_Estado FROM ARTICULO;

--CABECERA DE FACTURA
-- Generar 40 registros ficticios para FACTURA_CABECERA con 5 sucursales

-- Declarar variables para el bucle
DECLARE @contador INT = 1;
DECLARE @maxRegistros INT = 40;
DECLARE @sucursales VARCHAR(5) = 'ABCDE';

-- Iniciar el bucle
WHILE @contador <= @maxRegistros
BEGIN
    INSERT INTO FACTURA_CABECERA (FAC_Codigo, FAC_Sucursal, FAC_Numero, FAC_Fecha, FAC_CodCliente)
    VALUES
    (@contador, 'SUCURSAL ' + SUBSTRING(@sucursales, ((@contador - 1) % 5) + 1, 1), @contador, DATEADD(DAY, -@contador, GETDATE()), ((@contador - 1) % 20) + 1);

    SET @contador = @contador + 1;
END;
SELECT  FAC_Codigo, FAC_Sucursal, FAC_Numero, FAC_Fecha, FAC_CodCliente FROM FACTURA_CABECERA;

DELETE FROM FACTURA_CABECERA;

--ITEMS FACTURAS

-- 5. Verificar los resultados
SELECT ITEM_CodFactura, ITEM_CodArticulo, ITEM_Cantidad, ITEM_PrecioUnitario FROM FACTURA_ITEM;

DELETE FROM FACTURA_ITEM;

--Crear una nueva tabla "Tipo_Producto", que contenga código y descripción.

CREATE TABLE TIP_ARTICULO(
	TIP_AR_Codigo INT NOT NULL IDENTITY(1,1),
	TIP_AR_Descripcion VARCHAR(255) NOT NULL,
	CONSTRAINT PK_TIP_ARTICULO PRIMARY KEY (TIP_AR_Codigo)
);

DROP TABLE TIP_ARTICULO;

INSERT INTO TIP_ARTICULO (TIP_AR_Descripcion)
SELECT DISTINCT ART_TipoArticulo
FROM ARTICULO;

--Modificar la tabla Artículo, agregando la clave foránea a la tabla Tipo_Producto.

UPDATE ARTICULO
SET ART_TipoArticulo = (SELECT CAST(TIP_AR_Codigo AS VARCHAR(2)) 
FROM TIP_ARTICULO
WHERE TIP_AR_Descripcion = ART_TipoArticulo);


ALTER TABLE ARTICULO
ALTER COLUMN ART_TipoArticulo INT NOT NULL;

ALTER TABLE ARTICULO
ADD CONSTRAINT FK_TIP_ART FOREIGN KEY (ART_TipoArticulo) REFERENCES TIP_ARTICULO(TIP_AR_Codigo);


--Crear una nueva tabla “Estado_Civil” que contenga código y descripción.

CREATE TABLE ESTADO_CIVIL(
	EST_CIV_COD INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	EST_CIV_DES VARCHAR(15) NOT NULL
);

INSERT INTO ESTADO_CIVIL (EST_CIV_DES) VALUES ('Soltero');
INSERT INTO ESTADO_CIVIL (EST_CIV_DES) VALUES ('Casado');
INSERT INTO ESTADO_CIVIL (EST_CIV_DES) VALUES ('Viudo');
INSERT INTO ESTADO_CIVIL (EST_CIV_DES) VALUES ('Divorciado');


--Modificar la tabla clientes, agregando una columna para indicar el estado civil de la
--persona, la cual debe hacer referencia a la tabla previamente creada. Puede admitir
--valores nulos.

ALTER TABLE CLIENTES
ADD CLI_EST INT FOREIGN KEY (CLI_EST) REFERENCES ESTADO_CIVIL(EST_CIV_COD)
--Consultar la tabla clientes. ¿Cómo se muestra la nueva columna?

SELECT * FROM CLIENTES;

UPDATE CLIENTES
SET CLI_EST = (SELECT EST_CIV_COD FROM ESTADO_CIVIL WHERE ESTADO_CIVIL.EST_CIV_COD = CLIENTES.CLI_Codigo % 4+1)

--Vuelva a ejecutar las sentencias para insertar clientes cambiando solo el código


--Modifique la sentencia anterior para indicar el estado civil.

SELECT CLI_RazonSocial AS NOMBRE, EC.EST_CIV_DES AS ESTADO_CIVIL FROM CLIENTES CL 
JOIN ESTADO_CIVIL EC
ON EC.EST_CIV_COD = CL.CLI_EST


--Consultar la tabla clientes. ¿Qué valores toman para la nueva columna los nuevos
--clientes?

SELECT * FROM CLIENTES
SELECT CLI_RazonSocial AS NOMBRE, 
TD.TDC_Descripcion AS T_DOCUMENTO,
CLI_NumDocumento AS NUMERO,
CLI_FechaNacimiento AS FEC_NAC,
EC.EST_CIV_DES AS ESTADO_CIVIL FROM CLIENTES CL 
JOIN ESTADO_CIVIL EC
ON EC.EST_CIV_COD = CL.CLI_EST
JOIN TIP_DNI TD
ON TD.TDC_Codigo = CLI_Tipo_Documento


--Actualizar los datos de la tabla clientes, indicando estado civil a las clientes cuyo código
--sea menor a 3.


--Consultar la tabla clientes para verificar el resultado de la ejecución.


--Modificar la tabla clientes, agregando una nueva columna para indicar el límite de crédito
--permitido. Es necesario que este campo siempre tenga valor. En caso de no indicarse
--alguno, debe ser 0.

ALTER TABLE CLIENTES
ADD CREDIT_LIMIT INT NOT NULL DEFAULT 0;


--PARA ELIMIANR LA NUEVA COLUMNA:
ALTER TABLE CLIENTES
DROP COLUMN CREDIT_LIMIT

SELECT name
FROM sys.default_constraints
WHERE parent_object_id = OBJECT_ID('CLIENTES')
AND parent_column_id = (
    SELECT column_id
    FROM sys.columns
    WHERE NAME = 'CREDIT_LIMIT'
    AND object_id = OBJECT_ID('CLIENTES')
);

ALTER TABLE CLIENTES
DROP CONSTRAINT DF__CLIENTES__CREDIT__5EBF139D;

--Consultar la tabla clientes. ¿Cómo se muestra la nueva columna?


--Insertar un nuevo cliente sin indicar el límite de crédito.
INSERT INTO CLIENTES (CLI_Codigo, CLI_RazonSocial, CLI_Tipo_Documento, CLI_NumDocumento, CLI_FechaNacimiento, CLI_estado)
VALUES
(22, 'JuanCHO PANZOTA', 1, 124512, '1990-05-15', 'A')

--Consultar la tabla clientes para verificar el resultado de la ejecución.

SELECT * FROM CLIENTES

--Borrar todos los registros de la tabla clientes.
DELETE FROM DOMICILIO_CLIENTE
DELETE FROM CLIENTES


--Seleccionar los clientes cuyo límite de crédito sea mayor a 0.

SELECT CLI_RazonSocial AS NOMBRE, 
TD.TDC_Descripcion AS T_DOCUMENTO,
CLI_NumDocumento AS NUMERO,
CLI_FechaNacimiento AS FEC_NAC,
CREDIT_LIMIT,
EC.EST_CIV_DES AS ESTADO_CIVIL FROM CLIENTES CL 
JOIN ESTADO_CIVIL EC
ON EC.EST_CIV_COD = CL.CLI_EST
JOIN TIP_DNI TD
ON TD.TDC_Codigo = CLI_Tipo_Documento 
WHERE CREDIT_LIMIT > 0;


INSERT INTO CLIENTES (CLI_Codigo, CLI_RazonSocial, CLI_Tipo_Documento, CLI_NumDocumento, CLI_FechaNacimiento, CLI_estado, CREDIT_LIMIT)
VALUES
(22, 'JuanCHO PANZOTA', 1, 124512, '1990-05-15', 'A', 1500)
--Borrar los clientes cuyo límite de crédito sea mayor a 0.

DELETE FROM CLIENTES
WHERE CREDIT_LIMIT > 0;

--Seleccionar el código, razón social y fecha de nacimiento de los clientes cuyo tipo de
--documento sea 1 y el estado sea activo (A).

SELECT CLI_Codigo AS CODIGO, 
CLI_RazonSocial AS NOMBRE,
CLI_FechaNacimiento AS FEC_NAC,
CREDIT_LIMIT,
EC.EST_CIV_DES AS ESTADO_CIVIL FROM CLIENTES CL 
JOIN ESTADO_CIVIL EC
ON EC.EST_CIV_COD = CL.CLI_EST
JOIN TIP_DNI TD
ON TD.TDC_Codigo = CLI_Tipo_Documento 
WHERE CLI_Tipo_Documento = 1 AND CLI_estado = 'A';

--Seleccionar los items facturados, mostrando código de artículo, cantidad y precio, cuando
--el precio sea mayor a 100 o la cantidad sea mayor a 5, ordenados por código de artículo
--de mayor a menor

SELECT ITEM_CodArticulo AS CODIGO, 
       ITEM_Cantidad AS CANTIDAD, 
       ITEM_PrecioUnitario AS PRECIO 
FROM FACTURA_ITEM
WHERE ITEM_PrecioUnitario > 100 OR
      ITEM_Cantidad > 5
ORDER BY ITEM_PrecioUnitario DESC, ITEM_Cantidad DESC;


CREATE TABLE FACTURA_ITEM (
    ITEM_ID INT IDENTITY(1,1) PRIMARY KEY,
    ITEM_CodFactura INT NOT NULL,
    ITEM_CodArticulo INT NOT NULL,
    ITEM_Cantidad INT NOT NULL,
    ITEM_PrecioUnitario DECIMAL(4,2),
    CONSTRAINT FK_ID_FA FOREIGN KEY (ITEM_CodFactura) REFERENCES FACTURA_CABECERA (FAC_Codigo),
    CONSTRAINT FK_ID_AR FOREIGN KEY (ITEM_CodArticulo) REFERENCES ARTICULO (ART_Codigo)
);