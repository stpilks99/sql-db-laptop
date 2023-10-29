/*
	DATA 6200 - Data Management
	Project Implementation: Operational DB
	
	Group: Data Bois, Group 1
	Members:Ryan Gemos, Sterling Pilkington
*/

/**CREATE TABLES****************************************************************************************************************
   For each table, put the table name in the comment followed by the code 
   E.g., 
   -- Table PRODUCT  
   CREATE TABLE PRODUCT(
		ProductNumber	Char(35)			NOT NULL,
		ProductType		Char(25)			NOT NULL,
		ProductName 	VarChar(75)			NOT NULL,
		CONSTRAINT 		PRODUCT_PK			PRIMARY KEY(ProductNumber)
		);

   -- Table CUSTOMER
      ...
*********************************************************************************************************************************/
-- YOUR CODE GOES HERE

/* Run this line first then everything else*/
CREATE DATABASE LeopardNet

USE LeopardNet
GO

-- SPEC TABLE
CREATE TABLE SPEC(
	SpecID			INT					NOT NULL IDENTITY(1,1),
	CPU				CHAR(25)			NOT NULL,
	GPU				CHAR(25)			NOT NULL,
	Memory			CHAR(5)				NOT NULL,
	Storage			CHAR(5)				NOT NULL,
	CONSTRAINT SPEC_PK
		PRIMARY KEY(SpecID)
);

-- MAJOR TABLE
CREATE TABLE MAJOR(
	MajorCode			Char(5)			NOT NULL,
	Name				Char(30) 		NOT NULL,
	Description			Char(200) 		NOT NULL,
	NumYears			INT				NOT NULL,
	CONSTRAINT MAJOR_PK
		PRIMARY KEY(MajorCode)			
);

-- MAJOR_SPEC TABLE
CREATE TABLE MAJOR_SPEC(
	SpecID			INT					NOT NULL IDENTITY(1,1),
	MajorCode		CHAR(5)				NOT NULL,
	RevisedDate		DATE				NOT NULL,
	CONSTRAINT MS_PK
		PRIMARY KEY(SpecID, MajorCode),
	CONSTRAINT MS_MAJOR_FK
		FOREIGN KEY(SpecID) 
		REFERENCES SPEC(SpecID)
			ON UPDATE NO ACTION
			ON DELETE NO ACTION,
	CONSTRAINT MS_SPEC_FK
		FOREIGN KEY(MajorCode) 
		REFERENCES MAJOR(MajorCode)
			ON UPDATE CASCADE
			ON DELETE NO ACTION
);

-- SOFTWARE TABLE
CREATE TABLE SOFTWARE(
	SoftwareName	CHAR(30)			NOT NULL,
	SKU				CHAR(15)			NOT NULL,
	Vendor			CHAR(30)			NOT NULL,
	VersionNumber	CHAR(10)			NOT NULL,
	CONSTRAINT SOFTWARE_PK
		PRIMARY KEY(SoftwareName, SKU)
);


-- LAPTOP TABLE
CREATE TABLE LAPTOP(
	Manufacturer		CHAR(10)		NOT NULL,
	SerialNumber		CHAR(20)		NOT NULL,
	Model				CHAR(20)		NOT NULL,
	OperatingSystem		CHAR(15)		NOT NULL,
	SpecID				INT				NOT NULL IDENTITY(1,1),
	CONSTRAINT LAPTOP_PK
		PRIMARY KEY(SerialNumber),
	CONSTRAINT LAPTOP_SPEC_FK
		FOREIGN KEY(SpecID) 
		REFERENCES SPEC(SpecID)
			ON UPDATE NO ACTION
			ON DELETE NO ACTION
);

