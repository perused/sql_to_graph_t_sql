
CREATE TABLE "stadium" (
	stadium_id int,
	location VARCHAR(100),
	name VARCHAR(100),
	capacity int,
	highest int,
	lowest int,
	average int,
	primary key (stadium_id)
) AS NODE;

INSERT INTO stadium (stadium_id, location, name, capacity, highest, lowest, average) VALUES (1, 'Raith Rovers', 'Starks Park', '10104', '4812', '1294', '2106');
INSERT INTO stadium (stadium_id, location, name, capacity, highest, lowest, average) VALUES (2, 'Ayr United', 'Somerset Park', '11998', '2363', '1057', '1477');
INSERT INTO stadium (stadium_id, location, name, capacity, highest, lowest, average) VALUES (3, 'East Fife', 'Bayview Stadium', '2000', '1980', '533', '864');
INSERT INTO stadium (stadium_id, location, name, capacity, highest, lowest, average) VALUES (4, 'Queens Park', 'Hampden Park', '52500', '1763', '466', '730');
INSERT INTO stadium (stadium_id, location, name, capacity, highest, lowest, average) VALUES (5, 'Stirling Albion', 'Forthbank Stadium', '3808', '1125', '404', '642');
INSERT INTO stadium (stadium_id, location, name, capacity, highest, lowest, average) VALUES (6, 'Arbroath', 'Gayfield Park', '4125', '921', '411', '638');
INSERT INTO stadium (stadium_id, location, name, capacity, highest, lowest, average) VALUES (7, 'Alloa Athletic', 'Recreation Park', '3100', '1057', '331', '637');
INSERT INTO stadium (stadium_id, location, name, capacity, highest, lowest, average) VALUES (9, 'Peterhead', 'Balmoor', '4000', '837', '400', '615');
INSERT INTO stadium (stadium_id, location, name, capacity, highest, lowest, average) VALUES (10, 'Brechin City', 'Glebe Park', '3960', '780', '315', '552');

CREATE TABLE "singer" (
	singer_id int,
	name VARCHAR(100),
	country VARCHAR(100),
	song_name VARCHAR(100),
	song_release_year VARCHAR(100),
	age int,
	is_male varchar(1),
	primary key (singer_id)
) AS NODE;

INSERT INTO singer (singer_id, name, country, song_name, song_release_year, age, is_male) VALUES (1, 'Joe Sharp', 'Netherlands', 'You', '1992', 52, 'F');
INSERT INTO singer (singer_id, name, country, song_name, song_release_year, age, is_male) VALUES (2, 'Timbaland', 'United States', 'Dangerous', '2008', 32, 'T');
INSERT INTO singer (singer_id, name, country, song_name, song_release_year, age, is_male) VALUES (3, 'Justin Brown', 'France', 'Hey Oh', '2013', 29, 'T');
INSERT INTO singer (singer_id, name, country, song_name, song_release_year, age, is_male) VALUES (4, 'Rose White', 'France', 'Sun', '2003', 41, 'F');
INSERT INTO singer (singer_id, name, country, song_name, song_release_year, age, is_male) VALUES (5, 'John Nizinik', 'France', 'Gentleman', '2014', 43, 'T');
INSERT INTO singer (singer_id, name, country, song_name, song_release_year, age, is_male) VALUES (6, 'Tribal King', 'France', 'Love', '2016', 25, 'T');

CREATE TABLE "concert" (
	concert_id int,
	concert_name VARCHAR(100),
	theme VARCHAR(100),
	stadium_id int,
	year VARCHAR(100),
	primary key (concert_id),
	foreign key (stadium_id) references stadium(stadium_id)
) AS NODE;

INSERT INTO concert (concert_id, concert_name, theme, stadium_id, year) VALUES (1, 'Auditions', 'Free choice', 1, 2014);
INSERT INTO concert (concert_id, concert_name, theme, stadium_id, year) VALUES (2, 'Super bootcamp', 'Free choice 2', 2, 2014);
INSERT INTO concert (concert_id, concert_name, theme, stadium_id, year) VALUES (3, 'Home Visits', 'Bleeding Love', 2, 2015);
INSERT INTO concert (concert_id, concert_name, theme, stadium_id, year) VALUES (4, 'Week 1', 'Wide Awake', 10, 2014);
INSERT INTO concert (concert_id, concert_name, theme, stadium_id, year) VALUES (5, 'Week 1', 'Happy Tonight', 9, 2015);
INSERT INTO concert (concert_id, concert_name, theme, stadium_id, year) VALUES (6, 'Week 2', 'Party All Night', 7, 2015);

