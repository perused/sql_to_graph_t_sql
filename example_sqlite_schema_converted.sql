CREATE TABLE "battle" (
	"id" int,
	"name" VARCHAR(100),
	"date" VARCHAR(100),
	"bulgarian_commander" VARCHAR(100),
	"latin_commander" VARCHAR(100),
	"result" VARCHAR(100),
	primary key("id")
) AS NODE;

CREATE TABLE "ship" (
	"lost_in_battle" int,
	"id" int,
	"name" VARCHAR(100),
	"tonnage" VARCHAR(100),
	"ship_type" VARCHAR(100),
	"location" VARCHAR(100),
	"disposition_of_ship" VARCHAR(100),
	primary key("id"),
	foreign key ("lost_in_battle") references "battle"("id")
) AS NODE;

CREATE TABLE "death" (
	"caused_by_ship_id" int,
	"id" int,
	"note" VARCHAR(100),
	"killed" int,
	"injured" int,
	primary key("id"),
	foreign key ("caused_by_ship_id") references "ship"("id")
) AS NODE;

INSERT INTO  "battle" VALUES (
	(1, "1"),
	(2, "Battle of Adrianople"),
	(3, "14 April 1205"),
	(4, "Kaloyan"),
	(5, "Baldwin I"),
	(6, "Bulgarian victory")
);

INSERT INTO  "battle" VALUES (
	(1, "2"),
	(2, "Battle of Serres"),
	(3, "June 1205"),
	(4, "Kaloyan"),
	(5, "Unknown"),
	(6, "Bulgarian victory")
);

INSERT INTO  "battle" VALUES (
	(1, "3"),
	(2, "Battle of Rusion"),
	(3, "31 January 1206"),
	(4, "Kaloyan"),
	(5, "Thierry de Termond"),
	(6, "Bulgarian victory")
);

INSERT INTO  "battle" VALUES (
	(1, "4"),
	(2, "Battle of Rodosto"),
	(3, "February 1206"),
	(4, "Kaloyan"),
	(5, "Unknown"),
	(6, "Bulgarian victory")
);

INSERT INTO  "battle" VALUES (
	(1, "5"),
	(2, "Battle of Messinopolis"),
	(3, "4 September 1207"),
	(4, "Unknown"),
	(5, "Boniface of Montferrat"),
	(6, "Bulgarian victory")
);

INSERT INTO  "battle" VALUES (
	(1, "6"),
	(2, "Battle of Boruy"),
	(3, "June 1205"),
	(4, "Boril"),
	(5, "Henry I"),
	(6, "Bulgarian victory")
);

INSERT INTO  "battle" VALUES (
	(1, "7"),
	(2, "Battle of Philippopolis"),
	(3, "31 June 1208"),
	(4, "Boril"),
	(5, "Henry I"),
	(6, "Latin victory")
);

INSERT INTO  "battle" VALUES (
	(1, "8"),
	(2, "Siege of Constantinople"),
	(3, "1235"),
	(4, "Ivan Asen II"),
	(5, "John of Brienne"),
	(6, "Two Year Truce")
);

INSERT INTO  "ship" VALUES (
	(1, "8"),
	(2, " 1"),
	(3, " Lettice"),
	(4, "t"),
	(5, "Brig"),
	(6, "English Channel"),
	(7, "Captured")
);

INSERT INTO  "ship" VALUES (
	(1, "7"),
	(2, " 2"),
	(3, " Bon Accord"),
	(4, "t"),
	(5, "Brig"),
	(6, "English Channel"),
	(7, "Captured")
);

INSERT INTO  "ship" VALUES (
	(1, "6"),
	(2, " 3"),
	(3, " Mary"),
	(4, "t"),
	(5, "Brig"),
	(6, "English Channel"),
	(7, "Captured")
);

INSERT INTO  "ship" VALUES (
	(1, "5"),
	(2, " 4"),
	(3, " HMS Avon"),
	(4, "391"),
	(5, "18-gun Brig"),
	(6, "English Channel"),
	(7, "Wrecked")
);

INSERT INTO  "ship" VALUES (
	(1, "5"),
	(2, " 5"),
	(3, " Three Brothers"),
	(4, "t"),
	(5, "Brig"),
	(6, "SW Approaches"),
	(7, "Scuttled")
);

