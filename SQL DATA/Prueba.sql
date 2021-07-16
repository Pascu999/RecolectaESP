insert into Tipos_Vehiculos (tipo_id, tipo_descripcion, tipo_nombre) values (1, 'Zandalee', 'Pesado');
insert into Tipos_Vehiculos (tipo_id, tipo_descripcion, tipo_nombre) values (2, 'Shanghai Ghetto', 'Liviano');

insert into Desechos (desecho_id, desecho_nombre, desecho_descripcion, desecho_estado) values (1, 'Residuo comercial', 'SCROPHULOUS HP', 1);
insert into Desechos (desecho_id, desecho_nombre, desecho_descripcion, desecho_estado) values (2, 'Residuo domiciliario', 'Erythromycin-Benzoyl Peroxide', 1);
insert into Desechos (desecho_id, desecho_nombre, desecho_descripcion, desecho_estado) values (3, 'Residuo agricola', 'SCROPHULOUS HP', 1);

INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(1, 'Antioquia', 5, 1);

insert into Rutas (ruta_id, municipio_id, ruta_nombre, ruta_descripcion, ruta_fecha_inicio, ruta_fecha_finalizacion, ruta_estado) values (1, 1, 'Mybuzz', 'pcjkybfnuafwxvp', '13/05/2020', '18/05/2020', 1);
insert into Rutas (ruta_id, municipio_id, ruta_nombre, ruta_descripcion, ruta_fecha_inicio, ruta_fecha_finalizacion, ruta_estado) values (2, 1, 'Tavu', 'elmiwzisfshfgxt', '13/05/2020', '18/05/2020', 1);

insert into Contratistas (contratista_id, contratista_nit, contratista_nombre, contratista_celular, contratista_direccion, contratista_correo, contratista_contrasena, contratista_fecha_creacion, contratista_ultima_facturacion) values (1, 'contratista1', 'Jabbersphere', '1447973557', '035 Sachs Hill', 'obeaty0@wufoo.com', 'contratista1', '28/09/2013', '01/02/2020');
insert into Contratistas (contratista_id, contratista_nit, contratista_nombre, contratista_celular, contratista_direccion, contratista_correo, contratista_contrasena, contratista_fecha_creacion, contratista_ultima_facturacion) values (2, 'contratista2', 'Pixonyx', '8146532106', '7 Lindbergh Court', 'ahinemoor1@goo.gl', 'contratista2', '28/12/2013', '01/02/2020');

INSERT INTO CONTRATISTAS_TARIFAN_DESECHOS(CONTRATISTA_ID, DESECHO_ID, CONTRATISTAS_TARIFAN_DESECHOS_PRECIO_KILO) VALUES
(1, 1, 5549);
INSERT INTO CONTRATISTAS_TARIFAN_DESECHOS(CONTRATISTA_ID, DESECHO_ID, CONTRATISTAS_TARIFAN_DESECHOS_PRECIO_KILO) VALUES
(1, 2, 5165);
INSERT INTO CONTRATISTAS_TARIFAN_DESECHOS(CONTRATISTA_ID, DESECHO_ID, CONTRATISTAS_TARIFAN_DESECHOS_PRECIO_KILO) VALUES
(1, 3, 6494);
INSERT INTO CONTRATISTAS_TARIFAN_DESECHOS(CONTRATISTA_ID, DESECHO_ID, CONTRATISTAS_TARIFAN_DESECHOS_PRECIO_KILO) VALUES
(2, 1, 6221);
INSERT INTO CONTRATISTAS_TARIFAN_DESECHOS(CONTRATISTA_ID, DESECHO_ID, CONTRATISTAS_TARIFAN_DESECHOS_PRECIO_KILO) VALUES
(2, 2, 7765);
INSERT INTO CONTRATISTAS_TARIFAN_DESECHOS(CONTRATISTA_ID, DESECHO_ID, CONTRATISTAS_TARIFAN_DESECHOS_PRECIO_KILO) VALUES
(2, 3, 5658);