CREATE TABLE "singer_in_concert" (
	concert_id int,
	singer_id int,
	primary key (concert_id,singer_id),
	foreign key (concert_id) references concert(concert_id),
	foreign key (singer_id) references singer(singer_id)
) AS NODE;

INSERT INTO singer_in_concert (concert_id, singer_id) VALUES (1, 2);
INSERT INTO singer_in_concert (concert_id, singer_id) VALUES (1, 3);
INSERT INTO singer_in_concert (concert_id, singer_id) VALUES (1, 5);
INSERT INTO singer_in_concert (concert_id, singer_id) VALUES (2, 3);
INSERT INTO singer_in_concert (concert_id, singer_id) VALUES (2, 6);
INSERT INTO singer_in_concert (concert_id, singer_id) VALUES (3, 5);
INSERT INTO singer_in_concert (concert_id, singer_id) VALUES (4, 4);
INSERT INTO singer_in_concert (concert_id, singer_id) VALUES (5, 6);
INSERT INTO singer_in_concert (concert_id, singer_id) VALUES (5, 3);
INSERT INTO singer_in_concert (concert_id, singer_id) VALUES (6, 2);

CREATE TABLE stadium_to_singer AS EDGE;
CREATE TABLE stadium_to_concert AS EDGE;
CREATE TABLE stadium_to_singer_in_concert AS EDGE;
CREATE TABLE singer_to_concert AS EDGE;
CREATE TABLE singer_to_singer_in_concert AS EDGE;
CREATE TABLE concert_to_singer_in_concert AS EDGE;

INSERT INTO stadium_to_singer VALUES
	 ((SELECT $node_id FROM stadium WHERE stadium_id = 1), (SELECT $node_id FROM singer WHERE singer_id = 1))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 1), (SELECT $node_id FROM singer WHERE singer_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 1), (SELECT $node_id FROM singer WHERE singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 1), (SELECT $node_id FROM singer WHERE singer_id = 4))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 1), (SELECT $node_id FROM singer WHERE singer_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 1), (SELECT $node_id FROM singer WHERE singer_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 2), (SELECT $node_id FROM singer WHERE singer_id = 1))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 2), (SELECT $node_id FROM singer WHERE singer_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 2), (SELECT $node_id FROM singer WHERE singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 2), (SELECT $node_id FROM singer WHERE singer_id = 4))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 2), (SELECT $node_id FROM singer WHERE singer_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 2), (SELECT $node_id FROM singer WHERE singer_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 3), (SELECT $node_id FROM singer WHERE singer_id = 1))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 3), (SELECT $node_id FROM singer WHERE singer_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 3), (SELECT $node_id FROM singer WHERE singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 3), (SELECT $node_id FROM singer WHERE singer_id = 4))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 3), (SELECT $node_id FROM singer WHERE singer_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 3), (SELECT $node_id FROM singer WHERE singer_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 4), (SELECT $node_id FROM singer WHERE singer_id = 1))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 4), (SELECT $node_id FROM singer WHERE singer_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 4), (SELECT $node_id FROM singer WHERE singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 4), (SELECT $node_id FROM singer WHERE singer_id = 4))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 4), (SELECT $node_id FROM singer WHERE singer_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 4), (SELECT $node_id FROM singer WHERE singer_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 5), (SELECT $node_id FROM singer WHERE singer_id = 1))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 5), (SELECT $node_id FROM singer WHERE singer_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 5), (SELECT $node_id FROM singer WHERE singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 5), (SELECT $node_id FROM singer WHERE singer_id = 4))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 5), (SELECT $node_id FROM singer WHERE singer_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 5), (SELECT $node_id FROM singer WHERE singer_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 6), (SELECT $node_id FROM singer WHERE singer_id = 1))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 6), (SELECT $node_id FROM singer WHERE singer_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 6), (SELECT $node_id FROM singer WHERE singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 6), (SELECT $node_id FROM singer WHERE singer_id = 4))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 6), (SELECT $node_id FROM singer WHERE singer_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 6), (SELECT $node_id FROM singer WHERE singer_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 7), (SELECT $node_id FROM singer WHERE singer_id = 1))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 7), (SELECT $node_id FROM singer WHERE singer_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 7), (SELECT $node_id FROM singer WHERE singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 7), (SELECT $node_id FROM singer WHERE singer_id = 4))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 7), (SELECT $node_id FROM singer WHERE singer_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 7), (SELECT $node_id FROM singer WHERE singer_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 9), (SELECT $node_id FROM singer WHERE singer_id = 1))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 9), (SELECT $node_id FROM singer WHERE singer_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 9), (SELECT $node_id FROM singer WHERE singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 9), (SELECT $node_id FROM singer WHERE singer_id = 4))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 9), (SELECT $node_id FROM singer WHERE singer_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 9), (SELECT $node_id FROM singer WHERE singer_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 10), (SELECT $node_id FROM singer WHERE singer_id = 1))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 10), (SELECT $node_id FROM singer WHERE singer_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 10), (SELECT $node_id FROM singer WHERE singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 10), (SELECT $node_id FROM singer WHERE singer_id = 4))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 10), (SELECT $node_id FROM singer WHERE singer_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 10), (SELECT $node_id FROM singer WHERE singer_id = 6))
