CREATE DATABASE trigg;
use trigg

CREATE TABLE students(Rollno int, Lastname varchar(255), Firstname varchar(255), Email varchar(255), classyear int, major varchar(255), phoneno varchar(255), PRIMARY KEY(Rollno));

CREATE TABLE message(msg varchar(255),no int);
INSERT INTO message VALUES('count',0);
INSERT INTO message VALUES('before insert',0);

INSERT INTO students VALUES(1,'Lakshmi','Vidhya','bvl1402@gmail.com',2014,'CSE','252525');
INSERT INTO students VALUES(2,'Prashanna','Naveen','naveen@gmail.com',2013,'Mech','252520');
INSERT INTO students VALUES(3,'Bala','Devi','dbj@gmail.com',2012,'Civil','252500');
INSERT INTO students VALUES(4,'Priya','Keerthi','lkp@gmail.com',2013,'Civil','252000');

SELECT * FROM students;
+--------+-----------+-----------+-------------------+-----------+-------+---------+
| Rollno | Lastname  | Firstname | Email             | classyear | major | phoneno |
+--------+-----------+-----------+-------------------+-----------+-------+---------+
|      1 | Lakshmi   | Vidhya    | bvl1402@gmail.com |      2014 | CSE   |  252525 |
|      2 | Prashanna | Naveen    | naveen@gmail.com  |      2013 | Mech  |  252520 |
|      3 | Bala      | Devi      | dbj@gmail.com     |      2012 | Civil |  252500 |
|      4 | Priya     | Keerthi   | lkp@gmail.com     |      2013 | Civil |  252000 |
+--------+-----------+-----------+-------------------+-----------+-------+---------+






1.

delimiter //
create trigger t1 
after insert on students
for each row
begin
	declare n int;
	select COUNT(*) into n from students;
        DELETE FROM message WHERE msg='count';
	INSERT INTO message VALUES('count',n);
end; 
//
delimiter ;

SELECT * FROM message;
+-------+------+
| msg   | no   |
+-------+------+
| count |    0 |
+-------+------+

INSERT INTO students VALUES(5,'Eashwar','Amruth','laeb@gmail.com',2014,'chem',250000);
INSERT INTO students VALUES(6,'Gnana','Sangkeetha','sang@gmail.com',2012,'EEE',200000);
SELECT * FROM message;
+-------+------+
| msg   | no   |
+-------+------+
| count |    6 |
+-------+------+









2.
delimiter //
create trigger t2 
before insert on students
for each row
begin
	declare n int;
	select COUNT(*) into n from students;
        DELETE FROM message WHERE msg='before insert';
	INSERT INTO message VALUES('before insert ',n);
end; 
//
delimiter ;

INSERT INTO students VALUES(7,'Gnana','Boobalan','boobalan@gmail.com',2013,'ECE',200001);

SELECT * FROM message;
+-----------------------------------------+------+
| msg                                     | no   |
+-----------------------------------------+------+
| before insert                           |    6 |
| count                                   |    7 |
+-----------------------------------------+------+












drop trigger t1;                                            (because multiple triggers with the same action time and event for one table is not supported)

delimiter //
create trigger t3 
before insert on students                            ( after cannot be used when using new.phoneno) ( can use update on also instead of insert on but cannot use both)
for each row
begin
	 set new.phoneno=new.phoneno+99000000;
end; 
//
delimiter ;

INSERT INTO students VALUES(8,'Jayaraman','Ramana','ramana@gmail.com',2011,'ECE',200011);

select * from students;
+--------+-----------+------------+--------------------+-----------+-------+----------+
| Rollno | Lastname  | Firstname  | Email              | classyear | major | phoneno  |
+--------+-----------+------------+--------------------+-----------+-------+----------+
|      1 | Lakshmi   | Vidhya     | bvl1402@gmail.com  |      2014 | CSE   | 99252525 |
|      2 | Prashanna | Naveen     | naveen@gmail.com   |      2013 | Mech  | 99252520 |
|      3 | Bala      | Devi       | dbj@gmail.com      |      2012 | Civil | 99252500 |
|      4 | Priya     | Keerthi    | lkp@gmail.com      |      2013 | Civil | 99252000 |
|      5 | Eashwar   | Amruth     | laeb@gmail.com     |      2014 | chem  | 99250000 |
|      6 | Gnana     | Sangkeetha | sang@gmail.com     |      2012 | EEE   | 99200000 |
|      7 | Gnana     | Boobalan   | boobalan@gmail.com |      2013 | ECE   | 99200001 |
|      8 | Jayaraman | Ramana     | ramana@gmail.com   |      2011 | ECE   |   200011 |
+--------+-----------+------------+--------------------+-----------+-------+----------+






