CREATE TABLE "city" (
	City_ID int,
	Official_Name VARCHAR(100),
	Status VARCHAR(100),
	Area_km_2 FLOAT,
	Population FLOAT,
	Census_Ranking VARCHAR(100),
	PRIMARY KEY (City_ID)
) AS NODE;

CREATE TABLE "farm" (
	Farm_ID int,
	Year int,
	Total_Horses FLOAT,
	Working_Horses FLOAT,
	Total_Cattle FLOAT,
	Oxen FLOAT,
	Bulls FLOAT,
	Cows FLOAT,
	Pigs FLOAT,
	Sheep_and_Goats FLOAT,
	PRIMARY KEY (Farm_ID)
) AS NODE;

CREATE TABLE "farm_competition" (
	Competition_ID int,
	Year int,
	Theme VARCHAR(100),
	Host_city_ID int,
	Hosts VARCHAR(100),
	PRIMARY KEY (Competition_ID),
	FOREIGN KEY (Host_city_ID) REFERENCES city(City_ID)
) AS NODE;

CREATE TABLE "competition_record" (
	Competition_ID int,
	Farm_ID int,
	Rank int,
	PRIMARY KEY (Competition_ID,Farm_ID),
	FOREIGN KEY (Competition_ID) REFERENCES farm_competition(Competition_ID),
	FOREIGN KEY (Farm_ID) REFERENCES farm(Farm_ID)
) AS NODE;

INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (1,'Grand Falls/Grand-Sault','Town','18.06','5706','636 of 5008');

INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (2,'Perth-Andover','Village','8.89','1778','1442 of 5,008');

INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (3,'Plaster Rock','Village','3.09','1135','1936 of 5,008');

INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (4,'Drummond','Village','8.91','775','2418 of 5008');

INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (5,'Aroostook','Village','2.24','351','3460 of 5008');

INSERT INTO farm (Farm_ID, Year, Total_Horses, Working_Horses, Total_Cattle, Oxen, Bulls, Cows, Pigs, Sheep_and_Goats) VALUES (1,'1927','5056.5','3900.1','8374.5','805.5','31.6','3852.1','4412.4','7956.3');

INSERT INTO farm (Farm_ID, Year, Total_Horses, Working_Horses, Total_Cattle, Oxen, Bulls, Cows, Pigs, Sheep_and_Goats) VALUES (2,'1928','5486.9','4090.5','8604.8','895.3','32.8','3987.0','6962.9','8112.2');

INSERT INTO farm (Farm_ID, Year, Total_Horses, Working_Horses, Total_Cattle, Oxen, Bulls, Cows, Pigs, Sheep_and_Goats) VALUES (3,'1929','5607.5','4198.8','7611.0','593.7','26.9','3873.0','4161.2','7030.8');

INSERT INTO farm (Farm_ID, Year, Total_Horses, Working_Horses, Total_Cattle, Oxen, Bulls, Cows, Pigs, Sheep_and_Goats) VALUES (4,'1930','5308.2','3721.6','6274.1','254.8','49.6','3471.6','3171.8','4533.4');

INSERT INTO farm (Farm_ID, Year, Total_Horses, Working_Horses, Total_Cattle, Oxen, Bulls, Cows, Pigs, Sheep_and_Goats) VALUES (5,'1931','4781.3','3593.7','6189.5','113.8','40.0','3377.0','3373.3','3364.8');

INSERT INTO farm (Farm_ID, Year, Total_Horses, Working_Horses, Total_Cattle, Oxen, Bulls, Cows, Pigs, Sheep_and_Goats) VALUES (6,'1932','3658.9','3711.6','5006.7','105.2','71.6','2739.5','2623.7','2109.5');

INSERT INTO farm (Farm_ID, Year, Total_Horses, Working_Horses, Total_Cattle, Oxen, Bulls, Cows, Pigs, Sheep_and_Goats) VALUES (7,'1933','2604.8','3711.2','4446.3','116.9','37.6','2407.2','2089.2','2004.7');

INSERT INTO farm (Farm_ID, Year, Total_Horses, Working_Horses, Total_Cattle, Oxen, Bulls, Cows, Pigs, Sheep_and_Goats) VALUES (8,'1934','2546.9','2197.3','5277.5','156.5','46.7','2518.0','4236.7','2197.1');