;

INSERT INTO stadium_to_concert VALUES
	 ((SELECT $node_id FROM stadium WHERE stadium_id = 1), (SELECT $node_id FROM concert WHERE concert_id = 1))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 1), (SELECT $node_id FROM concert WHERE concert_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 1), (SELECT $node_id FROM concert WHERE concert_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 1), (SELECT $node_id FROM concert WHERE concert_id = 4))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 1), (SELECT $node_id FROM concert WHERE concert_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 1), (SELECT $node_id FROM concert WHERE concert_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 2), (SELECT $node_id FROM concert WHERE concert_id = 1))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 2), (SELECT $node_id FROM concert WHERE concert_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 2), (SELECT $node_id FROM concert WHERE concert_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 2), (SELECT $node_id FROM concert WHERE concert_id = 4))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 2), (SELECT $node_id FROM concert WHERE concert_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 2), (SELECT $node_id FROM concert WHERE concert_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 3), (SELECT $node_id FROM concert WHERE concert_id = 1))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 3), (SELECT $node_id FROM concert WHERE concert_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 3), (SELECT $node_id FROM concert WHERE concert_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 3), (SELECT $node_id FROM concert WHERE concert_id = 4))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 3), (SELECT $node_id FROM concert WHERE concert_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 3), (SELECT $node_id FROM concert WHERE concert_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 4), (SELECT $node_id FROM concert WHERE concert_id = 1))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 4), (SELECT $node_id FROM concert WHERE concert_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 4), (SELECT $node_id FROM concert WHERE concert_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 4), (SELECT $node_id FROM concert WHERE concert_id = 4))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 4), (SELECT $node_id FROM concert WHERE concert_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 4), (SELECT $node_id FROM concert WHERE concert_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 5), (SELECT $node_id FROM concert WHERE concert_id = 1))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 5), (SELECT $node_id FROM concert WHERE concert_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 5), (SELECT $node_id FROM concert WHERE concert_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 5), (SELECT $node_id FROM concert WHERE concert_id = 4))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 5), (SELECT $node_id FROM concert WHERE concert_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 5), (SELECT $node_id FROM concert WHERE concert_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 6), (SELECT $node_id FROM concert WHERE concert_id = 1))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 6), (SELECT $node_id FROM concert WHERE concert_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 6), (SELECT $node_id FROM concert WHERE concert_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 6), (SELECT $node_id FROM concert WHERE concert_id = 4))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 6), (SELECT $node_id FROM concert WHERE concert_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 6), (SELECT $node_id FROM concert WHERE concert_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 7), (SELECT $node_id FROM concert WHERE concert_id = 1))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 7), (SELECT $node_id FROM concert WHERE concert_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 7), (SELECT $node_id FROM concert WHERE concert_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 7), (SELECT $node_id FROM concert WHERE concert_id = 4))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 7), (SELECT $node_id FROM concert WHERE concert_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 7), (SELECT $node_id FROM concert WHERE concert_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 9), (SELECT $node_id FROM concert WHERE concert_id = 1))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 9), (SELECT $node_id FROM concert WHERE concert_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 9), (SELECT $node_id FROM concert WHERE concert_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 9), (SELECT $node_id FROM concert WHERE concert_id = 4))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 9), (SELECT $node_id FROM concert WHERE concert_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 9), (SELECT $node_id FROM concert WHERE concert_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 10), (SELECT $node_id FROM concert WHERE concert_id = 1))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 10), (SELECT $node_id FROM concert WHERE concert_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 10), (SELECT $node_id FROM concert WHERE concert_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 10), (SELECT $node_id FROM concert WHERE concert_id = 4))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 10), (SELECT $node_id FROM concert WHERE concert_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 10), (SELECT $node_id FROM concert WHERE concert_id = 6))
