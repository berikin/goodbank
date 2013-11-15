#***********************************************************
#* Spanish communities at 2013
#***********************************************************

INSERT INTO `communities` (`community_id`, `community`)
VALUES
        (1,'Andalucía'),
        (2,'Aragón'),
        (3,'Asturias, Principado de'),
        (4,'Balears, Illes'),
        (5,'Canarias'),
        (6,'Cantabria'),
        (7,'Castilla y León'),
        (8,'Castilla - La Mancha'),
        (9,'Catalunya'),
        (10,'Comunitat Valenciana'),
        (11,'Extremadura'),
        (12,'Galicia'),
        (13,'Madrid, Comunidad de'),
        (14,'Murcia, Región de'),
        (15,'Navarra, Comunidad Foral de'),
        (16,'País Vasco'),
        (17,'Rioja, La'),
        (18,'Ceuta'),
        (19,'Melilla');


#***********************************************************
#* Spanish provinces at 2013
#***********************************************************

INSERT INTO `provinces` (`province_id`, `province`)
VALUES
        (2,'Albacete'),
        (3,'Alicante/Alacant'),
        (4,'Almería'),
        (1,'Araba/Álava'),
        (33,'Asturias'),
        (5,'Ávila'),
        (6,'Badajoz'),
        (7,'Balears, Illes'),
        (8,'Barcelona'),
        (48,'Bizkaia'),
        (9,'Burgos'),
        (10,'Cáceres'),
        (11,'Cádiz'),
        (39,'Cantabria'),
        (12,'Castellón/Castelló'),
        (51,'Ceuta'),
        (13,'Ciudad Real'),
        (14,'Córdoba'),
        (15,'Coruña, A'),
        (16,'Cuenca'),
        (20,'Gipuzkoa'),
        (17,'Girona'),
        (18,'Granada'),
        (19,'Guadalajara'),
        (21,'Huelva'),
        (22,'Huesca'),
        (23,'Jaén'),
        (24,'León'),
        (27,'Lugo'),
        (25,'Lleida'),
        (28,'Madrid'),
        (29,'Málaga'),
        (52,'Melilla'),
        (30,'Murcia'),
        (31,'Navarra'),
        (32,'Ourense'),
        (34,'Palencia'),
        (35,'Palmas, Las'),
        (36,'Pontevedra'),
        (26,'Rioja, La'),
        (37,'Salamanca'),
        (38,'Santa Cruz de Tenerife'),
        (40,'Segovia'),
        (41,'Sevilla'),
        (42,'Soria'),
        (43,'Tarragona'),
        (44,'Teruel'),
        (45,'Toledo'),
        (46,'Valencia/València'),
        (47,'Valladolid'),
        (49,'Zamora'),
        (50,'Zaragoza');


#***********************************************************
#* Street types
#***********************************************************

INSERT INTO `street_types` (`type_id`, `type`)
VALUES
(1,'Acceso'),
(2,'Acera'),
(3,'Alameda'),
(4,'Autopista'),
(5,'Autovía'),
(6,'Avenida'),
(7,'C. Comercial'),
(8,'Calle'),
(9,'Callejón'),
(10,'Camino'),
(11,'Cañada'),
(12,'Carrer'),
(13,'Carrera'),
(14,'Carretera'),
(15,'Cuesta'),
(16,'Glorieta'),
(17,'Pasadizo'),
(18,'Pasaje'),
(19,'Paseo'),
(20,'Plaza'),
(21,'Rambla'),
(22,'Ronda'),
(23,'Sendero'),
(24,'Travesía'),
(25,'Urbanización'),
(26,'Vía');


#***********************************************************
#* Manager ranges
#***********************************************************

INSERT INTO `manager_ranges` (`range_id`, `title`)
VALUES
(1,'Empleado estándar'),
(2,'Director'),
(3,'Administrador');


#***********************************************************
#* Client ranges
#***********************************************************

INSERT INTO `client_ranges` (`range_id`, `title`)
VALUES
(1,'Cliente estándar'),
(2,'Cliente oro'),
(3,'Cliente platino');


#***********************************************************
#* Managers
#***********************************************************

INSERT INTO `managers` (`manager_id`,`id_card`, `name`, `lastname_first`, `lastname_second`, `birth_date`, `street_type`, `address`, `province`, `community`, `phone_number`, `manager_range`, `password`) VALUES (1,'83373738A', 'Super Admin', 'Boss', 'Manager', '1998-05-16', '8', 'Falsa', '47', '7', '983121212', '3', '5fc2ca6f085919f2f77626f1e280fab9cc92b4edc9edc53ac6eee3f72c5c508e869ee9d67a96d63986d14c1c2b82c35ff5f31494bea831015424f59c96fff664');

