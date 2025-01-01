USE music_store;
CREATE TABLE artist (
	artistId INT NOT NULL,
	name VARCHAR(120),
    PRIMARY KEY (artistId)
);

CREATE TABLE album (
	albumId INT NOT NULL,
    title VARCHAR (120),
    artistId INT,
    PRIMARY KEY (albumId),
    FOREIGN KEY (artistId) REFERENCES artist(artistId)
);

CREATE TABLE playlist
(
	playlistId VARCHAR(50) NOT NULL,
    name VARCHAR (120),
    PRIMARY KEY (playlistId)
);
ALTER TABLE playlist MODIFY playlistId INT NOT NULL;

CREATE TABLE genre (
	genereId INT NOT NULL,
    name VARCHAR (120),
    PRIMARY KEY (genereId)
);
ALTER TABLE genre CHANGE genereId genreId INT NOT NULL;

CREATE TABLE mediatype (
	mediatypeId INT NOT NULL,
    name VARCHAR (120),
    PRIMARY KEY (mediatypeId)
);

CREATE TABLE track (
	trackId INT NOT NULL,
    name VARCHAR (150),
    albumId INT,
    mediatypeId INT,
    genreId INT,
    composer VARCHAR (190),
    milliseconds BIGINT,
    bytes BIGINT,
    unitPrice DECIMAL(3,2),
    PRIMARY KEY (trackId),
    FOREIGN KEY (albumId) REFERENCES album (albumId),
    FOREIGN KEY (mediatypeId) REFERENCES mediatype (mediatypeId),
    FOREIGN KEY (genreId) REFERENCES genre (genreId)
);

CREATE TABLE playlisttrack (
	playlistId INT,
    trackId INT,
    FOREIGN KEY (playlistId) REFERENCES playlist (playlistId),
    FOREIGN KEY (trackId) REFERENCES track (trackId)
);

