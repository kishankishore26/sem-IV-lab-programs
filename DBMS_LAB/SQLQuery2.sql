 
--Consider the following relations for an order processing database application in a company: 
 
--CUSTOMER (cust #: int, cname: string, city: string) 
--ORDER (order #: int, odate: date, cust #: int, ord-Amt: int) 
--ORDER – ITEM (order #: int, item #: int, qty: int) 
--ITEM (item #: int, unit price: int) 
--SHIPMENT (order #: int, warehouse#: int, ship-date: date) 
--WAREHOUSE (warehouse #: int, city: string) 
--1. Produce a listing: CUSTNAME, #oforders, AVG_ORDER_AMT, where the middle column is the total numbers of orders by the customer and the last column is the average order amount for that customer. 
--2. For each item that has more than two orders , list the item, number of orders that are  shipped from atleast two warehouses and total  quantity of items shipped 
--3. List the customers who have ordered for every item that the company produces 

CREATE DATABASE ORDER_ORDER

USE ORDER_ORDER

--CUSTOMER (cust #: int, cname: string, city: string) 

CREATE TABLE CUSTOMER(
	CUSTID INT,
	CNAME VARCHAR(20),
	CITY VARCHAR(10),
	PRIMARY KEY(CUSTID)
)
insert into CUSTOMER values (111,'John Smith', 'Karkala') 
insert into CUSTOMER values (112,'Ramesh N', 'Nitte')    
insert into CUSTOMER values (113,'Franklin', 'Karkala') 
insert into CUSTOMER values (114,'Alica', 'mangalore') 
insert into CUSTOMER values (115,'Raju', 'Udupi') 

--ORDER (order #: int, odate: date, cust #: int, ord-Amt: int) 

CREATE TABLE C_ORDER(
	ORDERID INT,
	ODATE DATETIME,
	CUSTID INT,
	OAMT INT,
	PRIMARY KEY(ORDERID),
	FOREIGN KEY(CUSTID) REFERENCES CUSTOMER(CUSTID) ON DELETE CASCADE ON UPDATE CASCADE
)

insert into C_ORDER values (201,'2001-08-03', 111,null) 
insert into C_ORDER values (202,'2002-08-03', 111,null) 
insert into C_ORDER values (203,'2001-08-04', 112,null) 
insert into C_ORDER values (204,'2004-02-01', 113,null) 
insert into C_ORDER values (205,'2001-04-02', 114,null) 
insert into C_ORDER values (206,'2005-02-01', 115,null) 
insert into C_ORDER values (207,'2008-04-01', 115,null) 
insert into C_ORDER values (209,'2008-02-01', 114,null) 
insert into C_ORDER values (208,'2008-12-01', 111,null) 
insert into C_ORDER values (200,'2008-11-01', 111,null) 
insert into C_ORDER values (210,'2008-10-01', 111,null) 

SELECT * FROM C_ORDER
UPDATE C_ORDER
SET OAMT = (
    SELECT SUM(OI.QTY * I.PRICE)
    FROM ORDER_ITEM OI
    JOIN ITEM I ON OI.ITEMID = I.ITEMID
    WHERE OI.ORDERID = C_ORDER.ORDERID
);

--ITEM (item #: int, unit price: int) 
CREATE TABLE ITEM(
	ITEMID INT,
	PRICE INT,
	PRIMARY KEY(ITEMID)
) 

insert into ITEM values (301,2000) 
insert into ITEM values (302,2000) 
insert into ITEM values (303,1000) 
insert into ITEM values (304,5000) 
insert into ITEM values (305,4000)

-- ORDER_ITEM (order #: int, item #: int, qty: int) 

CREATE TABLE ORDER_ITEM(
	ORDERID INT,
	ITEMID INT,
	QTY INT,
	PRIMARY KEY(ITEMID,ORDERID),
	FOREIGN KEY(ORDERID) REFERENCES C_ORDER(ORDERID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(ITEMID) REFERENCES ITEM(ITEMID) ON DELETE CASCADE ON UPDATE CASCADE
)

insert into ORDER_ITEM values (201,301,2) 
insert into ORDER_ITEM values (201,302,4) 
insert into ORDER_ITEM values (201,303,4) 
insert into ORDER_ITEM values (201,304,4) 
insert into ORDER_ITEM values (201,305,3) 
 
insert into ORDER_ITEM values (202,303,2) 
insert into ORDER_ITEM values (202,305,4) 
insert into ORDER_ITEM values (203,302,1) 
insert into ORDER_ITEM values (204,305,2) 
insert into ORDER_ITEM values (205,301,3) 
insert into ORDER_ITEM values (206,301,5) 

--SHIPMENT (order #: int, warehouse#: int, ship-date: date) 

CREATE TABLE SHIPMENT(
	ORDERID INT,
	WAREHOUSEID INT,
	SHIPDATE DATETIME,
	PRIMARY KEY(ORDERID,WAREHOUSEID),
	FOREIGN KEY(WAREHOUSEID) REFERENCES WAREHOUSE(WAREHOUSEID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(ORDERID) REFERENCES C_ORDER(ORDERID) ON DELETE CASCADE ON UPDATE CASCADE
)

insert into SHIPMENT values (201,1,'2001-04-02') 
insert into SHIPMENT values (201,2,'2001-04-04') 
insert into SHIPMENT values (202,1,'2001-05-02') 
insert into SHIPMENT values (202,2,'2002-05-12') 
insert into SHIPMENT values (202,3,'2003-06-01') 
insert into SHIPMENT values (202,4,'2003-06-01') 
insert into SHIPMENT values (203,1,'2004-02-01') 
insert into SHIPMENT values (203,2,'2004-02-01') 
insert into SHIPMENT values (203,3,'2004-02-01') 
insert into SHIPMENT values (204,4,'2004-06-02') 
insert into SHIPMENT values (204,2,'2004-06-02') 

--WAREHOUSE (warehouse #: int, city: string) 

CREATE TABLE WAREHOUSE(
	WAREHOUSEID INT,
	CITY VARCHAR(10) NOT NULL,
	PRIMARY KEY(WAREHOUSEID)
)

insert into WAREHOUSE values (1,'MAGALORE') 
insert into WAREHOUSE values (2,'MAGALORE') 
insert into WAREHOUSE values (3,'MAGALORE') 
insert into WAREHOUSE values (4,'UDUPI') 
insert into WAREHOUSE values (5,'UDUPI') 
insert into WAREHOUSE values (6,'KARKALA') 

--1. Produce a listing: CUSTNAME, #oforders, AVG_ORDER_AMT, where the middle column is the total numbers of orders by the customer and the last column is the average order amount for that customer.

SELECT C.CNAME,COUNT(O.ORDERID) AS NO_OF_ORDERS,AVG(O.OAMT) AS AVG_AMT
FROM CUSTOMER C,C_ORDER O
WHERE C.CUSTID=O.CUSTID GROUP BY C.CNAME,C.CUSTID

--2. For each item that has more than two orders , list the item, number of orders that are  shipped from atleast two warehouses and total  quantity of items shipped 

SELECT OI.ITEMID,
       COUNT(DISTINCT OI.ORDERID) AS NO_OF_ORDERS,
       SUM(OI.QTY) AS TOTAL_QUANTITY
FROM ORDER_ITEM OI
JOIN (
    SELECT ORDERID
    FROM SHIPMENT
    GROUP BY ORDERID
    HAVING COUNT(DISTINCT WAREHOUSEID) >= 2
) S ON OI.ORDERID=S.ORDERID
GROUP BY OI.ITEMID
HAVING COUNT(DISTINCT OI.ORDERID) > 2;

--3. List the customers who have ordered for every item that the company produces 

SELECT C.CNAME
FROM CUSTOMER C, C_ORDER O, ORDER_ITEM OI
WHERE C.CUSTID = O.CUSTID
  AND O.ORDERID = OI.ORDERID
GROUP BY C.CUSTID, C.CNAME
HAVING COUNT(DISTINCT OI.ITEMID) = (SELECT COUNT(*) FROM ITEM);
