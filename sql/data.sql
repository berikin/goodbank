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
#* Account types
#***********************************************************

INSERT INTO `account_types` (`type_id`, `type`)
VALUES
(1,'Cuenta morada'),
(2,'Cuenta nómina plus'),
(3,'Cuenta ahorro platino');


#***********************************************************
#* Managers
#***********************************************************

INSERT INTO `managers` (`manager_id`,`id_card`, `name`, `lastname_first`, `lastname_second`, `birth_date`, `street_type`, `address`, `province`, `community`, `phone_number`, `manager_range`, `password`) VALUES (1,'83373738A', 'Super Admin', 'Boss', 'Manager', '1998-05-16', '8', 'Falsa 12 3E', '47', '7', '34983121212', '3', '5fc2ca6f085919f2f77626f1e280fab9cc92b4edc9edc53ac6eee3f72c5c508e869ee9d67a96d63986d14c1c2b82c35ff5f31494bea831015424f59c96fff664');
INSERT INTO `managers` (`manager_id`,`id_card`, `name`, `lastname_first`, `lastname_second`, `birth_date`, `street_type`, `address`, `province`, `community`, `phone_number`, `manager_range`, `password`) VALUES (2,'26170333J', 'Juan', 'Rebollo', 'Martínez', '1987-04-19', '8', 'de la salud 11 4D', '47', '7', '34666567834', '2', '5fc2ca6f085919f2f77626f1e280fab9cc92b4edc9edc53ac6eee3f72c5c508e869ee9d67a96d63986d14c1c2b82c35ff5f31494bea831015424f59c96fff664');
INSERT INTO `managers` (`manager_id`,`id_card`, `name`, `lastname_first`, `lastname_second`, `birth_date`, `street_type`, `address`, `province`, `community`, `phone_number`, `manager_range`, `password`) VALUES (3,'74702757E', 'María', 'Miñón', 'Aparicio', '1983-02-24', '20', 'de Europa 23 2B', '28', '13', '34666127812', '2', '5fc2ca6f085919f2f77626f1e280fab9cc92b4edc9edc53ac6eee3f72c5c508e869ee9d67a96d63986d14c1c2b82c35ff5f31494bea831015424f59c96fff664');
INSERT INTO `managers` (`manager_id`,`id_card`, `name`, `lastname_first`, `lastname_second`, `birth_date`, `street_type`, `address`, `province`, `community`, `phone_number`, `manager_range`, `password`) VALUES (4,'88954664W', 'Marta', 'González', 'Pérez', '1989-08-11', '6', 'san martín 5 5 22', '47', '7', '34983111213', '1', '5fc2ca6f085919f2f77626f1e280fab9cc92b4edc9edc53ac6eee3f72c5c508e869ee9d67a96d63986d14c1c2b82c35ff5f31494bea831015424f59c96fff664');

#***********************************************************
#* Clients
#***********************************************************

INSERT INTO `clients` (`client_id`,`id_card`, `name`, `lastname_first`, `lastname_second`, `birth_date`, `street_type`, `address`, `province`, `community`, `phone_number`, `client_range`, `password`) VALUES (1,'62581737W', 'Juan', 'Benito', 'Marín', '1985-10-12', '16', 'Cuatro caminos 3 4B', '47', '7', '34666787834', '1', '7469eb3dc5848b1dadd0f638a95cf4e4f0d6246717d5dc92e77b80f5199182b0f2cc1bb86c9187666b90aca27372cdb03d22689a9343c5a96993bb1782f7a67d');
INSERT INTO `clients` (`client_id`,`id_card`, `name`, `lastname_first`, `lastname_second`, `birth_date`, `street_type`, `address`, `province`, `community`, `phone_number`, `client_range`, `password`) VALUES (2,'54325661Y', 'Teresa', 'Luenco', 'Pérez', '1986-04-22', '8', 'Tenerife 2 1B', '47', '7', '34646482831', '2', '7469eb3dc5848b1dadd0f638a95cf4e4f0d6246717d5dc92e77b80f5199182b0f2cc1bb86c9187666b90aca27372cdb03d22689a9343c5a96993bb1782f7a67d');
INSERT INTO `clients` (`client_id`,`id_card`, `name`, `lastname_first`, `lastname_second`, `birth_date`, `street_type`, `address`, `province`, `community`, `phone_number`, `client_range`, `password`) VALUES (3,'37532591H', 'Juan', 'Benito', 'Marín', '1985-10-12', '6', 'Trinidad 1 2B', '28', '13', '34666787834', '2', '7469eb3dc5848b1dadd0f638a95cf4e4f0d6246717d5dc92e77b80f5199182b0f2cc1bb86c9187666b90aca27372cdb03d22689a9343c5a96993bb1782f7a67d');

