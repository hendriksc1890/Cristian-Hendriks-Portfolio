Use hendriks_cs355fl20;

drop table if exists Merchandise;
drop table if exists Surf_Events;
drop table if exists surfers;
Drop table if exists Surf_Interns;
Drop Table IF exists Surf_Instructors;
Create table Surf_Instructors
(
 NAME_I varchar (25) Primary Key,
 sex varchar (7) check (sex in ('Male', 'Female')),
 SSN bigint Unique,
 Years_taught bigint
 );
 
 insert into Surf_Instructors (Name_I, sex, SSN, Years_taught)
 Value
 ('Sean Hanlon', 'Male' , 12345332,4),
 ('Armaan Shah ', 'Male', 564533,7),
 ('Alani Lopez ', 'Female', 3454335,2),
 ('Crystal Martinez', 'Female', 981911,1),
 ('Audrey Castillo' , 'Female', 0070975,3);
 
 
Create table Surf_Interns
(
Name_Intern Varchar (25) Primary Key,
Surf_Teachers varchar(25) ,
DOB Datetime Unique,
Degrees bigint,
Term varchar (10),
Foreign Key (Surf_Teachers)
			References Surf_Instructors(Name_I)
            
);

insert into Surf_Interns (Name_Intern, Surf_Teachers, DOB, Degrees,Term)
value
('Ben Huber', 'Sean Hanlon', '2000-02-12 10:34:09', 2,'Spring'),
('Jacob Aere', 'Armaan Shah', '1998-06-12 10:34:09',1, 'Spring'),
('Zack Haupt', 'Alani Lopez', '1997-06-12 10:34:09', 0, 'Fall'),
('Steven Hendriks', 'Audrey Castillo', '2001-06-12 10:34:09' , 3,'Spring'),
('Eric Vela', 'Crystal Martinez', '2000-06-12 10:34:09', 0, 'Spring');

Create table surfers
(
ID bigint Primary Key,
Surf_Level bigint,
Name_S varchar (30),
Surfer_type varchar (25) check ( Surfer_type in ('Short Boarder', 'Long Boarder'))
);


insert into surfers( ID, Surf_Level, Name_S, Surfer_type)
value
(12345, 7, 'Lucas Hendriks','Short Boarder'),
(54321, 14, 'Roddy Rich','Long Boarder'),
(87190, 17, 'Tupac Shakur','Short Boarder'),
(33488, 8, 'Chance Bennet','Short Boarder'),
(98765, 6, 'Frank Ocean','Long Boarder');

Create Table Surf_Events
(

Event_Title varchar(200),
Event_Date Datetime,
Event_Director varchar(30) Not null,
foreign key (Event_Director) references Surf_Instructors(Name_I)
);

insert into Surf_Events (Event_Title, Event_Date, Event_Director)
value
('Spring PRO-AM','2020-03-11 10:34:00', 'Armaan Shah'),
('Fall Festival', '2020-05-11 11:30:00', 'Sean Hanlon'),
('Holiday Classic', '2000-02-12 10:34:09', 'Alani Lopez'),
('Easter Special', '2000-02-12 11:30:09', 'Audrey Castillo'),
( 'Machodo Showcase', '2020-02-12 10:34:09', 'Crystal Martinez');


Create Table Merchandise
(
Purchase_ID bigint primary key,
Quantity_Shirts bigint,
Shirt_type varchar(20) ,
Shirt_Price float,
Purchaser bigint,
Foreign Key (Purchaser)
			References surfers(ID)
            
					
);

Insert into Merchandise( Purchase_ID,Quantity_Shirts, Shirt_Type, Shirt_Price, Purchaser)
Value
(7777,2, 'Long Sleeve', 10.00, '12345'),
(7778, 4,'Short Sleeve', 5.00, '87190'),
(7779,6, 'Long Sleeve', 12.00, '33488');


DROP procedure IF EXISTS `Find_Trainer`;
DELIMITER $$
USE `hendriks_cs355fl20`$$
CREATE PROCEDURE `Find_Trainer` ()
BEGIN
select Surfer_Type from trainers;
END$$




/*View*/
drop view if exist 'Merch_info';
DELIMITER ;

CREATE OR REPLACE 'merch_info' AS
DELIMITER ;

/*CREATE VIEW `Merch_info` AS*/
select Shirt_Type, Purchaser, max(Shirt_Price) 
from Merchandise;







/*function*/

DROP function IF EXISTS `Surf_Rank`;
DELIMITER $$
CREATE FUNCTION `Surf_Rank` (
Surf_Level Decimal(10,2))
RETURNS varchar(30)
BEGIN
Declare Surf_Rank varchar
(20);
if Surf_Level < 10 then
set Surf_Rank = 'beginner';
elseif (Surf_Level <= 10 )
then set Surf_rank = 'Advance';
end if;
RETURN Surf_rank;
END$$
DELIMITER ;

select Surf_Rank(12);




/*Procedure*/

DROP procedure IF EXISTS `Find_Trainer`;
DELIMITER $$
USE `hendriks_cs355fl20`$$
CREATE PROCEDURE `Find_Trainer` ()
BEGIN
select Surfer_Type, Name_S from surfers where Surfer_Type = 'Long Boarder';
END$$

/* Calling the procedure*/
call Find_Trainer();

select * from (Merch_info);



/*Query's*/

/*Where withy conditions*/
Select * from surfers where Surf_Level >8 and Surfer_Type ='Short Boarder';

/*subquery*/
Select Name_Intern, AVG(years_taught) from
(Select Name_Intern, count(*) as years_taught 
from Surf_Interns) as yt 
;

/*Group by having*/
SELECT  Degrees, Name_Intern
FROM Surf_Interns
GROUP BY Term
Having degrees;


/*having*/
Update surfers 
Set Surfer_type= 'Long Boarder'
Where ID= 12345;

/*Distinct*/
select distinct ID from surfers where Surfer_type = 'Long Boarder';

/* Union */
Select SSN from Surf_Instructors
Union All
Select Event_Title from Surf_Events;











/* Join*/ 

select Surf_Interns.Surf_Teachers, Surf_Events.Event_Director, Surf_Interns.Surf_Teachers 
from Surf_Instructors
inner join Surf_Interns
On Surf_Instructors.NAME_I= Surf_Interns.Surf_Teachers
join Surf_Events
on Surf_Events.Event_Director=Surf_Interns.Surf_Teachers;