INSERT INTO  "ship" VALUES (
	(1, "4"),
	(2, " 6"),
	(3, " Bacchus"),
	(4, "t"),
	(5, "Brig"),
	(6, "English Channel"),
	(7, "Sank")
);

INSERT INTO  "ship" VALUES (
	(1, "8"),
	(2, " 7"),
	(3, " HMS Atalanta"),
	(4, "225"),
	(5, "8 gun Brig"),
	(6, "Mid-Atlantic"),
	(7, "Captured")
);

INSERT INTO  "death" VALUES (
	(1, "1"),
	(2, " 1"),
	(3, "Dantewada"),
	(4, " Chhattisgarh"),
	(5, "8"),
	(6, "0")
);

INSERT INTO  "death" VALUES (
	(1, "2"),
	(2, " 2"),
	(3, "Dantewada"),
	(4, " Chhattisgarh"),
	(5, "3"),
	(6, "0")
);

INSERT INTO  "death" VALUES (
	(1, "3"),
	(2, " 13"),
	(3, "Erraboru"),
	(4, " Chhattisgarh"),
	(5, "25"),
	(6, "0")
);

INSERT INTO  "death" VALUES (
	(1, "3"),
	(2, " 3"),
	(3, "East Champaran"),
	(4, " Bihar"),
	(5, "2"),
	(6, "0")
);

INSERT INTO  "death" VALUES (
	(1, "4"),
	(2, " 4"),
	(3, "Gajapati"),
	(4, " Odisha"),
	(5, "3"),
	(6, "0")
);

INSERT INTO  "death" VALUES (
	(1, "4"),
	(2, " 5"),
	(3, "Sundargarh"),
	(4, " Odisha"),
	(5, "0"),
	(6, "9")
);

INSERT INTO  "death" VALUES (
	(1, "5"),
	(2, " 6"),
	(3, "Dantewada"),
	(4, " Chhattisgarh"),
	(5, "0"),
	(6, "0")
);

INSERT INTO  "death" VALUES (
	(1, "5"),
	(2, " 7"),
	(3, "Dantewada"),
	(4, " Chhattisgarh"),
	(5, "4"),
	(6, "5")
);

INSERT INTO  "death" VALUES (
	(1, "6"),
	(2, " 8"),
	(3, "Kanker"),
	(4, " Chhattisgarh"),
	(5, "0"),
	(6, "0")
);

INSERT INTO  "death" VALUES (
	(1, "1"),
	(2, " 9"),
	(3, "Dantewada"),
	(4, " Chhattisgarh"),
	(5, "29"),
	(6, "0")
);

INSERT INTO  "death" VALUES (
	(1, "3"),
	(2, " 10"),
	(3, "WestMidnapore"),
	(4, " West Bengal"),
	(5, "0"),
	(6, "0")
);

INSERT INTO  "death" VALUES (
	(1, "2"),
	(2, " 11"),
	(3, "Bastar"),
	(4, " Chattisgarh"),
	(5, "0"),
	(6, "0")
);

INSERT INTO  "death" VALUES (
	(1, "5"),
	(2, " 12"),
	(3, "Bokaro"),
	(4, " Jharkhand"),
	(5, "14"),
	(6, "0")
);


CREATE TABLE battle_to_ship AS EDGE;
CREATE TABLE battle_to_death AS EDGE;
CREATE TABLE ship_to_death AS EDGE;

INSERT INTO battle_to_death VALUES (
	((SELECT $node_id FROM death WHERE ID = 1), (SELECT $node_id FROM ship WHERE ID = 2))
);

INSERT INTO battle_to_ship VALUES (
	((SELECT $node_id FROM ship WHERE ID = 1), (SELECT $node_id FROM battle WHERE ID = 1))
);

INSERT INTO ship_to_death VALUES (
	((SELECT $node_id FROM ship WHERE ID = 1), (SELECT $node_id FROM battle WHERE ID = 1))
	, ((SELECT $node_id FROM death WHERE ID = 1), (SELECT $node_id FROM ship WHERE ID = 2))
);

