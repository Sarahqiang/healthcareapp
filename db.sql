CREATE TABLE Mother
(qhcid INTEGER primary key not null ,
 name VARCHAR(30) not null ,
 address VARCHAR(100) not null,
 profession VARCHAR(30) not null ,
 phonenumber VARCHAR(100) not null UNIQUE ,
 email VARCHAR(100) not null,
 dateodbirth DATE not null ,
 bloodtype VARCHAR(10) not null,
 expectedbirthtime date not null );
CREATE TABLE Father
(fid INTEGER primary key not null,
 qhcid INTEGER ,
 name VARCHAR(30) not null ,
 address VARCHAR(100),
 profession VARCHAR(30) not null ,
 phonenumber VARCHAR(100) not null UNIQUE ,
 email VARCHAR(100),
 dateofbirth DATE not null ,
 bloodtype CHAR(1));
CREATE TABLE Facilities
(facilityid INTEGER primary key not null ,
 phonenumber VARCHAR(100) not null UNIQUE ,
 name VARCHAR(100) not null ,
 email VARCHAR(100) not null UNIQUE ,
 address VARCHAR(100) not null,
 website VARCHAR(100)

);

CREATE TABLE Midwife
(practitionerid INTEGER primary key NOT NULL,
 email VARCHAR(100) not null ,
 phonenumber VARCHAR(100) not null UNIQUE ,
 name VARCHAR(30) not null ,
 facilityid INTEGER not null ,
 FOREIGN KEY (facilityid) REFERENCES Facilities
);
CREATE TABLE Couple
(coupleid INTEGER primary key not null,
 qhcid INTEGER not null ,
 fid INTEGER,
 midwife INTEGER not null ,
 backupmidwife INTEGER,
 FOREIGN KEY (qhcid) REFERENCES MOTHER,
 FOREIGN KEY (fid) REFERENCES Father,
 FOREIGN KEY (midwife)REFERENCES Midwife,
 FOREIGN KEY (backupmidwife) REFERENCES Midwife
);

CREATE TABLE onlineinfosession
(sessionid INTEGER NOT NULL  PRIMARY KEY ,
 datetime DATE NOT NULL ,
 attended CHAR(5) ,
 language CHAR(30) not null ,
 practitionerid INTEGER not null ,
 FOREIGN KEY (practitionerid) REFERENCES Midwife
);
CREATE TABLE Registration
(
    sessionid INTEGER NOT NULL PRIMARY KEY  ,
    coupleid INTEGER NOT NULL  ,
    FOREIGN KEY (coupleid) REFERENCES Couple,
    FOREIGN KEY (sessionid) REFERENCES onlineinfosession);
CREATE TABLE Pregnancy
(pregid INTEGER NOT NULL PRIMARY KEY,
 coupleid INTEGER NOT NULL ,
 pregnancytime INTEGER NOT NULL ,
 finalestimatedduetime DATE NOT NULL ,
 facilityid INTEGER not null ,
 FOREIGN KEY (facilityid) REFERENCES Facilities,
 FOREIGN KEY (coupleid)REFERENCES Couple
);
CREATE TABLE Appointment
(appointmetid INTEGER NOT NULL  PRIMARY KEY ,
 date DATE NOT NULL ,
 atime TIME NOT NULL ,
 practitionerid INTEGER NOT NULL ,
 coupleid INTEGER NOT NULL ,
 FOREIGN KEY (practitionerid)REFERENCES Midwife,
 FOREIGN KEY (coupleid)REFERENCES Couple);
CREATE TABLE Note
(noteid INTEGER NOT NULL PRIMARY KEY ,
 DATETIME DATE NOT NULL ,
 practitionerid INTEGER NOT NULL ,
 appointmetid INTEGER NOT NULL   ,
 FOREIGN KEY (practitionerid) REFERENCES Midwife,
 FOREIGN KEY (appointmetid) REFERENCES Appointment
);
CREATE TABLE Technician
(techicianid INTEGER NOT NULL PRIMARY KEY ,
 phonenumber VARCHAR(100) not null UNIQUE ,
 name VARCHAR(30) NOT NULL );

CREATE TABLE TEST
(testid INTEGER not null  primary key ,
 technicianid INTEGER NOT NULL ,
 pregid INTEGER NOT NULL ,
 testdate DATE  ,
 type VARCHAR(100) NOT NULL ,
 perscribeddate DATE NOT NULL ,
 sampletakendate DATE ,
 expectedduedate DATE,
 result VARCHAR(100),
 practitionerid INTEGER ,
 coupleid INTEGER,
 FOREIGN KEY (practitionerid) REFERENCES Midwife,
 FOREIGN KEY (coupleid)REFERENCES Couple,
 FOREIGN KEY (pregid) REFERENCES Pregnancy,
 check ( perscribeddate<TEST.testdate or testdate is null )

);

