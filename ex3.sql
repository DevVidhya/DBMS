CREATE TABLE Hostel (hno int, hname varchar(255), type varchar(255), PRIMARY KEY(hno));

CREATE TABLE Menu (hno int, day varchar(255), breakfast varchar(255), lunch varchar(255), dinner varchar(255), FOREIGN KEY(hno) REFERENCES Hostel(hno));

CREATE TABLE Warden (wname varchar(255), qual varchar(255), hno int, FOREIGN KEY(hno) REFERENCES Hostel(hno));

CREATE TABLE Student (sid int, sname varchar(255), gender varchar(255), year int, hno int, PRIMARY KEY(sid), FOREIGN KEY(hno) REFERENCES Hostel(hno));

insert into Hostel values(1,'opal','girls');
insert into Hostel values(2,'agate','boys');
insert into Hostel values(3,'coral','boys');

insert into Menu values(1,'monday','idly','sambar','idly');
insert into Menu values(1,'tuesday','dosa','biriyani','dosa');
insert into Menu values(1,'wednesday','vada','pulav','vada');
insert into Menu values(1,'thursday','idly','sambar','idly');
insert into Menu values(1,'friday','dosa','biriyani','dosa');
insert into Menu values(1,'saturday','vada','pulav','vada');
insert into Menu values(1,'sunday','paratha','chicken','paratha');

insert into Menu values(2,'tuesday','idly','sambar','idly');
insert into Menu values(2,'wednesday','dosa','biriyani','dosa');
insert into Menu values(2,'thursday','vada','pulav','vada');
insert into Menu values(2,'friday','idly','sambar','idly');
insert into Menu values(2,'saturday','dosa','biriyani','dosa');
insert into Menu values(2,'monday','vada','pulav','vada');
insert into Menu values(2,'sunday','paratha','chicken','paratha');

insert into Menu values(3,'wednesday','idly','sambar','idly');
insert into Menu values(3,'thursday','dosa','biriyani','dosa');
insert into Menu values(3,'friday','vada','pulav','vada');
insert into Menu values(3,'saturday','idly','sambar','idly');
insert into Menu values(3,'monday','dosa','biriyani','dosa');
insert into Menu values(3,'tuesday','vada','pulav','vada');
insert into Menu values(3,'sunday','paratha','chicken','paratha');

insert into Warden values('kala','B.Com',1);
insert into Warden values('mala','B.SC',2);
insert into Warden values('leela','M.SC',3);

insert into Student values(1,'vidhya','female',3,1);
insert into Student values(2,'kaviya','female',2,1);
insert into Student values(3,'devi','female',1,1);
insert into Student values(4,'naveen','male',3,2);
insert into Student values(5,'amruth','male',2,2);
insert into Student values(6,'venu','male',1,2);
insert into Student values(7,'moorthy','male',3,3);
insert into Student values(8,'bala','male',2,3);
insert into Student values(9,'ramana','male',1,3);