-- STUDENT TABLE
CREATE TABLE STUDENT(
	StudentID			CHAR(9)			NOT NULL,
	LastName			CHAR(30) 		NOT NULL,
	FirstName			CHAR(30) 		NOT NULL,
	MajorCode			CHAR(5)			NOT NULL,
	SerialNumber		CHAR(20)		NOT NULL,
	CONSTRAINT STUDENT_PK
		PRIMARY KEY(StudentID),
	CONSTRAINT STUDENT_MAJOR_FK
		FOREIGN KEY(MajorCode)
		REFERENCES MAJOR(MajorCode)
			ON UPDATE NO ACTION
			ON DELETE NO ACTION,
	CONSTRAINT	STUDENT_LAPTOP_FK
		FOREIGN KEY(SerialNumber)
		REFERENCES LAPTOP(SerialNumber)	
			ON UPDATE CASCADE
			ON DELETE NO ACTION
);

-- SOFTWARE_ASSIGN TABLE
CREATE TABLE SOFTWARE_ASSIGN(
	StudentID			CHAR(9)			NOT NULL,
	SoftwareName		CHAR(30)		NOT NULL,
	SKU					CHAR(15)		NOT NULL,
	ActivationDate		DATE			NOT NULL,
	RenewalDate			DATE			NOT NULL,
	License				CHAR(20)		NOT NULL,
	CONSTRAINT SA_PK
		PRIMARY KEY(StudentID, SoftwareName, SKU),
	CONSTRAINT SA_STUDENT_FK
		FOREIGN KEY(StudentID)
		REFERENCES STUDENT(StudentID)
			ON UPDATE NO ACTION
			ON DELETE NO ACTION,
	CONSTRAINT SA_SOFTWARE_FK
		FOREIGN KEY(SoftwareName, SKU) /*needs to reference both elements in the SOFTWARE PK*/
		REFERENCES SOFTWARE(SoftwareName, SKU)
			ON UPDATE CASCADE
			ON DELETE CASCADE
);

/**INSERT DATA*******************************************************************************************************************
   For each insert, put the table name in the comment followed by the code 
   and show all records of that table
   E.g., 
   -- Table PRODUCT 
	INSERT INTO PRODUCT VALUES('VK001', 'Video', 'Kitchen Remodeling Basics',14.95, 50);
	INSERT INTO PRODUCT VALUES('VK002', 'Video', 'Advanced Kitchen Remodeling', 14.95, 35);
	...
   -- Table CUSTOMER
    ...
*********************************************************************************************************************************/
-- YOUR CODE GOES HERE

-- SPEC TABLE
INSERT INTO SPEC VALUES('Intel Core i5', 'Intel HD Graphics', '8GB', '256GB');
INSERT INTO SPEC VALUES('Intel Core i7', 'Intel HD Graphics', '16GB', '256GB');
INSERT INTO SPEC VALUES('Intel Core i7', 'NVIDIA Quadro M2200', '16GB', '512GB');
INSERT INTO SPEC VALUES('Intel Core i7', 'NVIDIA GeForce 3060', '32GB', '1TB');
INSERT INTO SPEC VALUES('Intel Core i9', 'NVIDIA GeForce 3070', '32GB', '2TB');

-- SOFTWARE TABLE
INSERT INTO SOFTWARE VALUES('MATLAB', 'K492742T', 'MathWorks', 'r2022a');
INSERT INTO SOFTWARE VALUES('SolidWorks', 'S56HGIK8', 'Dassault Systemes', '2021');
INSERT INTO SOFTWARE VALUES('LabView', 'GH87GHKJU', 'National Instruments', '2022');
INSERT INTO SOFTWARE VALUES('WolframAlpha', '98GHKUSI', 'Wolfram Research', '2022');
INSERT INTO SOFTWARE VALUES('MATLAB', 'K492741S', 'MathWorks', 'r2021b');