;

INSERT INTO stadium_to_singer_in_concert VALUES
	 ((SELECT $node_id FROM stadium WHERE stadium_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 3 AND singer_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 4 AND singer_id = 4))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 6 AND singer_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 3 AND singer_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 4 AND singer_id = 4))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 6 AND singer_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 3 AND singer_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 4 AND singer_id = 4))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 6 AND singer_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 3 AND singer_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 4 AND singer_id = 4))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 6 AND singer_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 3 AND singer_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 4 AND singer_id = 4))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 6 AND singer_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 3 AND singer_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 4 AND singer_id = 4))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 6 AND singer_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 7), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 7), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 7), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 7), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 7), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 7), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 3 AND singer_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 7), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 4 AND singer_id = 4))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 7), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 7), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 7), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 6 AND singer_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 9), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 9), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 9), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 9), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 9), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 9), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 3 AND singer_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 9), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 4 AND singer_id = 4))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 9), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 9), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 9), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 6 AND singer_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 10), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 2))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 10), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 10), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 10), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 10), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 10), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 3 AND singer_id = 5))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 10), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 4 AND singer_id = 4))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 10), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 6))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 10), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 3))
	,((SELECT $node_id FROM stadium WHERE stadium_id = 10), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 6 AND singer_id = 2))
;