insert into Vehiculos (vehiculo_id, contratista_id, ruta_id, tipo_id, vehiculo_marca, vehiculo_placa, vehiculo_modelo, vehiculo_peso, vehiculo_fecha_creacion, vehiculo_estado) values (1, 1, 1, 1, 'Nissan', '3D73M4CL6BG677279', 2007, 100, '15/03/2014', 1);
insert into Vehiculos (vehiculo_id, contratista_id, ruta_id, tipo_id, vehiculo_marca, vehiculo_placa, vehiculo_modelo, vehiculo_peso, vehiculo_fecha_creacion, vehiculo_estado) values (2, 1, 2, 2, 'Nissan', '1FMJK1H56CE408037', 2010, 100, '22/04/2014', 1);
insert into Vehiculos (vehiculo_id, contratista_id, ruta_id, tipo_id, vehiculo_marca, vehiculo_placa, vehiculo_modelo, vehiculo_peso, vehiculo_fecha_creacion, vehiculo_estado) values (3, 2, 1, 1, 'Acura', 'WAUAC68D01A041128', 2005, 100, '26/03/2014', 1);
insert into Vehiculos (vehiculo_id, contratista_id, ruta_id, tipo_id, vehiculo_marca, vehiculo_placa, vehiculo_modelo, vehiculo_peso, vehiculo_fecha_creacion, vehiculo_estado) values (4, 2, 2, 2, 'Chevrolet', '3D73Y3CLXAG731650', 1993, 100, '09/06/2014', 1);

insert into Conductores (conductor_id, contratista_id, conductor_nombre, conductor_apellido, conductor_documento, conductor_fecha_nacimiento, conductor_celular, conductor_correo, conductor_estado) values (1, 1, 'Delano', 'Sargent', '8871648099', '29/08/1992', '3988264492', 'dsargent0@mail.ru', 1);
insert into Conductores (conductor_id, contratista_id, conductor_nombre, conductor_apellido, conductor_documento, conductor_fecha_nacimiento, conductor_celular, conductor_correo, conductor_estado) values (2, 2, 'Reginauld', 'O''Flannery', '4908237506', '23/01/1994', '3111369831', 'roflannery1@sciencedaily.com', 1);

insert into Centros_disposicion (centro_disposicion_id, municipio_id, centro_disposicion_nombre, centro_disposicion_direccion, centro_disposicion_celular, centro_disposicion_correo, centro_disposicion_estado) values (1, 1, 'Benetta', '3 Mifflin Center', '4023977601', 'bnoseworthy0@usnews.com', 1);
insert into Centros_disposicion (centro_disposicion_id, municipio_id, centro_disposicion_nombre, centro_disposicion_direccion, centro_disposicion_celular, centro_disposicion_correo, centro_disposicion_estado) values (2, 1, 'Lacey', '5 Buell Road', '3066333741', 'lduran1@clickbank.net', 1);

INSERT INTO CENTROS_DISPOSICION_LIMITAN_DESECHOS(CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO, TIPO_ID, CENTRO_DISPOSICION_ID, DESECHO_ID) VALUES
(3671, 847, 1, 1, 1);
INSERT INTO CENTROS_DISPOSICION_LIMITAN_DESECHOS(CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO, TIPO_ID, CENTRO_DISPOSICION_ID, DESECHO_ID) VALUES
(2037, 638, 1, 1, 2);
INSERT INTO CENTROS_DISPOSICION_LIMITAN_DESECHOS(CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO, TIPO_ID, CENTRO_DISPOSICION_ID, DESECHO_ID) VALUES
(1729, 904, 1, 1, 3);
INSERT INTO CENTROS_DISPOSICION_LIMITAN_DESECHOS(CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO, TIPO_ID, CENTRO_DISPOSICION_ID, DESECHO_ID) VALUES
(2984, 584, 1, 2, 1);
INSERT INTO CENTROS_DISPOSICION_LIMITAN_DESECHOS(CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO, TIPO_ID, CENTRO_DISPOSICION_ID, DESECHO_ID) VALUES
(3430, 652, 1, 2, 2);
INSERT INTO CENTROS_DISPOSICION_LIMITAN_DESECHOS(CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO, TIPO_ID, CENTRO_DISPOSICION_ID, DESECHO_ID) VALUES
(2706, 775, 1, 2, 3);
INSERT INTO CENTROS_DISPOSICION_LIMITAN_DESECHOS(CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO, TIPO_ID, CENTRO_DISPOSICION_ID, DESECHO_ID) VALUES
(3576, 638, 2, 1, 1);
INSERT INTO CENTROS_DISPOSICION_LIMITAN_DESECHOS(CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO, TIPO_ID, CENTRO_DISPOSICION_ID, DESECHO_ID) VALUES
(3634, 505, 2, 1, 2);
INSERT INTO CENTROS_DISPOSICION_LIMITAN_DESECHOS(CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO, TIPO_ID, CENTRO_DISPOSICION_ID, DESECHO_ID) VALUES
(4030, 910, 2, 1, 3);
INSERT INTO CENTROS_DISPOSICION_LIMITAN_DESECHOS(CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO, TIPO_ID, CENTRO_DISPOSICION_ID, DESECHO_ID) VALUES
(2774, 614, 2, 2, 1);
INSERT INTO CENTROS_DISPOSICION_LIMITAN_DESECHOS(CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO, TIPO_ID, CENTRO_DISPOSICION_ID, DESECHO_ID) VALUES
(2506, 674, 2, 2, 2);
INSERT INTO CENTROS_DISPOSICION_LIMITAN_DESECHOS(CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO, TIPO_ID, CENTRO_DISPOSICION_ID, DESECHO_ID) VALUES
(4604, 737, 2, 2, 3);