3.delimiter //
mysql> create trigger t13
    -> before insert on students
    -> for each row
    -> begin
    -> set new.phoneno=concat('+91',new.phoneno);
    -> end;
    -> //



 INSERT INTO students VALUES(15,'Lakshmi','Vidhya','bvl1402@gmail.com',2015,'CSE',252525);
Query OK, 1 row affected (0.00 sec)

mysql> select * from students;
+--------+-----------+------------+--------------------+-----------+-------+-----------+
| Rollno | Lastname  | Firstname  | Email              | classyear | major | phoneno   |
+--------+-----------+------------+--------------------+-----------+-------+-----------+
|      1 | Lakshmi   | Vidhya     | bvl1402@gmail.com  |      2014 | CSE   | 252525    |
|      2 | Prashanna | Naveen     | naveen@gmail.com   |      2013 | Mech  | 252520    |
|      3 | Bala      | Devi       | dbj@gmail.com      |      2012 | Civil | 252500    |
|      4 | Priya     | Keerthi    | lkp@gmail.com      |      2013 | Civil | 252000    |
|      5 | Eashwar   | Amruth     | laeb@gmail.com     |      2014 | chem  | 250000    |
|      6 | Gnana     | Sangkeetha | sang@gmail.com     |      2012 | EEE   | 200000    |
|      7 | Gnana     | Boobalan   | boobalan@gmail.com |      2013 | ECE   | 200001    |
|      9 | Gnana     | Boobalan   | boobalan@gmail.com |      2013 | ECE   | 200001    |
|     10 | Lakshmi   | Vidhya     | bvl1402@gmail.com  |      2014 | CSE   | 252525    |
|     11 | Priya     | Keerthi    | lkp@gmail.com      |      2013 | Civil | 252000    |
|     15 | Lakshmi   | Vidhya     | bvl1402@gmail.com  |      2015 | CSE   | +91252525 |
+--------+-----------+------------+--------------------+-----------+-------+-----------+




4. 
create trigger t15 
before insert on students 
for each row 
begin 
if(locate(' ',new.Firstname)<>0) 
then 
set new.Lastname=substr(new.Firstname,locate(' ',new.firstname)+1); 
set new.Firstname=substr(new.Firstname,1,locate(' ',new.Firstname)-1); 
end if;
end;
//

INSERT INTO students VALUES(18,'Kumar','Dinesh Kumar','dinesh@gmail.com',2012,'Mech',200111);

select * from students;                                                  
+--------+-----------+-------------+--------------------+-----------+-------+-----------+
| Rollno | Lastname  | Firstname   | Email              | classyear | major | phoneno   |
+--------+-----------+-------------+--------------------+-----------+-------+-----------+
|      1 | Lakshmi   | Vidhya      | bvl1402@gmail.com  |      2014 | CSE   | 252525    |
|      2 | Prashanna | Naveen      | naveen@gmail.com   |      2013 | Mech  | 252520    |
|      3 | Bala      | Devi        | dbj@gmail.com      |      2012 | Civil | 252500    |
|      4 | Priya     | Keerthi     | lkp@gmail.com      |      2013 | Civil | 252000    |
|      5 | Eashwar   | Amruth      | laeb@gmail.com     |      2014 | chem  | 250000    |
|      6 | Gnana     | Sangkeetha  | sang@gmail.com     |      2012 | EEE   | 200000    |
|      7 | Gnana     | Boobalan    | boobalan@gmail.com |      2013 | ECE   | 200001    |
|      9 | Gnana     | Boobalan    | boobalan@gmail.com |      2013 | ECE   | 200001    |
|     10 | Lakshmi   | Vidhya      | bvl1402@gmail.com  |      2014 | CSE   | 252525    |
|     11 | Priya     | Keerthi     | lkp@gmail.com      |      2013 | Civil | 252000    |
|     15 | Lakshmi   | Vidhya      | bvl1402@gmail.com  |      2015 | CSE   | +91252525 |
|     16 | Kumar     | DineshKumar | dinesh@gmail.com   |      2012 | Mech  | 200111    |
|     17 | Kumar     | DineshKumar | dinesh@gmail.com   |      2012 | Mech  | 200111    |
|     18 | Kumar     | Dinesh      | dinesh@gmail.com   |      2012 | Mech  | 200111    |
+--------+-----------+-------------+--------------------+-----------+-------+-----------+



5.
delete * from students;
INSERT INTO students VALUES(1,'Lakshmi','Vidhya','bvl1402@gmail.com',2014,'CSE',252525);
INSERT INTO students VALUES(2,'Prashanna','Naveen','naveen@gmail.com',2013,'Mech',252520);
INSERT INTO students VALUES(3,'Bala','Devi','dbj@gmail.com',2012,'Civil',252500);
INSERT INTO students VALUES(4,'Priya','Keerthi','lkp@gmail.com',2013,'Civil',252000);