-- MAJOR TABLE
INSERT INTO MAJOR VALUES('BSCO', 'Computer Engineering', 'Combination of computer hardware and software', 4);
INSERT INTO MAJOR VALUES('BSCS', 'Computer Science', 'Algorithms and coding', 4);
INSERT INTO MAJOR VALUES('BSME', 'Mechanical Engineering', 'Thermo and physics', 4);
INSERT INTO MAJOR VALUES('BSCE', 'Civil Engineering', 'Design, construction, maintenance of environments', 4);
INSERT INTO MAJOR VALUES('BSA', 'Architecture', 'Art of designing and building', 4);

-- MAJOR_SPEC TABLE
INSERT INTO MAJOR_SPEC VALUES('BSCO', '2022-03-10');
INSERT INTO MAJOR_SPEC VALUES('BSCS', '2022-03-10');
INSERT INTO MAJOR_SPEC VALUES('BSME', '2022-04-11');
INSERT INTO MAJOR_SPEC VALUES('BSCE', '2022-04-11');
INSERT INTO MAJOR_SPEC VALUES('BSA', '2022-03-10');

-- LAPTOP TABLE
INSERT INTO LAPTOP VALUES('Lenovo', 'CNEU9WF4WI', 'ThinkPad P51', 'Windows 10');
INSERT INTO LAPTOP VALUES('Lenovo', 'FJKEIH8THW', 'Yoga', 'Windows 10');
INSERT INTO LAPTOP VALUES('Lenovo', 'HGYUHG873G', 'Idea Pad', 'Windows 10');
INSERT INTO LAPTOP VALUES('HP', 'THSLKNGYU9', 'Elitebook', 'Windows 11');
INSERT INTO LAPTOP VALUES('HP', '45HGHBGOIY', 'Z Book', 'Windows 11');

-- STUDENT TABLE
INSERT INTO STUDENT VALUES('W00123456', 'Kennedy', 'Louise', 'BSCO', 'CNEU9WF4WI');
INSERT INTO STUDENT VALUES('W00789101', 'Lewis', 'John', 'BSCS', 'FJKEIH8THW');
INSERT INTO STUDENT VALUES('W00112131', 'Spears', 'Britney', 'BSME', 'HGYUHG873G');
INSERT INTO STUDENT VALUES('W00415161', 'Del Ray', 'Lana', 'BSCE', 'THSLKNGYU9');
INSERT INTO STUDENT VALUES('W00718192', 'Gaga', 'Lady', 'BSA', '45HGHBGOIY');

-- SOFTWARE_ASSIGN TABLE
INSERT INTO SOFTWARE_ASSIGN VALUES('W00123456', 'MATLAB', 'K492742T', '2022-03-10', '2024-03-10', '738Q9RAH8F39');
INSERT INTO SOFTWARE_ASSIGN VALUES('W00789101', 'SolidWorks', 'S56HGIK8', '2022-01-01', '2024-01-01', '124SGHIYG98G');
INSERT INTO SOFTWARE_ASSIGN VALUES('W00112131', 'LabView', 'GH87GHKJU', '2022-02-11', '2026-02-11', 'GHNK78HGYUI0');
INSERT INTO SOFTWARE_ASSIGN VALUES('W00415161', 'WolframAlpha', '98GHKUSI', '2022-04-11', '2028-04-11', 'RYHLIURS890G');
INSERT INTO SOFTWARE_ASSIGN VALUES('W00718192', 'MATLAB', 'K492741S', '2022-03-10', '2024-03-10', '738HGUHGLKI1');


/**SHOW DATA*******************************************************************************************************************
   For each table, put the table name in the comment followed by the code to show data of that table 
   E.g., 
   -- Table PRODUCT 
   SELECT * FROM PRODUCT;
   -- Table CUSTOMER 
    ...
*********************************************************************************************************************************/
-- YOUR CODE GOES HERE

-- SPEC TABLE
SELECT * FROM SPEC

-- SOFTWARE TABLE
SELECT * FROM SOFTWARE

-- MAJOR TABLE
SELECT * FROM MAJOR