CREATE TABLE Baby
(gender VARCHAR(30) ,
 pregid INTEGER NOT NULL ,
 dateopfbirth  DATE,
 bloodtype VARCHAR(30),
 coupleid INTEGER NOT NULL ,
 name VARCHAR(30),
 FOREIGN KEY (pregid) REFERENCES Pregnancy,
 FOREIGN KEY (coupleid)REFERENCES Couple);

drop table APPOINTMENT;
drop table BABY;
drop table COUPLE;
drop table FACILITIES;
drop table FATHER;
drop table MIDWIFE;
drop table MOTHER;
drop table NOTE;
drop table ONLINEINFOSESSION;
drop table PREGNANCY;
drop table REGISTRATION;
drop table TECHNICIAN;
drop table TEST;

INSERT INTO MOTHER
VALUES (11111,'Victoria Gutierrez','3440 durocher','sde','5353738273','dhfhdifhdifi@mail.mcgill.ca','2001-08-04','A','2022-02-23'),
       (11112,'Yaoqiang','3445durocher','computerscientist','5145536565','dhfdfk@gmial.com','2001-08-04','B','2022-08-03'),
       (11113,'zixiangluo','35373durocher','student','5357379383','38373939@qq.com','2001-08-08','A','2022-07-03'),
       (11114,'ehfedluo','73street','teacher','3353535353','dkddfdf39@yahoo.com','1998-09-08','O','2020-07-03'),
       (11115,'minzhefneg','353733durocher','student','5665565566','57689797080@qq.com','2001-08-08','A','2022-07-03');
INSERT INTO FATHER (fid,name,profession, phonenumber,dateofbirth)
VALUES(111,'yaoqiangwu','software developer','5355355363','2001-08-05'),
      (112,'leoluo','student','5363937363','2001-08-05'),
      (113,'sb','software developer','339383538','2001-08-05'),
      (114,'zeyuli','software developer','2398398303','2001-09-06'),
      (115,'yusentang','software developer','383093739','2001-08-05');
INSERT INTO Facilities (facilityid, phonenumber, name, email, address)
VALUES (2221,'36398374632','cutebirthcenter','eyeueueuu@qq.com','3444durocher'),
       (2222,'93847463424','mcgillclinic','dhfuhjefhef@qq.com','34393 steet'),
       (2223,'58739362544','mycommunityclinic','dfbebjebee@qq.com','3443 ddurocher'),
       (2224,'4583648372','LacSaint-Louis','dbcejene@qq.com','86644 rue durocher'),
       (2225,'40593836254','loveclinic','ejbnfekne@qq.com','3j44 streetdurocher');

INSERT INTO Midwife (practitionerid, email, phonenumber, name, facilityid)
VALUES (260890290,'dhdkdfj@mail.fjfdkj.ca','3536363737','Marion Girard',2221),
       (260890291,'dfdfd@mail.dfdfj.ca','3563738373','kevinxu',2221),
       (260890292,'fgsdswfj@mail.dffesdwwj.ca','3339993237','lukewu',2222),
       (260890293,'ahanhakaj@mail.ca','234335433','sarah',2224),
       (260890294,'fnkkfj j@mail..ca','9386353637','bianat',2224);
INSERT INTO Couple (coupleid, qhcid, fid, midwife, backupmidwife)
VALUES(121,11111,111,260890290,null),
      (122,11112,null,260890293,null),
      (123,11113,113,260890293,null),
      (124,11114,112,260890293,null),
      (125,11115,null,260890294,null);

INSERT INTO onlineinfosession (sessionid, datetime, attended, language, practitionerid)
VALUES(3331,'2020-08-08','yes','Chinese',260890290),
      (3332,'2020-09-02','yes','Chinese',260890290),
      (3333,'2021-10-08','no','English',260890293),
      (3334,'2021-12-08','yes','English',260890293),
      (3335,'2022-01-08','yes','French',260890293);
INSERT INTO REGISTRATION (sessionid, coupleid)
VALUES (3331,121),
       (3332,122),
       (3333,123),
       (3334,124),
       (3335,124);
INSERT INTO Pregnancy (pregid, coupleid, pregnancytime, finalestimatedduetime, facilityid)
VALUES(5551,121,1,'2020-07-07',2221),
      (5552,121,2,'2021-08-07',2221),
      (5553,122,1,'2022-07-07',2222),
      (5554,123,1,'2022-07-07',2223),
      (5555,124,1,'2022-07-05',2224);