INSERT INTO farm_competition (Competition_ID, Year, Theme, Host_city_ID, Hosts) VALUES (1,'2013','Carnival M is back!',1,'Miley Cyrus Jared Leto and Karen Mok');

INSERT INTO farm_competition (Competition_ID, Year, Theme, Host_city_ID, Hosts) VALUES (2,'2006','Codehunters',2,'Leehom Wang and Kelly Rowland');

INSERT INTO farm_competition (Competition_ID, Year, Theme, Host_city_ID, Hosts) VALUES (3,'2005','MTV Asia Aid',3,'Alicia Keys');

INSERT INTO farm_competition (Competition_ID, Year, Theme, Host_city_ID, Hosts) VALUES (4,'2004','Valentines Day',4,'Vanness Wu and Michelle Branch');

INSERT INTO farm_competition (Competition_ID, Year, Theme, Host_city_ID, Hosts) VALUES (5,'2003','MTV Cube',5,'Shaggy and Coco Lee');

INSERT INTO farm_competition (Competition_ID, Year, Theme, Host_city_ID, Hosts) VALUES (6,'2002','Aliens',5,'Mandy Moore and Ronan Keating');

INSERT INTO competition_record (Competition_ID, Farm_ID, Rank) VALUES (1,8,1);

INSERT INTO competition_record (Competition_ID, Farm_ID, Rank) VALUES (1,2,2);

INSERT INTO competition_record (Competition_ID, Farm_ID, Rank) VALUES (1,3,3);

INSERT INTO competition_record (Competition_ID, Farm_ID, Rank) VALUES (2,1,3);

INSERT INTO competition_record (Competition_ID, Farm_ID, Rank) VALUES (2,4,1);

INSERT INTO competition_record (Competition_ID, Farm_ID, Rank) VALUES (2,3,2);

INSERT INTO competition_record (Competition_ID, Farm_ID, Rank) VALUES (3,7,1);

INSERT INTO competition_record (Competition_ID, Farm_ID, Rank) VALUES (3,1,3);

INSERT INTO competition_record (Competition_ID, Farm_ID, Rank) VALUES (4,3,2);

INSERT INTO competition_record (Competition_ID, Farm_ID, Rank) VALUES (4,1,4);

INSERT INTO competition_record (Competition_ID, Farm_ID, Rank) VALUES (5,5,1);

INSERT INTO competition_record (Competition_ID, Farm_ID, Rank) VALUES (5,3,2);


CREATE TABLE city_to_farm AS EDGE;
CREATE TABLE city_to_farm_competition AS EDGE;
CREATE TABLE city_to_competition_record AS EDGE;
CREATE TABLE farm_to_farm_competition AS EDGE;
CREATE TABLE farm_to_competition_record AS EDGE;
CREATE TABLE farm_competition_to_competition_record AS EDGE;

INSERT INTO farm_to_competition_record VALUES
	 ((SELECT $node_id FROM competition_record WHERE ID = 1), (SELECT $node_id FROM farm_competition WHERE ID = 1))
	,((SELECT $node_id FROM competition_record WHERE ID = 2), (SELECT $node_id FROM farm WHERE ID = 1))
;

INSERT INTO farm_to_farm_competition VALUES
	 ((SELECT $node_id FROM farm_competition WHERE ID = 4), (SELECT $node_id FROM city WHERE ID = 1))
;

INSERT INTO city_to_competition_record VALUES
	 ((SELECT $node_id FROM competition_record WHERE ID = 1), (SELECT $node_id FROM farm_competition WHERE ID = 1))
	,((SELECT $node_id FROM competition_record WHERE ID = 2), (SELECT $node_id FROM farm WHERE ID = 1))
;

INSERT INTO farm_competition_to_competition_record VALUES
	 ((SELECT $node_id FROM farm_competition WHERE ID = 4), (SELECT $node_id FROM city WHERE ID = 1))
	,((SELECT $node_id FROM competition_record WHERE ID = 1), (SELECT $node_id FROM farm_competition WHERE ID = 1))
	,((SELECT $node_id FROM competition_record WHERE ID = 2), (SELECT $node_id FROM farm WHERE ID = 1))
;

INSERT INTO city_to_farm_competition VALUES
	 ((SELECT $node_id FROM farm_competition WHERE ID = 4), (SELECT $node_id FROM city WHERE ID = 1))
;

