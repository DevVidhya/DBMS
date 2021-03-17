CREATE TABLE Department (deptid int, deptname varchar(255), PRIMARY KEY(deptid));

CREATE TABLE Student (rollno int, name varchar(255), gender varchar(255), mark1 int, mark2 int, mark3 int, total int,average int, deptid int, PRIMARY KEY(rollno), FOREIGN KEY(deptid) REFERENCES Department(deptid));

CREATE TABLE Staff (staffid int, name varchar(255), designation varchar(255), qualification varchar(255), deptid int, PRIMARY KEY(staffid), FOREIGN KEY(deptid) REFERENCES Department(deptid));

CREATE TABLE Tutor (rollno int, staffid int, FOREIGN KEY(rollno) REFERENCES Student(deptid),FOREIGN KEY(staffid) REFERENCES Staff(staffid) );

INSERT INTO Department values (1,'cse');
INSERT INTO Department values (2,'ece');

INSERT INTO Student values (1,'vidhya','female',90,90,90,0,0,1);
INSERT INTO Student values (2,'naveen','male',100,100,100,0,0,1);
INSERT INTO Student values (3,'amruth','male',80,80,80,0,0,2);
INSERT INTO Student values (4,'boobalan','male',70,70,70,0,0,2);

INSERT INTO Staff values (10,'mala','Professor','Phd',1);
INSERT INTO Staff values (11,'leela','Professor','Phd',2);

INSERT INTO Tutor values (1,10);
INSERT INTO Tutor values (3,10);
INSERT INTO Tutor values (2,11);
INSERT INTO Tutor values (4,11);

UPDATE Student SET total=(mark1+mark2+mark3);
UPDATE Student SET average=total/3;

SELECT * FROM Department;
SELECT * FROM Student;
SELECT * FROM Staff;
SELECT * FROM Tutor;