INSERT INTO singer_to_concert VALUES
	 ((SELECT $node_id FROM singer WHERE singer_id = 1), (SELECT $node_id FROM concert WHERE concert_id = 1))
	,((SELECT $node_id FROM singer WHERE singer_id = 1), (SELECT $node_id FROM concert WHERE concert_id = 2))
	,((SELECT $node_id FROM singer WHERE singer_id = 1), (SELECT $node_id FROM concert WHERE concert_id = 3))
	,((SELECT $node_id FROM singer WHERE singer_id = 1), (SELECT $node_id FROM concert WHERE concert_id = 4))
	,((SELECT $node_id FROM singer WHERE singer_id = 1), (SELECT $node_id FROM concert WHERE concert_id = 5))
	,((SELECT $node_id FROM singer WHERE singer_id = 1), (SELECT $node_id FROM concert WHERE concert_id = 6))
	,((SELECT $node_id FROM singer WHERE singer_id = 2), (SELECT $node_id FROM concert WHERE concert_id = 1))
	,((SELECT $node_id FROM singer WHERE singer_id = 2), (SELECT $node_id FROM concert WHERE concert_id = 2))
	,((SELECT $node_id FROM singer WHERE singer_id = 2), (SELECT $node_id FROM concert WHERE concert_id = 3))
	,((SELECT $node_id FROM singer WHERE singer_id = 2), (SELECT $node_id FROM concert WHERE concert_id = 4))
	,((SELECT $node_id FROM singer WHERE singer_id = 2), (SELECT $node_id FROM concert WHERE concert_id = 5))
	,((SELECT $node_id FROM singer WHERE singer_id = 2), (SELECT $node_id FROM concert WHERE concert_id = 6))
	,((SELECT $node_id FROM singer WHERE singer_id = 3), (SELECT $node_id FROM concert WHERE concert_id = 1))
	,((SELECT $node_id FROM singer WHERE singer_id = 3), (SELECT $node_id FROM concert WHERE concert_id = 2))
	,((SELECT $node_id FROM singer WHERE singer_id = 3), (SELECT $node_id FROM concert WHERE concert_id = 3))
	,((SELECT $node_id FROM singer WHERE singer_id = 3), (SELECT $node_id FROM concert WHERE concert_id = 4))
	,((SELECT $node_id FROM singer WHERE singer_id = 3), (SELECT $node_id FROM concert WHERE concert_id = 5))
	,((SELECT $node_id FROM singer WHERE singer_id = 3), (SELECT $node_id FROM concert WHERE concert_id = 6))
	,((SELECT $node_id FROM singer WHERE singer_id = 4), (SELECT $node_id FROM concert WHERE concert_id = 1))
	,((SELECT $node_id FROM singer WHERE singer_id = 4), (SELECT $node_id FROM concert WHERE concert_id = 2))
	,((SELECT $node_id FROM singer WHERE singer_id = 4), (SELECT $node_id FROM concert WHERE concert_id = 3))
	,((SELECT $node_id FROM singer WHERE singer_id = 4), (SELECT $node_id FROM concert WHERE concert_id = 4))
	,((SELECT $node_id FROM singer WHERE singer_id = 4), (SELECT $node_id FROM concert WHERE concert_id = 5))
	,((SELECT $node_id FROM singer WHERE singer_id = 4), (SELECT $node_id FROM concert WHERE concert_id = 6))
	,((SELECT $node_id FROM singer WHERE singer_id = 5), (SELECT $node_id FROM concert WHERE concert_id = 1))
	,((SELECT $node_id FROM singer WHERE singer_id = 5), (SELECT $node_id FROM concert WHERE concert_id = 2))
	,((SELECT $node_id FROM singer WHERE singer_id = 5), (SELECT $node_id FROM concert WHERE concert_id = 3))
	,((SELECT $node_id FROM singer WHERE singer_id = 5), (SELECT $node_id FROM concert WHERE concert_id = 4))
	,((SELECT $node_id FROM singer WHERE singer_id = 5), (SELECT $node_id FROM concert WHERE concert_id = 5))
	,((SELECT $node_id FROM singer WHERE singer_id = 5), (SELECT $node_id FROM concert WHERE concert_id = 6))
	,((SELECT $node_id FROM singer WHERE singer_id = 6), (SELECT $node_id FROM concert WHERE concert_id = 1))
	,((SELECT $node_id FROM singer WHERE singer_id = 6), (SELECT $node_id FROM concert WHERE concert_id = 2))
	,((SELECT $node_id FROM singer WHERE singer_id = 6), (SELECT $node_id FROM concert WHERE concert_id = 3))
	,((SELECT $node_id FROM singer WHERE singer_id = 6), (SELECT $node_id FROM concert WHERE concert_id = 4))
	,((SELECT $node_id FROM singer WHERE singer_id = 6), (SELECT $node_id FROM concert WHERE concert_id = 5))
	,((SELECT $node_id FROM singer WHERE singer_id = 6), (SELECT $node_id FROM concert WHERE concert_id = 6))
;

