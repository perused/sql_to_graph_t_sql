CREATE TABLE "battle" (
	id int,
	name VARCHAR(100),
	date VARCHAR(100),
	bulgarian_commander VARCHAR(100),
	latin_commander VARCHAR(100),
	result VARCHAR(100),
	primary key(id)
) AS NODE;

CREATE TABLE "ship" (
	lost_in_battle int,
	id int,
	name VARCHAR(100),
	tonnage VARCHAR(100),
	ship_type VARCHAR(100),
	location VARCHAR(100),
	disposition_of_ship VARCHAR(100),
	primary key(id),
	foreign key (lost_in_battle) references battle(id)
) AS NODE;

CREATE TABLE "death" (
	caused_by_ship_id int,
	id int,
	note VARCHAR(100),
	killed int,
	injured int,
	primary key(id),
	foreign key (caused_by_ship_id) references ship(id)
) AS NODE;

INSERT INTO battle (id, name, date, bulgarian_commander, latin_commander, result) VALUES (1,"Battle of Adrianople","14 April 1205","Kaloyan","Baldwin I","Bulgarian victory");

INSERT INTO battle (id, name, date, bulgarian_commander, latin_commander, result) VALUES (2,"Battle of Serres","June 1205","Kaloyan","Unknown","Bulgarian victory");

INSERT INTO battle (id, name, date, bulgarian_commander, latin_commander, result) VALUES (3,"Battle of Rusion","31 January 1206","Kaloyan","Thierry de Termond","Bulgarian victory");

INSERT INTO battle (id, name, date, bulgarian_commander, latin_commander, result) VALUES (4,"Battle of Rodosto","February 1206","Kaloyan","Unknown","Bulgarian victory");

INSERT INTO battle (id, name, date, bulgarian_commander, latin_commander, result) VALUES (5,"Battle of Messinopolis","4 September 1207","Unknown","Boniface of Montferrat","Bulgarian victory");

INSERT INTO battle (id, name, date, bulgarian_commander, latin_commander, result) VALUES (6,"Battle of Boruy","June 1205","Boril","Henry I","Bulgarian victory");

INSERT INTO battle (id, name, date, bulgarian_commander, latin_commander, result) VALUES (7,"Battle of Philippopolis","31 June 1208","Boril","Henry I","Latin victory");

INSERT INTO battle (id, name, date, bulgarian_commander, latin_commander, result) VALUES (8,"Siege of Constantinople","1235","Ivan Asen II","John of Brienne","Two Year Truce");

INSERT INTO ship (lost_in_battle, id, name, tonnage, ship_type, location, disposition_of_ship) VALUES (8, 1, "Lettice","t","Brig","English Channel","Captured");

INSERT INTO ship (lost_in_battle, id, name, tonnage, ship_type, location, disposition_of_ship) VALUES (7, 2, "Bon Accord","t","Brig","English Channel","Captured");

INSERT INTO ship (lost_in_battle, id, name, tonnage, ship_type, location, disposition_of_ship) VALUES (6, 3, "Mary","t","Brig","English Channel","Captured");

INSERT INTO ship (lost_in_battle, id, name, tonnage, ship_type, location, disposition_of_ship) VALUES (5, 4, "HMS Avon","391","18-gun Brig","English Channel","Wrecked");

INSERT INTO ship (lost_in_battle, id, name, tonnage, ship_type, location, disposition_of_ship) VALUES (5, 5, "Three Brothers","t","Brig","SW Approaches","Scuttled");

INSERT INTO ship (lost_in_battle, id, name, tonnage, ship_type, location, disposition_of_ship) VALUES (4, 6, "Bacchus","t","Brig","English Channel","Sank");

INSERT INTO ship (lost_in_battle, id, name, tonnage, ship_type, location, disposition_of_ship) VALUES (8, 7, "HMS Atalanta","225","8 gun Brig","Mid-Atlantic","Captured");

INSERT INTO death (caused_by_ship_id, id, note, killed, injured) VALUES (1, "1","Dantewada, Chhattisgarh","8","0");

INSERT INTO death (caused_by_ship_id, id, note, killed, injured) VALUES (2, "2","Dantewada, Chhattisgarh","3","0");

INSERT INTO death (caused_by_ship_id, id, note, killed, injured) VALUES (3, "13","Erraboru, Chhattisgarh","25","0");

INSERT INTO death (caused_by_ship_id, id, note, killed, injured) VALUES (3, "3","East Champaran, Bihar","2","0");

INSERT INTO death (caused_by_ship_id, id, note, killed, injured) VALUES (4, "4","Gajapati, Odisha","3","0");

INSERT INTO death (caused_by_ship_id, id, note, killed, injured) VALUES (4, "5","Sundargarh, Odisha","0","9");

INSERT INTO death (caused_by_ship_id, id, note, killed, injured) VALUES (5, "6","Dantewada, Chhattisgarh","0","0");

INSERT INTO death (caused_by_ship_id, id, note, killed, injured) VALUES (5, "7","Dantewada, Chhattisgarh","4","5");

INSERT INTO death (caused_by_ship_id, id, note, killed, injured) VALUES (6, "8","Kanker, Chhattisgarh","0","0");

INSERT INTO death (caused_by_ship_id, id, note, killed, injured) VALUES (1, "9","Dantewada, Chhattisgarh","29","0");

INSERT INTO death (caused_by_ship_id, id, note, killed, injured) VALUES (3, "10","WestMidnapore, West Bengal","0","0");

INSERT INTO death (caused_by_ship_id, id, note, killed, injured) VALUES (2, "11","Bastar, Chattisgarh","0","0");

INSERT INTO death (caused_by_ship_id, id, note, killed, injured) VALUES (5, "12","Bokaro, Jharkhand","14","0");


CREATE TABLE battle_to_ship AS EDGE;
CREATE TABLE battle_to_death AS EDGE;
CREATE TABLE ship_to_death AS EDGE;

INSERT INTO battle_to_ship VALUES
	 ((SELECT $node_id FROM ship WHERE ID = 1), (SELECT $node_id FROM battle WHERE ID = 1))
;

INSERT INTO ship_to_death VALUES
	 ((SELECT $node_id FROM ship WHERE ID = 1), (SELECT $node_id FROM battle WHERE ID = 1))
	,((SELECT $node_id FROM death WHERE ID = 1), (SELECT $node_id FROM ship WHERE ID = 2))
;

INSERT INTO battle_to_death VALUES
	 ((SELECT $node_id FROM death WHERE ID = 1), (SELECT $node_id FROM ship WHERE ID = 2))
;