-- MAJOR_SPEC TABLE
SELECT * FROM MAJOR_SPEC

-- LAPTOP TABLE
SELECT * FROM LAPTOP

-- STUDENT TABLE
SELECT * FROM STUDENT

-- SOFTWARE_ASSIGN TABLE
SELECT * FROM SOFTWARE_ASSIGN

/**QUERIES***********************************************************************************************************************
   For each business requirement, write at least 1 question and the corresponding query to answer that question 
   E.g., 
   -- Keeping track of seminars: 
   -- Question: Who have attended the Kitchen on a Big D Budget seminar? List the FirstName, LastName, and Phone of customers (list each name only once).

   SELECT	DISTINCT FirstName, LastName, Phone
   FROM		CUSTOMER AS C JOIN SEMINAR_CUSTOMER AS SC
   ON		C.CustomerID = SC.CustomerID
			JOIN SEMINAR AS S
   ON		SC.SeminarID = S.SeminarID
   WHERE	S.SeminarTitle = 'Kitchen on a Big D Budget';

*********************************************************************************************************************************/
-- YOUR CODE GOES HERE

-- 1.	To keep track of students that will get/already have a WIT distributed laptop.
-- Question: Who is assigned a laptop? List last name, first name, StudentID, Manufacturer, Model, CPU, GPU, Memory, Storage, SpecID.
SELECT ST.LastName, ST.FirstName, ST.StudentID, ST.MajorCode, L.SerialNumber, L.Manufacturer, L.Model, SP.SpecID, SP.CPU, SP.GPU, SP.Memory, SP.Storage /*add laptop & software & major specific information, when was it assigned*/ 
FROM STUDENT AS ST
JOIN LAPTOP AS L ON ST.SerialNumber = L.SerialNumber
JOIN SPEC AS SP ON L.SpecID = SP.SpecID
ORDER BY ST.LastName ASC;

-- 2.	To create a relationship between the majors offered at WIT and the list of laptops being offered.
-- Question: What laptop spec does each major have? List MajorCode, SpecID, CPU, GPU, Memory, Storage.
SELECT MS.MajorCode, S.SpecID, S.CPU, S.GPU, S.Memory, S.Storage
FROM MAJOR_SPEC AS MS
JOIN SPEC AS S ON MS.SpecID = S.SpecID;

-- 3.	To keep a list and descriptions of majors that students can take at WIT
-- Question: List all majors and their descriptions, also count how many laptop specs correspond to each major.
SELECT M.MajorCode, M.Name, M.Description, COUNT(MS.SpecID) AS 'NumSpecs'
FROM MAJOR AS M
JOIN MAJOR_SPEC AS MS ON M.MajorCode = MS.MajorCode
GROUP BY M.MajorCode, M.Name, M.Description;

-- 4.	To keep track of the laptop options and specs offered to WIT students. 
-- Question: A system administrator wants to contact all students still running Windows 10 asking them to update to 11. List all laptops that are still on Windows 10. List SerialNumber, manufacturer, model, SpecID, OperatingSystem, as well as StudentID, LastName, and FirstName of the students they're assigned to.
SELECT ST.StudentID, ST.LastName, ST.FirstName, L.SerialNumber, L.Manufacturer, L.Model, SP.SpecID, L.OperatingSystem
FROM SPEC AS SP 
JOIN LAPTOP AS L ON SP.SpecID = L.SpecID
JOIN STUDENT AS ST ON L.SerialNumber = ST.SerialNumber
WHERE L.OperatingSystem = 'Windows 10'
ORDER BY ST.LastName ASC;


-- 5.	To keep track of the software that is offered.
-- Question: A sysadmin wants to know which software needs to be renewed after January 1st, 2024. List SoftwareName, SKU, License, RenewalDate.
SELECT SoftwareName, SKU, License, RenewalDate
FROM SOFTWARE_ASSIGN
WHERE RenewalDate > '2024-01-01';