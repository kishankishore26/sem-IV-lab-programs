--1. Insurance Database 
 
--Consider the Insurance database given below.  
--PERSON (driver – id #: String, name: string, address: string) 
--CAR (regno: string, model: string, year: int) 
--ACCIDENT (report-number: int, accd-date: date, location: string) 
--OWNS (driver-id #: string, regno: string) 
--PARTICIPATED (driver-id: string, Regno: string, report-number: int, damage amount: int) 
 
--1. Find the total number of people who owned cars that were involved in accidents in 1989. 
--2. Find the number of accidents in which the cars belonging to “John Smith” were involved. 
--3. Update the damage amount for the car with reg number “KA-12” in the accident with report number “1” to $3000.

CREATE DATABASE insurancedatabase;

USE insurancedatabase;

--PERSON (driver – id #: String, name: string, address: string) 
CREATE TABLE PERSON ( 
    driverid VARCHAR(10), 
    fname CHAR(15) NOT NULL, 
    address VARCHAR(30), 
    PRIMARY KEY (driverid)   
);

INSERT INTO PERSON VALUES('111','John Smith' , 'SP Road, Bangalore 12')
INSERT INTO PERSON VALUES('112','Ramesh Babu' , 'KP Nagar, Udupi 13')
INSERT INTO PERSON VALUES('113','Raju SK' , 'KS Circle, Mangalore 12')
INSERT INTO PERSON VALUES('114','Ramesh Babu' , 'AS Road, Bangalore 14')
INSERT INTO PERSON VALUES('115','Alica wallace' , 'SS Road, Karkala 16')

--CAR (regno: string, model: string, year: int) 
CREATE TABLE CAR ( 
    regno VARCHAR(10), 
    model VARCHAR(10) NOT NULL, 
    cyear INT, 
    PRIMARY KEY(regno)  
);

INSERT INTO CAR VALUES('KA-12','FORD',1980)
INSERT INTO CAR VALUES('KA-13','SWIFT',1990)
INSERT INTO CAR VALUES('MH-11','INDIGO',1998)
INSERT INTO CAR VALUES('AP-10','SWIFT',1988)
INSERT INTO CAR VALUES('TN-11','FORD',2001)
INSERT INTO CAR VALUES('TN-12','TOYATA',2001)
INSERT INTO CAR VALUES('MH-14','SWIFT',2001)
INSERT INTO CAR VALUES('KL-15','TOYATA',2001)
INSERT INTO CAR VALUES('KL-4','INDIGO',2001)
INSERT INTO CAR VALUES('AP-05','SANTRO',2001)


--ACCIDENT (report-number: int, accd-date: date, location: string) 
CREATE TABLE ACCIDENT ( 
    reportno INT, 
    accdate DATETIME, 
    location VARCHAR(20), 
    PRIMARY KEY(reportno) 
);

INSERT INTO ACCIDENT VALUES(1,'1998-07-22','Nitte')
INSERT INTO ACCIDENT VALUES(2,'1998-07-22','Karkala')
INSERT INTO ACCIDENT VALUES(12,'1998-07-22','Mangalore')
INSERT INTO ACCIDENT VALUES(3,'1998-07-23','Mangalore')
INSERT INTO ACCIDENT VALUES(4,'1990-09-09','Bhatkal')
INSERT INTO ACCIDENT VALUES(5,'2001-02-22','Udupi')
INSERT INTO ACCIDENT VALUES(6,'1990-09-09','Udupi')
INSERT INTO ACCIDENT VALUES(15,'1981-07-22','Udupi')

--  Added missing report numbers to avoid FK errors
INSERT INTO ACCIDENT VALUES(7,'1999-01-01','Udupi')
INSERT INTO ACCIDENT VALUES(8,'1999-02-01','Udupi')
INSERT INTO ACCIDENT VALUES(9,'1999-03-01','Udupi')
INSERT INTO ACCIDENT VALUES(10,'1999-04-01','Udupi')
INSERT INTO ACCIDENT VALUES(11,'1999-05-01','Udupi')
INSERT INTO ACCIDENT VALUES(13,'1999-06-01','Udupi')
INSERT INTO ACCIDENT VALUES(14,'1999-07-01','Udupi')

--OWNS (driver-id #: string, regno: string) 
CREATE TABLE OWNS ( 
    driverid VARCHAR(10), 
    regno VARCHAR(10),
    PRIMARY KEY(driverid, regno),  
    FOREIGN KEY(driverid) REFERENCES PERSON(driverid)
        ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY(regno) REFERENCES CAR(regno)
        ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE(regno) 
);

INSERT INTO OWNS VALUES('111','KA-13')
INSERT INTO OWNS VALUES('111','KA-12')
INSERT INTO OWNS VALUES('111','MH-11')
INSERT INTO OWNS VALUES('112','AP-10')
INSERT INTO OWNS VALUES('112','TN-11')
INSERT INTO OWNS VALUES('113','TN-12')
INSERT INTO OWNS VALUES('113','KL-15')
INSERT INTO OWNS VALUES('114','AP-05')
INSERT INTO OWNS VALUES('114','KL-4')
INSERT INTO OWNS VALUES('115','MH-14')

--PARTICIPATED (driver-id: string, Regno: string, report-number: int, damage amount: int) 
CREATE TABLE PARTICIPATED ( 
    driverid VARCHAR(10), 
    regno VARCHAR(10), 
    reportno INT, 
    dmgamt INT, 
    PRIMARY KEY(driverid, regno, reportno), 
    FOREIGN KEY(driverid) REFERENCES PERSON(driverid)
        ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY(regno) REFERENCES CAR(regno)
        ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY(reportno) REFERENCES ACCIDENT(reportno)
        ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY(driverid, regno) REFERENCES OWNS(driverid, regno)
);

INSERT INTO PARTICIPATED VALUES('111','KA-12',1,20000)
INSERT INTO PARTICIPATED VALUES('111','KA-13',2,10000)
INSERT INTO PARTICIPATED VALUES('111','KA-12',3,60000)
INSERT INTO PARTICIPATED VALUES('111','KA-12',4,60000)
INSERT INTO PARTICIPATED VALUES('111','KA-12',5,60000)
INSERT INTO PARTICIPATED VALUES('111','KA-12',15,40000)
INSERT INTO PARTICIPATED VALUES('111','KA-13',6,10000)
INSERT INTO PARTICIPATED VALUES('111','MH-11',12,20000)

INSERT INTO PARTICIPATED VALUES('112','AP-10',7,30000)
INSERT INTO PARTICIPATED VALUES('112','TN-11',8,40000)
INSERT INTO PARTICIPATED VALUES('112','AP-10',13,20000)
INSERT INTO PARTICIPATED VALUES('112','TN-11',14,10000)

INSERT INTO PARTICIPATED VALUES('113','TN-12',9,40000)
INSERT INTO PARTICIPATED VALUES('113','KL-15',10,50000)
INSERT INTO PARTICIPATED VALUES('113','TN-12',11,20000)

--1. Find the total number of people who owned cars that were involved in accidents in 1989. 
select count(distinct P.driverid) as no_of_accident
from PARTICIPATED P
join ACCIDENT A on P.reportno=A.reportno
where A.accdate between '1998-01-01' and '1998-12-31'

--2. Find the number of accidents in which the cars belonging to “John Smith” were involved. 
select count(P.reportno) as no_of_accident
from PERSON PN
join OWNS O on PN.driverid=O.driverid
join PARTICIPATED P on PN.driverid=P.driverid and O.regno=P.regno
where PN.fname='John Smith'

--3. Update the damage amount for the car with reg number “KA-12” in the accident with report number “1” to 29000. 
update PARTICIPATED set dmgamt=29000
where regno='KA-12' and reportno='1'
