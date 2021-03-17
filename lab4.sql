                                                                              PROCEDURES


CREATE DATABASE proc;
use proc

CREATE TABLE Employee(EmpNo int, EmpName varchar(255), Sex varchar(255), Salary int, Address varchar(255), DeptNo int, PRIMARY KEY(EmpNo),FOREIGN KEY(DeptNo) REFERENCES Department(DeptNo));
CREATE TABLE Department(DeptNo int, DeptName varchar(255), Location varchar(255), PRIMARY KEY(DeptNo));


INSERT INTO Employee VALUES(1,'vidhya','female',100000,'333-c',1);
INSERT INTO Employee VALUES(2,'naveen','male',200000,'332-d',2);
INSERT INTO Employee VALUES(3,'devi','female',100000,'332-c',1);
INSERT INTO Employee VALUES(4,'ramana','male',50000,'333-d',1);

INSERT INTO Department VALUES(1,'sales','delhi');
INSERT INTO Department VALUES(2,'marketing','mumbai');

SELECT * FROM Employee;
+-------+---------+--------+--------+---------+--------+
| EmpNo | EmpName | Sex    | Salary | Address | DeptNo |
+-------+---------+--------+--------+---------+--------+
|     1 | vidhya  | female | 100000 | 333-c   |      1 |
|     2 | naveen  | male   | 200000 | 332-d   |      2 |
|     3 | devi    | female | 100000 | 332-c   |      1 |
|     4 | ramana  | male   |  50000 | 333-d   |      1 |
+-------+---------+--------+--------+---------+--------+

SELECT * FROM Department;
+--------+-----------+----------+
| DeptNo | DeptName  | Location |
+--------+-----------+----------+
|      1 | sales     | delhi    |
|      2 | marketing | mumbai   |
+--------+-----------+----------+

























delimiter //
create procedure p2 (n int)
begin
	select * from Employee where EmpNo=n;
end; 
//
delimiter ;

call p2(3);
+-------+---------+--------+--------+---------+--------+
| EmpNo | EmpName | Sex    | Salary | Address | DeptNo |
+-------+---------+--------+--------+---------+--------+
|     3 | devi    | female | 100000 | 332-c   |      1 |
+-------+---------+--------+--------+---------+--------+









delimiter //
create procedure p3 ()
begin
	insert into Employee values(5,'sangkeetha','female',100000,'31',2);
end; 
//
delimiter ;

call p3();
SELECT * FROM Employee;
+-------+------------+--------+--------+---------+--------+
| EmpNo | EmpName    | Sex    | Salary | Address | DeptNo |
+-------+------------+--------+--------+---------+--------+
|     1 | vidhya     | female | 100000 | 333-c   |      1 |
|     2 | naveen     | male   | 200000 | 332-d   |      2 |
|     3 | devi       | female | 100000 | 332-c   |      1 |
|     4 | ramana     | male   |  50000 | 333-d   |      1 |
|     5 | sangkeetha | female | 100000 | 31      |      2 |
+-------+------------+--------+--------+---------+--------+







delimiter //
create procedure p4 (n int)
begin
	update Employee set Salary=200000 where EmpNo=n;
end; 
//
delimiter ;

call p4(1);
SELECT * FROM Employee;
+-------+------------+--------+--------+---------+--------+
| EmpNo | EmpName    | Sex    | Salary | Address | DeptNo |
+-------+------------+--------+--------+---------+--------+
|     1 | vidhya     | female | 200000 | 333-c   |      1 |
|     2 | naveen     | male   | 200000 | 332-d   |      2 |
|     3 | devi       | female | 100000 | 332-c   |      1 |
|     4 | ramana     | male   |  50000 | 333-d   |      1 |
|     5 | sangkeetha | female | 100000 | 31      |      2 |
+-------+------------+--------+--------+---------+--------+







delimiter //
create procedure p7 (n varchar(255))
begin
	delete from Employee where EmpName=n;
end; 
//
delimiter ;

call p7('ramana');
 SELECT * FROM Employee;
+-------+------------+--------+--------+---------+--------+
| EmpNo | EmpName    | Sex    | Salary | Address | DeptNo |
+-------+------------+--------+--------+---------+--------+
|     1 | vidhya     | female | 200000 | 333-c   |      1 |
|     2 | naveen     | male   | 200000 | 332-d   |      2 |
|     3 | devi       | female | 100000 | 332-c   |      1 |
|     5 | sangkeetha | female | 100000 | 31      |      2 |
+-------+------------+--------+--------+---------+--------+







delimiter //
create function p8 () returns int 
begin
	declare t int;
	select MAX(Salary) into t from Employee;
	return t;
end; 
//
delimiter ;

select * from Employee where salary = p8();
+-------+---------+--------+--------+---------+--------+
| EmpNo | EmpName | Sex    | Salary | Address | DeptNo |
+-------+---------+--------+--------+---------+--------+
|     1 | vidhya  | female | 200000 | 333-c   |      1 |
|     2 | naveen  | male   | 200000 | 332-d   |      2 |
+-------+---------+--------+--------+---------+--------+









delimiter //
create function p9 () returns int
begin
	declare t int;
	select COUNT(*) into t from Employee;
	return t;
end; 
//
delimiter ;

select p9();
+------+
| p9() |
+------+
|    4 |
+------+






delimiter //
create function p10 (n int) returns int
begin
	declare t int;
	select Salary into t from Employee where EmpNo=n;
	return t;
end; 
//
delimiter ;

select p10(1);
+--------+
| p10(1) |
+--------+
| 200000 |
+--------+







delimiter //
create function p11 (n int) returns int
begin
	declare t int;
	select AVG(Salary) into t from Employee group by DeptNo having DeptNo=n;
	return t;
end; 
//
delimiter ;

select p11(2);
+--------+
| p11(2) |
+--------+
| 150000 |
+--------+

or 

delimiter //
create function p11 (n int) returns int
begin
	declare t int;
	select AVG(Salary) into t from Employee where DeptNo=n;
	return t;
end; 
//
delimiter ;







delimiter //
create procedure p6 (n int)
begin
	select EmpName from Employee where DeptNo=n;
end; 
//
delimiter ;

call p6(2);
+------------+
| EmpName    |
+------------+
| naveen     |
| sangkeetha |
+------------+






delimiter //
create procedure dept_highest ()
begin
	select DeptNo,MAX(Salary) from Employee group by DeptNo;
end; 
//
delimiter ;

call dept_highest();
+--------+-------------+
| DeptNo | MAX(Salary) |
+--------+-------------+
|      1 |      200000 |
|      2 |      200000 |
+--------+-------------+







delimiter //
create function p12 () returns int
begin
	declare t int;
	select COUNT(*) into t from Employee where salary>50000;
	return t;
end; 
//
delimiter ;

select p12();
+-------+
| p12() |
+-------+
|     4 |
+-------+








delimiter //
create function p16 () returns int
begin
	declare t int;
	select COUNT(*) into t from Department where Location='chennai';
	return t;
end; 
//
delimiter ;

select p16();
+-------+
| p16() |
+-------+
|     0 |
+-------+





