
create table Student (
	stuid    	integer primary key,
	lname		varchar(12),
	fname		varchar(12),
	age		integer,
	sex		varchar(1),
	major		integer,
	advisor		integer,
	city_code	varchar(3)
) AS NODE;


create table Has_Pet (
	stuid		integer,
	petid		integer,
	foreign key(petid) references pets(petid),
	foreign key(stuid) references student(stuid)
) AS NODE;


create table Pets (
	petid		integer primary key,
	pettype		varchar(20),
	pet_age integer,
	weight FLOAT
) AS NODE;

INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1001, 'Smith', 'Linda', 18, 'F', 600, 1121, 'BAL');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1002, 'Kim', 'Tracy', 19, 'F', 600, 7712, 'HKG');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1003, 'Jones', 'Shiela', 21, 'F', 600, 7792, 'WAS');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1004, 'Kumar', 'Dinesh', 20, 'M', 600, 8423, 'CHI');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1005, 'Gompers', 'Paul', 26, 'M', 600, 1121, 'YYZ');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1006, 'Schultz', 'Andy', 18, 'M', 600, 1148, 'BAL');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1007, 'Apap', 'Lisa', 18, 'F', 600, 8918, 'PIT');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1008, 'Nelson', 'Jandy', 20, 'F', 600, 9172, 'BAL');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1009, 'Tai', 'Eric', 19, 'M', 600, 2192, 'YYZ');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1010, 'Lee', 'Derek', 17, 'M', 600, 2192, 'HOU');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1011, 'Adams', 'David', 22, 'M', 600, 1148, 'PHL');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1012, 'Davis', 'Steven', 20, 'M', 600, 7723, 'PIT');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1014, 'Norris', 'Charles', 18, 'M', 600, 8741, 'DAL');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1015, 'Lee', 'Susan', 16, 'F', 600, 8721, 'HKG');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1016, 'Schwartz', 'Mark', 17, 'M', 600, 2192, 'DET');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1017, 'Wilson', 'Bruce', 27, 'M', 600, 1148, 'LON');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1018, 'Leighton', 'Michael', 20, 'M', 600, 1121, 'PIT');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1019, 'Pang', 'Arthur', 18, 'M', 600, 2192, 'WAS');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1020, 'Thornton', 'Ian', 22, 'M', 520, 7271, 'NYC');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1021, 'Andreou', 'George', 19, 'M', 520, 8722, 'NYC');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1022, 'Woods', 'Michael', 17, 'M', 540, 8722, 'PHL');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1023, 'Shieber', 'David', 20, 'M', 520, 8722, 'NYC');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1024, 'Prater', 'Stacy', 18, 'F', 540, 7271, 'BAL');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1025, 'Goldman', 'Mark', 18, 'M', 520, 7134, 'PIT');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1026, 'Pang', 'Eric', 19, 'M', 520, 7134, 'HKG');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1027, 'Brody', 'Paul', 18, 'M', 520, 8723, 'LOS');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1028, 'Rugh', 'Eric', 20, 'M', 550, 2311, 'ROC');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1029, 'Han', 'Jun', 17, 'M', 100, 2311, 'PEK');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1030, 'Cheng', 'Lisa', 21, 'F', 550, 2311, 'SFO');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1031, 'Smith', 'Sarah', 20, 'F', 550, 8772, 'PHL');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1032, 'Brown', 'Eric', 20, 'M', 550, 8772, 'ATL');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1033, 'Simms', 'William', 18, 'M', 550, 8772, 'NAR');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1034, 'Epp', 'Eric', 18, 'M', 50, 5718, 'BOS');
INSERT INTO student (stuid, lname, fname, age, sex, major, advisor, city_code) VALUES (1035, 'Schmidt', 'Sarah', 26, 'F', 50, 5718, 'WAS');
INSERT INTO has_pet (stuid, petid) VALUES (1001, 2001);

INSERT INTO has_pet (stuid, petid) VALUES (1002, 2002);
INSERT INTO has_pet (stuid, petid) VALUES (1002, 2003);
INSERT INTO pets (petid, pettype, pet_age, weight) VALUES (2001, 'cat', 3, 12);

INSERT INTO pets (petid, pettype, pet_age, weight) VALUES (2002, 'dog', 2, '13.4');
INSERT INTO pets (petid, pettype, pet_age, weight) VALUES (2003, 'dog', 1, '9.3');

CREATE TABLE student_to_pets AS EDGE;

INSERT INTO student_to_pets VALUES
	 ((SELECT $node_id FROM student WHERE stuid = 1001), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1001), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1001), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1002), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1002), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1002), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1003), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1003), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1003), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1004), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1004), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1004), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1005), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1005), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1005), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1006), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1006), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1006), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1007), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1007), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1007), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1008), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1008), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1008), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1009), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1009), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1009), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1010), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1010), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1010), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1011), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1011), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1011), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1012), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1012), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1012), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1014), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1014), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1014), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1015), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1015), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1015), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1016), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1016), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1016), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1017), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1017), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1017), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1018), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1018), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1018), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1019), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1019), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1019), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1020), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1020), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1020), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1021), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1021), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1021), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1022), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1022), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1022), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1023), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1023), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1023), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1024), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1024), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1024), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1025), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1025), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1025), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1026), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1026), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1026), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1027), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1027), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1027), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1028), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1028), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1028), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1029), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1029), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1029), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1030), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1030), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1030), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1031), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1031), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1031), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1032), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1032), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1032), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1033), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1033), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1033), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1034), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1034), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1034), (SELECT $node_id FROM pets WHERE petid = 2003))
	,((SELECT $node_id FROM student WHERE stuid = 1035), (SELECT $node_id FROM pets WHERE petid = 2001))
	,((SELECT $node_id FROM student WHERE stuid = 1035), (SELECT $node_id FROM pets WHERE petid = 2002))
	,((SELECT $node_id FROM student WHERE stuid = 1035), (SELECT $node_id FROM pets WHERE petid = 2003))
;