INSERT INTO Appointment (appointmetid, date, atime, practitionerid, coupleid)
VALUES(6661,'2022-03-21','06:00',260890290,121),
      (6662,'2022-03-23','08:00',260890290,122),
      (6663,'2022-07-24','09:00',260890291,123),
      (6664,'2022-05-25','10:00',260890290,124),
      (6665,'2022-06-23','11:00',260890292,124);


INSERT INTO TECHNICIAN (techicianid, phonenumber, name)
VALUES(8881,'78979879789','jojo'),
      (8882,'64384638473','joey'),
      (8883,'3637463839','lukeji'),
      (8884,'38464838949','jheie'),
      (8885,'46493845362','fkfeec');

INSERT INTO TEST (testid, technicianid, pregid, testdate, type, perscribeddate, sampletakendate, expectedduedate, result, practitionerid, coupleid)
VALUES(7771,8881,5551,'2022-01-21','bloodiron','2022-01-19','2022-01-22','2022-01-25','60.4m/g',260890290,121),
      (7772,8881,5552,'2022-01-11','bloodiron','2022-01-10','2022-01-12','2022-01-25','50.4m/g',260890290,121),
      (7773,8882,5553,'2022-01-08','bloodiron','2022-01-07','2022-01-10','2022-01-12','70.4m/g',260890293,122),
      (7774,8883,5554,'2022-01-02','bloodiron','2022-01-01','2022-01-03','2022-01-10','30.4m/g',260890293,123),
      (7775,8884,5555,'2022-01-03','bloodiron','2022-01-02','2022-01-04','2022-01-11','80.4m/g',260890293,124);
INSERT INTO BABY (gender, pregid, dateopfbirth, bloodtype, coupleid, name)
VALUES('male',5552,'2022-03-05','A',121,NULL),
      ('female',5552,'2022-03-05','A',121,NULL),
      ('male',5553,'2022-08-04','A',121,NULL),
      ('male',5553,'2022-08-04','A',121,NULL),
      ('male',5554,'2022-07-03','A',121,NULL);
INSERT INTO NOTE (noteid, DATETIME, practitionerid, appointmetid)
VALUES (9991,'2022-03-21',260890290,6661),
       (9992,'2022-03-23',260890290,6662),
       (9993,'2022-07-24',260890291,6663),
       (9994,'2022-05-25',260890290,6664),
       (9995,'2022-06-23',260890292,6665);

SELECT Appointment.date,atime,MOTHER.qhcid,Mother.name,Mother.phonenumber
FROM Appointment
         left join COUPLE C2 on Appointment.coupleid = C2.COUPLEID
         JOIN Midwife M on M.practitionerid = Appointment.practitionerid
         Join MOTHER  on C2.qhcid = Mother.QHCID
WHERE(M.name='Marion Girard'and Appointment.date>='2022-03-21'and Appointment.date<='2022-03-25');


SELECT testdate,result
FROM TEST JOIN Couple C2 on C2.coupleid = TEST.coupleid
          JOIN MOTHER M on C2.qhcid = M.QHCID
          JOIN PREGNANCY P on C2.coupleid = P.COUPLEID
WHERE (M.name='Victoria Gutierrez'AND P.pregnancytime=2);

SELECT Facilities.name,COUNT(*) AS nums
FROM Facilities JOIN Midwife M on Facilities.facilityid = M.facilityid
                JOIN Pregnancy P on Facilities.facilityid = P.facilityid
                JOIN Couple C2 on C2.coupleid = P.coupleid
                JOIN MOTHER M2 on C2.qhcid = M2.QHCID
WHERE (
              (P.finalestimatedduetime >='2022-07-01'AND P.finalestimatedduetime <='2022-07-31')
              or
              (p.finalestimatedduetime IS NULL AND M2.expectedbirthtime>='2022-07-01'AND M2.expectedbirthtime<='2022-07-31')
          )
GROUP BY Facilities.name;


SELECT Mother.qhcid,Mother.name,Mother.phonenumber
FROM Mother LEFT JOIN COUPLE C2 on Mother.qhcid = C2.QHCID
            LEFT JOIN Midwife M on M.practitionerid = C2.midwife
            LEFT JOIN PREGNANCY P on C2.coupleid = P.COUPLEID
            LEFT JOIN Facilities F on F.facilityid = M.facilityid
WHERE (f.name='LacSaint-Louis'and (p.finalestimatedduetime >current_date or p.finalestimatedduetime is null));

