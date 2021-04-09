Use CourierManagementSystemDatabase;

CREATE TABLE CUSTOMER
(
	CustomerNID varchar(16) PRIMARY KEY,
	Name varchar(20) not null,
	Address varchar(40) not null,
	Phone varchar(15) not null
);

INSERT INTO CUSTOMER (CustomerNID,Name,Address,Phone)
VALUES	('1122334455','Abdul Rahim','Mirpur-1,Dhaka','00111222333'),
		('1122334456','Abdul Karim','Farmgate,Dhaka','01111222333'),
		('1122334457','Abdul Zaman','Banani,Dhaka','01211222333')

CREATE TABLE RECEIVER
(
	ReceiverNID varchar(16) PRIMARY KEY,
	Name varchar(20) not null,
	Address varchar(40) not null,
	Phone varchar(15) not null
);

INSERT INTO RECEIVER(ReceiverNID,Name,Address,Phone)
VALUES	('1122334465','Jalal Hossain','Mirpur-10,Dhaka','00111222333'),
		('1122334466','Kalam Bhuiya','Jatrabari,Dhaka','01111222334'),
		('1122334458','Hakim Ali','Uttara,Dhaka','01211222343')

CREATE TABLE DELIVERYMAN
(
	DeliveryManID int IDENTITY(1,1) PRIMARY KEY,
	Name varchar(20) not null,
	Address varchar(40) null,
	Phone varchar(15) unique not null,
	Email varchar(20) unique not null
);

INSERT INTO DELIVERYMAN (Name,Address,Phone,Email)
VALUES	('Md.Samsur','Tejgaon','01777222444','Samsur@gmail.com'),
		('Md.Asik','Khulna','01777222445','Asik23@gmail.com'),
		('Kawsar Ahmed','Khulna','01777222455','Kawsar435@gmail.com')

/*
select * from DELIVERYMAN
*/

CREATE TABLE PAYMENT
(
	PaymentID int IDENTITY(1,1) PRIMARY KEY,
	CustomerNID varchar(16) foreign key references CUSTOMER(CustomerNID),
	Type varchar(10) check(Type in ('cash','credit','bkash')) not null,
	Amount decimal(8,2) not null
);

INSERT INTO PAYMENT(CustomerNID,Type,Amount)
VALUES	('1122334457','bkash','10000'),
		('1122334456','cash','12000'),
		('1122334455','credit','14000')


CREATE TABLE PACKAGE
(
	PackageID int IDENTITY(1,1) PRIMARY KEY,
	Type varchar(20) null,
	Weight decimal(6,2) check(Weight>0)
);

INSERT INTO PACKAGE (Type,Weight)
VALUES ('Parcel',12),
	   ('Medicine',2),
	   ('Food Products',4);

CREATE TABLE VEHICLE
(
	VehicleID int IDENTITY(1,1) PRIMARY KEY,
	Type varchar(10) DEFAULT 'Pick-up',
	LicenseNo varchar(15) not null unique
);

INSERT INTO VEHICLE(Type,LicenseNo)
VALUES ('Truck','00000000000'),
	   ('Pick-up','11111111111'),
	   ('Van','22222222222');

/*DROP TABLE VEHICLE
SELECT * FROM VEHICLE
SELECT * FROM DELIVERYMAN*/


CREATE TABLE ORDERS
(
	OrderID int IDENTITY(1,1) PRIMARY KEY,
	CustomerNID varchar(16) foreign key references CUSTOMER(CustomerNID),
	ReceiverNID varchar(16) foreign key references RECEIVER(ReceiverNID),
	DeliveryManID int foreign key references DELIVERYMAN(DeliveryManID),
	PackageID int foreign key references PACKAGE(PackageID),
	PaymentID int foreign key references PAYMENT(PaymentID),
	VehicleID int foreign key references VEHICLE(VehicleID),
	Date DATE not null,
	Status varchar(12) DEFAULT 'PENDING'
);

INSERT INTO ORDERS (CustomerNID,ReceiverNID,DeliveryManID,PackageID,PaymentID,VehicleID,Date)
VALUES ('1122334455','1122334465',1,1,3,1,'2021-03-01'),
	   ('1122334456','1122334466',2,2,2,2,'2021-03-01'),
	   ('1122334457','1122334458',3,3,1,2,'2021-02-28')

INSERT INTO ORDERS (CustomerNID,ReceiverNID,DeliveryManID,PackageID,PaymentID,VehicleID,Date)
VALUES ('1122334455','9999',1,1,3,1,'2021-03-01')


/*DROP TABLE ORDERS
SELECT * FROM ORDERS*/

/*Abir*/

CREATE TABLE ADMIN
(
	AdminUserName varchar(10) PRIMARY KEY,
	AdminPassWord varchar(10) not null
);

INSERT INTO ADMIN (AdminUserName, AdminPassWord)
VALUES ('abc','012345')

INSERT INTO ADMIN (AdminUserName, AdminPassWord)
VALUES ('pqr','1234567')

/*
SELECT * FROM ADMIN WHERE AdminUserName = 'xyz' AND AdminPassWord = '1234567'
*/

/*
DELETE FROM ADMIN WHERE AdminUserName = ''
*/

/*
ALTER TABLE DELIVERYMAN
ADD DeliverymanUserName varchar(10)

ALTER TABLE DELIVERYMAN
DROP COLUMN DeliverymanUserName
*/

/*
SELECT * FROM ADMIN
SELECT * FROM DELIVERYMAN
*/

ALTER TABLE DELIVERYMAN
ADD CONSTRAINT UC_DELIVERYMAN UNIQUE (Email)

INSERT INTO DELIVERYMAN (Name,Address,Phone,Email)
VALUES	('Nazimuddin','Banani','01700000000','nazimuddin@gmail.com')

ALTER TABLE DELIVERYMAN
ADD DeliverymanPassWord varchar(10)

ALTER TABLE ADMIN
ADD CONSTRAINT UC_ADMIN UNIQUE (AdminUserName)

/*
SELECT * FROM ADMIN
SELECT * FROM DELIVERYMAN
SELECT * FROM VEHICLE
SELECT * FROM PAYMENT
SELECT * FROM ORDERS
SELECT * FROM PACKAGE
SELECT * FROM CUSTOMER
SELECT * FROM RECEIVER

SELECT CUSTOMER.CustomerNID, CUSTOMER.Name, CUSTOMER.Phone, CUSTOMER.Address, PACKAGE.Type, PACKAGE.Weight, ORDERS.Status, ORDERS.ReceiverNID FROM PACKAGE INNER JOIN ORDERS ON PACKAGE.PackageID = ORDERS.PackageID INNER JOIN CUSTOMER ON ORDERS.CustomerNID = CUSTOMER.CustomerNID/* WHERE ORDERS.ReceiverNID = '9999'*/
SELECT DELIVERYMAN.Name, DELIVERYMAN.Address, DELIVERYMAN.Phone, A.PendingOrders FROM DELIVERYMAN INNER JOIN (SELECT DeliveryManID, COUNT(OrderID) AS PendingOrders FROM ORDERS WHERE ORDERS.Status LIKE 'PENDING' GROUP BY DeliveryManID) AS A ON DELIVERYMAN.DeliveryManID = A.DeliveryManID

SELECT * FROM DELIVERYMAN WHERE DeliveryManID = 12

UPDATE DELIVERYMAN SET Name = 'Mohammad', Address = 'Lalmonirhat', Phone = '01111111111', Email = 'abc@outlook.edu' WHERE DeliveryManID = 15
*/