insert into trabajadores (trabajador_id, centro_disposicion_id, trabajador_nombre, trabajador_apellido, trabajador_documento, trabajador_celular, trabajador_correo, trabajador_direccion, trabajador_tipo, trabajador_fecha_ingreso, trabajador_fecha_nacimiento, trabajador_contrasena, trabajador_estado) values (1, 1, 'Carlos', 'Cotmore', 'trabajador', '31314688553', 'pcotmore0@storify.com', '5 Di Loreto Avenue', 1, '02/03/2014', '29/05/1997', 'trabajador', 1);
insert into trabajadores (trabajador_id, centro_disposicion_id, trabajador_nombre, trabajador_apellido, trabajador_documento, trabajador_celular, trabajador_correo, trabajador_direccion, trabajador_tipo, trabajador_fecha_ingreso, trabajador_fecha_nacimiento, trabajador_contrasena, trabajador_estado) values (2, 1, 'Jesus', 'Tumilty', 'admin', '31314688554', 'itumilty1@goo.gl', '11 Manufacturers Alley', 2, '04/03/2014', '01/08/1994', 'admin', 1);

insert into Celdas (celda_id, centro_disposicion_id, celda_nombre, celda_estado, celda_capacidad_total, celda_capacidad_usada) values (1, 1, 'Topiramate', 1, 999999999999999, 0);
insert into Celdas (celda_id, centro_disposicion_id, celda_nombre, celda_estado, celda_capacidad_total, celda_capacidad_usada) values (2, 1, 'Muscle Ice', 1, 999999999999999, 0);
insert into Celdas (celda_id, centro_disposicion_id, celda_nombre, celda_estado, celda_capacidad_total, celda_capacidad_usada) values (3, 2, 'Hydrocortisone and Acetic Acid', 1, 999999999999999, 0);
insert into Celdas (celda_id, centro_disposicion_id, celda_nombre, celda_estado, celda_capacidad_total, celda_capacidad_usada) values (4, 2, 'Targretin', 1, 999999999999999, 0);

insert into Celdas_admiten_desechos (celda_id, desecho_id) values (1, 1);
insert into Celdas_admiten_desechos (celda_id, desecho_id) values (1, 2);
insert into Celdas_admiten_desechos (celda_id, desecho_id) values (1, 3);
insert into Celdas_admiten_desechos (celda_id, desecho_id) values (2, 1);
insert into Celdas_admiten_desechos (celda_id, desecho_id) values (2, 2);
insert into Celdas_admiten_desechos (celda_id, desecho_id) values (2, 3);
insert into Celdas_admiten_desechos (celda_id, desecho_id) values (3, 1);
insert into Celdas_admiten_desechos (celda_id, desecho_id) values (3, 2);
insert into Celdas_admiten_desechos (celda_id, desecho_id) values (3, 3);
insert into Celdas_admiten_desechos (celda_id, desecho_id) values (4, 1);
insert into Celdas_admiten_desechos (celda_id, desecho_id) values (4, 2);
insert into Celdas_admiten_desechos (celda_id, desecho_id) values (4, 3);

COMMIT;