SELECT DISTINCT MOTHER.qhcid,Mother.name
FROM MOTHER LEFT JOIN COUPLE C2 on Mother.qhcid = C2.QHCID
            LEFT JOIN PREGNANCY P on C2.coupleid = P.COUPLEID
            LEFT JOIN BABY B on C2.coupleid = B.COUPLEID
GROUP BY p.pregid ,Mother.qhcid, Mother.name
HAVING COUNT(*)>1;

CREATE INDEX index_name   /* Create Index */
    ON table_name (column_1, column_2);
DROP INDEX index_name;   /* Drop Index */


CREATE VIEW midwifeinfo (practitionerid, email, phonenumber, name, facilityid,fname)
AS SELECT DISTINCT MIDWIFE.practitionerid,MIDWIFE.email,MIDWIFE.phonenumber,Midwife.name,MIDWIFE.facilityid,F.name
   FROM MIDWIFE LEFT JOIN Facilities F on F.facilityid = Midwife.facilityid;
SELECT *
FROM midwifeinfo
LIMIT 5;
SELECT *
FROM midwifeinfo
WHERE fname='LacSaint-Louis'
LIMIT 5;
INSERT INTO midwifeinfo (practitionerid, email, phonenumber, name, facilityid, fname)
values (23223232,'4779298@fnkf.com','3729293293','hfefje',393098,'nfekfejf');
DROP VIEW midwifeinfo


INSERT INTO TEST (testid, technicianid, pregid, testdate, type, perscribeddate, sampletakendate, expectedduedate, result, practitionerid, coupleid)
VALUES(7777,8881,5551,'2022-01-10','bloodiron','2022-01-19','2022-01-22','2022-01-25','60.4m/g',260890290,121)












































INSERT INTO Appointment (appointmetid, date, atime, practitionerid, coupleid)
VALUES(6666,'2022-03-29','06:00',260890290,121),
      (6667,'2022-03-29','08:00',260890290,122);
UPDATE COUPLE
SET MIDWIFE = 260890291
WHERE COUPLEID=124;
SELECT ATIME,'P' AS TYPE,MOTHER.name,MOTHER.QHCID,APPOINTMETID,PREGID,C2.COUPLEID
FROM APPOINTMENT LEFT JOIN COUPLE C2 on C2.COUPLEID = APPOINTMENT.COUPLEID and APPOINTMENT.PRACTITIONERID=C2.MIDWIFE
LEFT JOIN MOTHER  on C2.QHCID = MOTHER.QHCID
WHERE APPOINTMENT.DATE='2022-03-29' AND C2.MIDWIFE =260890290
UNION SELECT ATIME,'B' AS TYPE,MOTHER.name,MOTHER.QHCID,C3.COUPLEID
FROM APPOINTMENT LEFT JOIN COUPLE C3 on APPOINTMENT.COUPLEID = C3.COUPLEID AND APPOINTMENT.PRACTITIONERID=C3.BACKUPMIDWIFE
LEFT JOIN MOTHER  on C3.QHCID = MOTHER.QHCID
WHERE APPOINTMENT.DATE='2022-03-29' AND C3.BACKUPMIDWIFE=260890290
ORDER BY ATIME;

ALTER TABLE NOTE
 ADD content varchar(10000);

ALTER TABLE NOTE
    ADD NTIME TIME;

INSERT INTO NOTE(NOTEID, DATETIME, PRACTITIONERID, APPOINTMETID,content,NTIME)
VALUES (9996,'2022-04-29',260890290,6666,' Baby has good movements','10:02:45'),
       (9997,'2022-05-29',260890290,6666,' Couple would prefer home birth.','14:22:05');

DELETE FROM NOTE WHERE NOTEID =9997;

SELECT NOTE.DATETIME, NTIME,CONTENT
FROM NOTE LEFT JOIN APPOINTMENT A on A.APPOINTMETID = NOTE.APPOINTMETID
LEFT JOIN COUPLE C2 on C2.COUPLEID = A.COUPLEID
LEFT JOIN MOTHER M on M.QHCID = C2.QHCID
WHERE M.QHCID='11111'  AND A.APPOINTMETID=6666 AND LENGTH(NOTE.content)<=50
ORDER BY NTIME DESC ;

ALTER TABLE APPOINTMENT
    ADD FOREIGN KEY (PREGID)  REFERENCES PREGNANCY(PREGID);