CREATE TABLE employee
(
	employeeId INT NOT NULL,
    lastName VARCHAR (50),
    firstName VARCHAR (50),
    title VARCHAR (100),
    reports_to INT,
    levels VARCHAR (5),
    birthdate DATETIME,
    hire_date DATETIME,
    address VARCHAR (150),
    city VARCHAR (120),
    state VARCHAR (20),
    country VARCHAR (50),
    postalcode VARCHAR (50),
    phone VARCHAR(150),
    fax VARCHAR (150),
    email VARCHAR(150),
    PRIMARY KEY (employeeId),
    FOREIGN KEY (reports_to) REFERENCES employee (employeeId)
);
INSERT INTO employee(employeeId,lastName,firstName,title,reports_to,levels,birthdate,hire_date,address,city,state,country,postalcode,phone,fax,email) VALUES (1,'Adams','Andrew','General Manager',9,'L6',str_to_date('18-02-1962 00:00','%d-%m-%Y %H:%i'),str_to_date('14-08-2016 00:00','%d-%m-%Y %H:%i'),'11120 Jasper Ave NW','Edmonton','AB','Canada','T5K 2N1','+1 (780) 428-9482','+1 (780) 428-3457','andrew@chinookcorp.com');
INSERT INTO employee(employeeId,lastName,firstName,title,reports_to,levels,birthdate,hire_date,address,city,state,country,postalcode,phone,fax,email) VALUES (2,'Edwards','Nancy','Sales Manager',1,'L4',str_to_date('08-12-1958 00:00','%d-%m-%Y %H:%i'),str_to_date('01-05-2016 00:00','%d-%m-%Y %H:%i'),'825 8 Ave SW','Calgary','AB','Canada','T2P 2T3','+1 (403) 262-3443','+1 (403) 262-3322','nancy@chinookcorp.com');
INSERT INTO employee(employeeId,lastName,firstName,title,reports_to,levels,birthdate,hire_date,address,city,state,country,postalcode,phone,fax,email) VALUES (3,'Peacock','Jane','Sales Support Agent',2,'L1',str_to_date('29-08-1973 00:00','%d-%m-%Y %H:%i'),str_to_date('01-04-2017 00:00','%d-%m-%Y %H:%i'),'1111 6 Ave SW','Calgary','AB','Canada','T2P 5M5','+1 (403) 262-3443','+1 (403) 262-6712','jane@chinookcorp.com');
INSERT INTO employee(employeeId,lastName,firstName,title,reports_to,levels,birthdate,hire_date,address,city,state,country,postalcode,phone,fax,email) VALUES (4,'Park','Margaret','Sales Support Agent',2,'L1',str_to_date('19-09-1947 00:00','%d-%m-%Y %H:%i'),str_to_date('03-05-2017 00:00','%d-%m-%Y %H:%i'),'683 10 Street SW','Calgary','AB','Canada','T2P 5G3','+1 (403) 263-4423','+1 (403) 263-4289','margaret@chinookcorp.com');
INSERT INTO employee(employeeId,lastName,firstName,title,reports_to,levels,birthdate,hire_date,address,city,state,country,postalcode,phone,fax,email) VALUES (5,'Johnson','Steve','Sales Support Agent',2,'L1',str_to_date('03-03-1965 00:00','%d-%m-%Y %H:%i'),str_to_date('17-10-2017 00:00','%d-%m-%Y %H:%i'),'7727B 41 Ave','Calgary','AB','Canada','T3B 1Y7','1 (780) 836-9987','1 (780) 836-9543','steve@chinookcorp.com');
INSERT INTO employee(employeeId,lastName,firstName,title,reports_to,levels,birthdate,hire_date,address,city,state,country,postalcode,phone,fax,email) VALUES (6,'Mitchell','Michael','IT Manager',1,'L3',str_to_date('01-07-1973 00:00','%d-%m-%Y %H:%i'),str_to_date('17-10-2016 00:00','%d-%m-%Y %H:%i'),'5827 Bowness Road NW','Calgary','AB','Canada','T3B 0C5','+1 (403) 246-9887','+1 (403) 246-9899','michael@chinookcorp.com');
INSERT INTO employee(employeeId,lastName,firstName,title,reports_to,levels,birthdate,hire_date,address,city,state,country,postalcode,phone,fax,email) VALUES (7,'King','Robert','IT Staff',6,'L2',str_to_date('29-05-1970 00:00','%d-%m-%Y %H:%i'),str_to_date('02-01-2017 00:00','%d-%m-%Y %H:%i'),'590 Columbia Boulevard West','Lethbridge','AB','Canada','T1K 5N8','+1 (403) 456-9986','+1 (403) 456-8485','robert@chinookcorp.com');
INSERT INTO employee(employeeId,lastName,firstName,title,reports_to,levels,birthdate,hire_date,address,city,state,country,postalcode,phone,fax,email) VALUES (8,'Callahan','Laura','IT Staff',6,'L2',str_to_date('09-01-1968 00:00','%d-%m-%Y %H:%i'),str_to_date('04-03-2017 00:00','%d-%m-%Y %H:%i'),'923 7 ST NW','Lethbridge','AB','Canada','T1H 1Y8','+1 (403) 467-3351','+1 (403) 467-8772','laura@chinookcorp.com');
INSERT INTO employee(employeeId,lastName,firstName,title,reports_to,levels,birthdate,hire_date,address,city,state,country,postalcode,phone,fax,email) VALUES (9,'Madan','Mohan','Senior General Manager',NULL,'L7',str_to_date('26-01-1961 00:00','%d-%m-%Y %H:%i'),str_to_date('14-01-2016 00:00','%d-%m-%Y %H:%i'),'1008 Vrinda Ave MT','Edmonton','AB','Canada','T5K 2N1','+1 (780) 428-9482','+1 (780) 428-3457','madan.mohan@chinookcorp.com');

CREATE TABLE customer (
	customerId INT NOT NULL,
    firstName VARCHAR (50),
    lastName VARCHAR (50),
    company VARCHAR (120),
    address VARCHAR (150),
    city VARCHAR (120),
    state VARCHAR (50),
    country VARCHAR (50),
    postalcode VARCHAR (50),
    phone VARCHAR(150),
    fax VARCHAR (150),
    email VARCHAR(150),
    supportrepId INT,
    PRIMARY KEY (customerId),
    FOREIGN KEY (supportrepId) REFERENCES employee (employeeId)
);

CREATE TABLE invoice (
	invoiceId INT NOT NULL,
    customerId INT,
    InvoiceDate DATE,
    billingAddress VARCHAR (120),
    billingCity VARCHAR (120),
    billingState VARCHAR (120),
    billingCountry VARCHAR (120),
    billingPostalcode VARCHAR (120),
    total DECIMAL(5,3),
    PRIMARY KEY (invoiceId),
    FOREIGN KEY (customerId) REFERENCES customer (customerId)
);
	
CREATE TABLE invoiceline (
	invoicelineId INT NOT NULL,
    invoiceId INT,
    trackId INT,
    unitPrice DECIMAL (3,2),
    quantity INT,
    PRIMARY KEY (invoicelineId),
    FOREIGN KEY (invoiceId) REFERENCES invoice (invoiceId),
    FOREIGN KEY (trackId) REFERENCES track (trackId)
);

-- TABLES AND SCHEMA DESIGNED AND TABLES ARE POPULATED USING EITHER INSERT STATEMENT OR BY IMPORTING DATA FROM CSV FILES.