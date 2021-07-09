
CREATE TABLE 'airlines' (
	uid integer primary key,
	airline VARCHAR(100),
	abbreviation VARCHAR(100),
	country VARCHAR(100)
) AS NODE;


CREATE TABLE 'airports' (
	city VARCHAR(100),
	airportcode VARCHAR(100) primary key,
	airportname VARCHAR(100),
	country VARCHAR(100),
	countryabbrev VARCHAR(100)
) AS NODE;


CREATE TABLE 'flights' (
	airline integer,
	flightno integer,
	sourceairport VARCHAR(100),
	destairport VARCHAR(100),
	primary key(airline, flightno),
	foreign key (sourceairport) references airports(airportcode),
	foreign key (destairport) references airports(airportcode)
) AS NODE;


CREATE TABLE 'airlines'_to_'airports' AS EDGE;
CREATE TABLE 'airlines'_to_'flights' AS EDGE;
CREATE TABLE 'airports'_to_'flights' AS EDGE;

