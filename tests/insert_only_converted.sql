
CREATE TABLE "ship" (
	lost_in_battle int,
	id int,
	name VARCHAR(100),
	tonnage VARCHAR(100),
	ship_type VARCHAR(100),
	location VARCHAR(100),
	disposition_of_ship VARCHAR(100),
	primary key(id),
) AS NODE;


CREATE TABLE "death" (
	caused_by_ship_id int,
	id int,
	note VARCHAR(100),
	killed int,
	injured int,
	primary key(id),
) AS NODE;


CREATE TABLE Staff (
	staff_id INTEGER PRIMARY KEY,
	staff_address_id INTEGER NOT NULL,
	nickname VARCHAR(80),
	first_name VARCHAR(80),
	middle_name VARCHAR(80),
	last_name VARCHAR(80),
	date_of_birth DATETIME,
	date_joined_staff DATETIME,
	date_left_staff DATETIME,
) AS NODE;


CREATE TABLE "farm_competition" (
	Competition_ID int,
	Year int,
	Theme VARCHAR(100),
	Host_city_ID int,
	Hosts VARCHAR(100),
	PRIMARY KEY (Competition_ID),
) AS NODE;

INSERT INTO ship (lost_in_battle, id, name, tonnage, ship_type, location, disposition_of_ship) VALUES (8, 1, 'Lettice', 't', 'Brig', 'English Channel', 'Captured');
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (1, 14, 'thompson.constantin', 'Janessa', 'Amara', 'Sawayn', '2010-12-08 16:55:14', '2017-04-27 03:21:26', '2018-03-23 22:53:12');

INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (2, 3, 'santos45', 'Camylle', 'Icie', 'Weissnat', '2015-08-01 13:22:43', '2016-06-06 08:54:28', '2018-03-10 15:25:00');
INSERT INTO farm_competition (competition_id, year, theme, host_city_id, hosts) VALUES (4, '2004', 'Valentine Day', 4, 'Vanness Wu and Michelle Branch');


CREATE TABLE ship_to_death AS EDGE;
CREATE TABLE ship_to_Staff AS EDGE;
CREATE TABLE ship_to_farm_competition AS EDGE;
CREATE TABLE death_to_Staff AS EDGE;
CREATE TABLE death_to_farm_competition AS EDGE;
CREATE TABLE Staff_to_farm_competition AS EDGE;

INSERT INTO ship_to_Staff VALUES
	 ((SELECT $node_id FROM ship WHERE id = 1), (SELECT $node_id FROM Staff WHERE staff_id = 1))
	,((SELECT $node_id FROM ship WHERE id = 1), (SELECT $node_id FROM Staff WHERE staff_id = 2))
;

INSERT INTO ship_to_farm_competition VALUES
	 ((SELECT $node_id FROM ship WHERE id = 1), (SELECT $node_id FROM farm_competition WHERE competition_id = 4))
;

INSERT INTO Staff_to_farm_competition VALUES
	 ((SELECT $node_id FROM Staff WHERE staff_id = 1), (SELECT $node_id FROM farm_competition WHERE competition_id = 4))
	,((SELECT $node_id FROM Staff WHERE staff_id = 2), (SELECT $node_id FROM farm_competition WHERE competition_id = 4))
;