UPDATE APPOINTMENT SET PREGID = 5552 WHERE APPOINTMETID=6661;
UPDATE APPOINTMENT SET PREGID = 5553 WHERE APPOINTMETID=6662;
UPDATE APPOINTMENT SET PREGID = 5554 WHERE APPOINTMETID=6663;
UPDATE APPOINTMENT SET PREGID = 5555 WHERE APPOINTMETID=6664;
UPDATE APPOINTMENT SET PREGID = 5555 WHERE APPOINTMETID=6665;
UPDATE APPOINTMENT SET PREGID = 5552 WHERE APPOINTMETID=6666;
UPDATE APPOINTMENT SET PREGID = 5553 WHERE APPOINTMETID=6667;

SELECT DISTINCT PERSCRIBEDDATE,TYPE,RESULT,TESTID
FROM APPOINTMENT JOIN TEST T on APPOINTMENT.PREGID = T.PREGID
WHERE APPOINTMENT.PREGID = 5552;

INSERT INTO NOTE(noteid, datetime, practitionerid, appointmetid, content, ntime)
VALUES (9998,current_date ,260890290,6666,'baby is nice',current_time );

SELECT NOTEID FROM NOTE ORDER BY NOTEID DESC LIMIT 1

INSERT INTO TEST(TESTID, TECHNICIANID, PREGID, TESTDATE, TYPE, PERSCRIBEDDATE, SAMPLETAKENDATE, EXPECTEDDUEDATE, RESULT, PRACTITIONERID, COUPLEID)
VALUES (7777,8881,5552,NULL,'bloodtype',CURRENT_DATE,CURRENT_DATE,NULL,NULL,260890290,121)



SELECT * FROM MIDWIFE WHERE PRACTITIONERID =2777777;

SELECT MOTHER.QHCID ,MOTHER.NAME,PREGID
FROM MOTHER LEFT JOIN  COUPLE C2 on MOTHER.QHCID = C2.QHCID
LEFT JOIN PREGNANCY P on C2.COUPLEID = P.COUPLEID
WHERE MOTHER.NAME='Victoria Gutierrez';

SELECT DISTINCT NOTEID,C2.COUPLEID,PREGNANCYTIME,CONTENT
FROM APPOINTMENT LEFT JOIN PREGNANCY P on APPOINTMENT.PREGID = P.PREGID
LEFT JOIN NOTE N on APPOINTMENT.APPOINTMETID = N.APPOINTMETID
LEFT JOIN COUPLE C2 on APPOINTMENT.COUPLEID = C2.COUPLEID
LEFT JOIN MOTHER M on C2.QHCID = M.QHCID
WHERE M.NAME='Victoria Gutierrez';

SELECT DISTINCT TESTID,TYPE,C2.COUPLEID,PREGNANCYTIME
FROM TEST LEFT JOIN PREGNANCY P on P.PREGID = TEST.PREGID
          LEFT JOIN COUPLE C2 on C2.COUPLEID = P.COUPLEID
          LEFT JOIN MOTHER M on C2.QHCID = M.QHCID
WHERE M.NAME='Victoria Gutierrez';

SELECT DISTINCT NOTEID,C2.COUPLEID,PREGNANCYTIME,CONTENT
FROM APPOINTMENT LEFT JOIN PREGNANCY P on APPOINTMENT.PREGID = P.PREGID
                 LEFT JOIN NOTE N on APPOINTMENT.APPOINTMETID = N.APPOINTMETID
                 LEFT JOIN COUPLE C2 on APPOINTMENT.COUPLEID = C2.COUPLEID
                 LEFT JOIN MOTHER M on C2.QHCID = M.QHCID
WHERE M.NAME='Yaoqiang';

SELECT DISTINCT TESTID,TYPE,C2.COUPLEID,PREGNANCYTIME
FROM TEST LEFT JOIN PREGNANCY P on P.PREGID = TEST.PREGID
          LEFT JOIN COUPLE C2 on C2.COUPLEID = P.COUPLEID
          LEFT JOIN MOTHER M on C2.QHCID = M.QHCID
WHERE M.NAME='Yaoqiang';

INSERT INTO APPOINTMENT(APPOINTMETID, DATE, ATIME, PRACTITIONERID, COUPLEID, PREGID)
VALUES (6668,'2022-07-24','08:00:00',260890291,124,5555)

DELETE FROM NOTE WHERE NOTEID=9998;
DELETE FROM NOTE WHERE NOTEID=9999;
DELETE FROM NOTE WHERE NOTEID=9991;

UPDATE APPOINTMENT
SET PRACTITIONERID =260890290
WHERE APPOINTMETID=6663;

UPDATE COUPLE
 SET BACKUPMIDWIFE=260890290
WHERE COUPLEID=123;