INSERT INTO singer_to_singer_in_concert VALUES
	 ((SELECT $node_id FROM singer WHERE singer_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 2))
	,((SELECT $node_id FROM singer WHERE singer_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 3))
	,((SELECT $node_id FROM singer WHERE singer_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 5))
	,((SELECT $node_id FROM singer WHERE singer_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 3))
	,((SELECT $node_id FROM singer WHERE singer_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 6))
	,((SELECT $node_id FROM singer WHERE singer_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 3 AND singer_id = 5))
	,((SELECT $node_id FROM singer WHERE singer_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 4 AND singer_id = 4))
	,((SELECT $node_id FROM singer WHERE singer_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 6))
	,((SELECT $node_id FROM singer WHERE singer_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 3))
	,((SELECT $node_id FROM singer WHERE singer_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 6 AND singer_id = 2))
	,((SELECT $node_id FROM singer WHERE singer_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 2))
	,((SELECT $node_id FROM singer WHERE singer_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 3))
	,((SELECT $node_id FROM singer WHERE singer_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 5))
	,((SELECT $node_id FROM singer WHERE singer_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 3))
	,((SELECT $node_id FROM singer WHERE singer_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 6))
	,((SELECT $node_id FROM singer WHERE singer_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 3 AND singer_id = 5))
	,((SELECT $node_id FROM singer WHERE singer_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 4 AND singer_id = 4))
	,((SELECT $node_id FROM singer WHERE singer_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 6))
	,((SELECT $node_id FROM singer WHERE singer_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 3))
	,((SELECT $node_id FROM singer WHERE singer_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 6 AND singer_id = 2))
	,((SELECT $node_id FROM singer WHERE singer_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 2))
	,((SELECT $node_id FROM singer WHERE singer_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 3))
	,((SELECT $node_id FROM singer WHERE singer_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 5))
	,((SELECT $node_id FROM singer WHERE singer_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 3))
	,((SELECT $node_id FROM singer WHERE singer_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 6))
	,((SELECT $node_id FROM singer WHERE singer_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 3 AND singer_id = 5))
	,((SELECT $node_id FROM singer WHERE singer_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 4 AND singer_id = 4))
	,((SELECT $node_id FROM singer WHERE singer_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 6))
	,((SELECT $node_id FROM singer WHERE singer_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 3))
	,((SELECT $node_id FROM singer WHERE singer_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 6 AND singer_id = 2))
	,((SELECT $node_id FROM singer WHERE singer_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 2))
	,((SELECT $node_id FROM singer WHERE singer_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 3))
	,((SELECT $node_id FROM singer WHERE singer_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 5))
	,((SELECT $node_id FROM singer WHERE singer_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 3))
	,((SELECT $node_id FROM singer WHERE singer_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 6))
	,((SELECT $node_id FROM singer WHERE singer_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 3 AND singer_id = 5))
	,((SELECT $node_id FROM singer WHERE singer_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 4 AND singer_id = 4))
	,((SELECT $node_id FROM singer WHERE singer_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 6))
	,((SELECT $node_id FROM singer WHERE singer_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 3))
	,((SELECT $node_id FROM singer WHERE singer_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 6 AND singer_id = 2))
	,((SELECT $node_id FROM singer WHERE singer_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 2))
	,((SELECT $node_id FROM singer WHERE singer_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 3))
	,((SELECT $node_id FROM singer WHERE singer_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 5))
	,((SELECT $node_id FROM singer WHERE singer_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 3))
	,((SELECT $node_id FROM singer WHERE singer_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 6))
	,((SELECT $node_id FROM singer WHERE singer_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 3 AND singer_id = 5))
	,((SELECT $node_id FROM singer WHERE singer_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 4 AND singer_id = 4))
	,((SELECT $node_id FROM singer WHERE singer_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 6))
	,((SELECT $node_id FROM singer WHERE singer_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 3))
	,((SELECT $node_id FROM singer WHERE singer_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 6 AND singer_id = 2))
	,((SELECT $node_id FROM singer WHERE singer_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 2))
	,((SELECT $node_id FROM singer WHERE singer_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 3))
	,((SELECT $node_id FROM singer WHERE singer_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 5))
	,((SELECT $node_id FROM singer WHERE singer_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 3))
	,((SELECT $node_id FROM singer WHERE singer_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 6))
	,((SELECT $node_id FROM singer WHERE singer_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 3 AND singer_id = 5))
	,((SELECT $node_id FROM singer WHERE singer_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 4 AND singer_id = 4))
	,((SELECT $node_id FROM singer WHERE singer_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 6))
	,((SELECT $node_id FROM singer WHERE singer_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 3))
	,((SELECT $node_id FROM singer WHERE singer_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 6 AND singer_id = 2))
;