create table studentlog(doi date, user varchar(255),action varchar(255)); 

delimiter //
create trigger t5 
after insert on students
for each row
begin
	INSERT INTO studentlog VALUES(CURDATE(),'root','inserted');
end; 
//
delimiter ;

delimiter //
create trigger t5 
after update on students
for each row
begin
	INSERT INTO studentlog VALUES(CURDATE(),'root','updated');
end; 
//
delimiter ;

delimiter //
create trigger t5 
after delete on students
for each row
begin
	INSERT INTO studentlog VALUES(CURDATE(),'root','deleted');
end; 
//
delimiter ;

update students set major='EEE' where Rollno=3;

/* 
Now()
Current_User()
these can be used instead of curdate()
*/

select * from studentlog;
+------------+------+---------+
| doi        | user | action  |
+------------+------+---------+
| 2019-09-19 | root | updated |
+------------+------+---------+

select * from students;
+--------+-----------+-----------+-------------------+-----------+-------+---------+
| Rollno | Lastname  | Firstname | Email             | classyear | major | phoneno |
+--------+-----------+-----------+-------------------+-----------+-------+---------+
|      1 | Lakshmi   | Vidhya    | bvl1402@gmail.com |      2014 | CSE   |  252525 |
|      2 | Prashanna | Naveen    | naveen@gmail.com  |      2013 | Mech  |  252520 |
|      3 | Bala      | Devi      | dbj@gmail.com     |      2012 | EEE   |  252500 |
|      4 | Priya     | Keerthi   | lkp@gmail.com     |      2013 | Civil |  252000 |
+--------+-----------+-----------+-------------------+-----------+-------+---------+










delimiter //
create trigger t9 
before insert on students
for each row
begin
	INSERT INTO view1 VALUES(new.Rollno,new.Lastname,new.Firstname,new.Email,new.classyear,new.major,new.phoneno);
end; 
//
delimiter ;

INSERT INTO students VALUES(16,'Kumar','Dinesh','dinesh@gmail.com',2012,'Mech',200111);









6.
CREATE TABLE students(Rollno int, Lastname varchar(255), Firstname varchar(255), Email varchar(255), classyear int, major varchar(255), phoneno int, PRIMARY KEY(Rollno));

select * from students;
Empty set (0.00 sec)


delimiter //
create trigger n1 
before insert on students 
for each row 
begin 
declare msg varchar(255); 
if(new.classyear>=2015) 
then update `ERROR: classyear>=2015` set x=1; 
end if; 
end
//
delimiter ;


INSERT INTO students VALUES(1,'Lakshmi','Vidhya','bvl1402@gmail.com',2015,'CSE',252525);
/* 
Answer : 
ERROR 1146 (42S02): Table 'trigg.ERROR: classyear>=2015' doesn't exist 
*/



/* 
mysql> drop trigger n1;
Query OK, 0 rows affected (0.00 sec)

mysql> show triggers;
Empty set (0.00 sec)
*/






7.
delimiter //
create trigger n2
before insert on students 
for each row 
begin 
declare msg varchar(255); 
if(new.firstname='john') 
then update `ERROR: firstname='john'` set x=1; 
end if; 
end
//
delimiter ;


INSERT INTO students VALUES(2,'paul','john','john@gmail.com',2015,'ECE',252520);
/*
Answer: 

ERROR 1146 (42S02): Table 'trigg.ERROR: firstname='john'' doesn't exist
mysql> 
*/






/* 
mysql> drop trigger n2;
Query OK, 0 rows affected (0.00 sec)

mysql> show triggers;
Empty set (0.00 sec)
*/






8.
delimiter //
create trigger n3
before update on students 
for each row 
begin 
declare msg varchar(255); 
if(old.Rollno<>new.Rollno) 
then update `ERROR: old.rollno<>new.rollno` set x=1; 
end if; 
end
//
delimiter ;

update students set Rollno=3 where Rollno=2;
/*
ERROR 1146 (42S02): Table 'trigg.ERROR: old.rollno<>new.rollno' doesn't exist
*/








9.
CREATE VIEW temp_view AS SELECT rollno, firstname FROM students;

delimiter //
CREATE TRIGGER n4
BEFORE INSERT ON students
FOR EACH ROW
BEGIN
	INSERT INTO temp_view VALUES (new.rollno, new.firstname);
END 
//
delimiter ;

select * from temp_view;
+--------+-----------+
| rollno | firstname |
+--------+-----------+
|      2 | john      |
+--------+-----------+


INSERT INTO students VALUES(3,'kumari','kala','kala@gmail.com',2012,'EEE',252500);

select * from temp_view;
+--------+-----------+
| rollno | firstname |
+--------+-----------+
|      2 | john      |
|      3 | kala      |
+--------+-----------+