#***********************************************************
#* Branches
#***********************************************************

INSERT INTO `branches` (`branch_code`, `street_type`, `address`, `province`, `community`, `phone_number`, `manager`) VALUES ('5674', '6', 'Trinidad 3', '47', '7', '34983252525', '2');
INSERT INTO `branches` (`branch_code`, `street_type`, `address`, `province`, `community`, `phone_number`, `manager`) VALUES ('1628', '7', 'Equinoccio Leganés', '28', '13', '34912525252', '3');

#***********************************************************
#* Accounts
#***********************************************************

INSERT INTO `accounts` (`account_id`,`account_number`, `branch`, `creation_date`, `account_type`, `client_id`, `amount`) VALUES (1,'6313332953', '1', '2013-11-10', '1', '1', '1523.12');
INSERT INTO `accounts` (`account_id`,`account_number`, `branch`, `creation_date`, `account_type`, `client_id`, `amount`) VALUES (2,'8665511473', '2', '2012-09-10', '2', '2', '3521.23');
INSERT INTO `accounts` (`account_id`,`account_number`, `branch`, `creation_date`, `account_type`, `client_id`,`second_client_id`, `amount`) VALUES (3,'4593984876', '2', '2010-12-10', '3', '2','3', '18810.00');
INSERT INTO `accounts` (`account_id`,`account_number`, `branch`, `creation_date`, `account_type`, `client_id`, `amount`) VALUES (4,'4325463421', '2', '2013-11-05', '1', '3', '23521.23');

#***********************************************************
#* Transactions
#***********************************************************

INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (1,'3', '2010-12-10 10:30:00', '570.0', 'Teresa Luenco', 'Ingreso en efectivo inicial');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (2,'3', '2011-01-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (3,'3', '2011-02-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (4,'3', '2011-03-10 10:20:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (5,'3', '2011-04-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (6,'3', '2011-05-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (7,'3', '2011-06-10 10:20:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (8,'3', '2011-07-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (9,'3', '2011-09-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (10,'3', '2011-10-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (11,'3', '2011-11-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (12,'3', '2011-12-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (13,'3', '2012-01-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (14,'3', '2012-02-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (15,'3', '2012-03-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (16,'3', '2012-04-10 10:10:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (17,'3', '2012-05-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (18,'3', '2012-06-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (19,'3', '2012-07-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (20,'3', '2012-09-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (21,'3', '2012-10-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (22,'3', '2012-11-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (23,'3', '2012-12-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (24,'3', '2013-01-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (25,'3', '2013-02-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (26,'3', '2013-03-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (27,'3', '2013-04-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (28,'3', '2013-05-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (29,'3', '2013-06-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (30,'3', '2013-07-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (31,'3', '2013-09-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (32,'3', '2013-10-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (33,'3', '2013-11-10 10:30:00', '570.0', 'Juan Benito', 'Ingreso en efectivo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (34,'4', '2013-11-06 08:30:10', '579.320', 'Servicio Público de Empleo Estatal', 'Prestación por desempleo');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (35,'4', '2013-11-08 09:12:11', '-79.75', 'Iberdrola Generación SA', 'Adeudo de Iberdrola');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (36,'4', '2013-11-10 11:37:33', '-13.14', 'Aguas de Valladolid', 'Adeudo de agua');
INSERT INTO `transactions` (`transaction_id`, `account`, `transaction_date`, `amount`, `applicant`, `concept`) VALUES (37,'4', '2013-11-10 13:22:45', '-83.14', 'Gas Natural SDG SA', 'Adeudo de Gas Natural Fenosa');