INSERT INTO concert_to_singer_in_concert VALUES
	 ((SELECT $node_id FROM concert WHERE concert_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 2))
	,((SELECT $node_id FROM concert WHERE concert_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 3))
	,((SELECT $node_id FROM concert WHERE concert_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 5))
	,((SELECT $node_id FROM concert WHERE concert_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 3))
	,((SELECT $node_id FROM concert WHERE concert_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 6))
	,((SELECT $node_id FROM concert WHERE concert_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 3 AND singer_id = 5))
	,((SELECT $node_id FROM concert WHERE concert_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 4 AND singer_id = 4))
	,((SELECT $node_id FROM concert WHERE concert_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 6))
	,((SELECT $node_id FROM concert WHERE concert_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 3))
	,((SELECT $node_id FROM concert WHERE concert_id = 1), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 6 AND singer_id = 2))
	,((SELECT $node_id FROM concert WHERE concert_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 2))
	,((SELECT $node_id FROM concert WHERE concert_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 3))
	,((SELECT $node_id FROM concert WHERE concert_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 5))
	,((SELECT $node_id FROM concert WHERE concert_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 3))
	,((SELECT $node_id FROM concert WHERE concert_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 6))
	,((SELECT $node_id FROM concert WHERE concert_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 3 AND singer_id = 5))
	,((SELECT $node_id FROM concert WHERE concert_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 4 AND singer_id = 4))
	,((SELECT $node_id FROM concert WHERE concert_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 6))
	,((SELECT $node_id FROM concert WHERE concert_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 3))
	,((SELECT $node_id FROM concert WHERE concert_id = 2), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 6 AND singer_id = 2))
	,((SELECT $node_id FROM concert WHERE concert_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 2))
	,((SELECT $node_id FROM concert WHERE concert_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 3))
	,((SELECT $node_id FROM concert WHERE concert_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 5))
	,((SELECT $node_id FROM concert WHERE concert_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 3))
	,((SELECT $node_id FROM concert WHERE concert_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 6))
	,((SELECT $node_id FROM concert WHERE concert_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 3 AND singer_id = 5))
	,((SELECT $node_id FROM concert WHERE concert_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 4 AND singer_id = 4))
	,((SELECT $node_id FROM concert WHERE concert_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 6))
	,((SELECT $node_id FROM concert WHERE concert_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 3))
	,((SELECT $node_id FROM concert WHERE concert_id = 3), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 6 AND singer_id = 2))
	,((SELECT $node_id FROM concert WHERE concert_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 2))
	,((SELECT $node_id FROM concert WHERE concert_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 3))
	,((SELECT $node_id FROM concert WHERE concert_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 5))
	,((SELECT $node_id FROM concert WHERE concert_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 3))
	,((SELECT $node_id FROM concert WHERE concert_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 6))
	,((SELECT $node_id FROM concert WHERE concert_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 3 AND singer_id = 5))
	,((SELECT $node_id FROM concert WHERE concert_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 4 AND singer_id = 4))
	,((SELECT $node_id FROM concert WHERE concert_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 6))
	,((SELECT $node_id FROM concert WHERE concert_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 3))
	,((SELECT $node_id FROM concert WHERE concert_id = 4), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 6 AND singer_id = 2))
	,((SELECT $node_id FROM concert WHERE concert_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 2))
	,((SELECT $node_id FROM concert WHERE concert_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 3))
	,((SELECT $node_id FROM concert WHERE concert_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 5))
	,((SELECT $node_id FROM concert WHERE concert_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 3))
	,((SELECT $node_id FROM concert WHERE concert_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 6))
	,((SELECT $node_id FROM concert WHERE concert_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 3 AND singer_id = 5))
	,((SELECT $node_id FROM concert WHERE concert_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 4 AND singer_id = 4))
	,((SELECT $node_id FROM concert WHERE concert_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 6))
	,((SELECT $node_id FROM concert WHERE concert_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 3))
	,((SELECT $node_id FROM concert WHERE concert_id = 5), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 6 AND singer_id = 2))
	,((SELECT $node_id FROM concert WHERE concert_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 2))
	,((SELECT $node_id FROM concert WHERE concert_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 3))
	,((SELECT $node_id FROM concert WHERE concert_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 1 AND singer_id = 5))
	,((SELECT $node_id FROM concert WHERE concert_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 3))
	,((SELECT $node_id FROM concert WHERE concert_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 2 AND singer_id = 6))
	,((SELECT $node_id FROM concert WHERE concert_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 3 AND singer_id = 5))
	,((SELECT $node_id FROM concert WHERE concert_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 4 AND singer_id = 4))
	,((SELECT $node_id FROM concert WHERE concert_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 6))
	,((SELECT $node_id FROM concert WHERE concert_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 5 AND singer_id = 3))
	,((SELECT $node_id FROM concert WHERE concert_id = 6), (SELECT $node_id FROM singer_in_concert WHERE concert_id = 6 AND singer_id = 2))
;

