
--Delete everything before recreate:

DROP TABLE Emp_Img;
DROP TABLE IMAGES;
ALTER TABLE DEPARTMENTS drop constraint DEPARTMENTS_MANAGER_fk;
DROP TABLE EMPLOYEES;
DROP TABLE DEPARTMENTS;
DROP TABLE PEOPLE;
/**/

CREATE TABLE PEOPLE(
	Person_id integer,
    BestvectorfFace varchar(3000),
    BestTimeCaptured timestamp, 
    constraint People_pk primary key (Person_id)
);
CREATE TABLE DEPARTMENTS(
	Dept_ID char(7),
    Department nVarChar2(70),
    Manager_ID integer,
    Description nvarchar2 (2000),
    constraint Dept_pk primary key (Dept_ID)
);
CREATE TABLE EMPLOYEES(
	Emp_ID integer,
    FullName nvarchar2(70),
    BirthDate Date,
    Gender varchar(1) DEFAULT '?',
    cmnd char(18),
    Address nvarchar2(2000),
    Phone char(15),
    Dept_ID char(7),
    Email char(70),
    constraint Emp_PK primary key(Emp_ID),
    constraint Gender_Validity check ((Gender is not null) and(Gender in ('F','M','L','G','B','T','Q'))),
    constraint Emp_ID_fk foreign key (Emp_ID) references PEOPLE(Person_id) ,
    constraint Dept_fk foreign key (Dept_ID) references DEPARTMENTS(Dept_id)
);
ALTER TABLE DEPARTMENTS ADD constraint DEPARTMENTS_MANAGER_fk 
     foreign key (Manager_ID) references  EMPLOYEES(Emp_ID);

CREATE TABLE IMAGES(
    Img_ID varchar(20),
    Image blob,
    TimeRecorded Timestamp,
    constraint Image_PK Primary key(Img_ID)   
);

create table EMP_IMG(
    Person_ID integer,
    Img_ID varchar(20),
    BoundingBox_Left int,
    BoundingBox_Top int,
    BoundingBox_Right int,
    BoundingBox_Down int,
    VectorFace varchar(3000), 
    constraint Emp_Img_pk Primary key(Person_ID, Img_ID),
    constraint Emp_Img_img_fk FOREIGN key (Img_ID) references IMAGES(Img_ID),
    constraint Emp_Img_People_fk FOREIGN key (Person_ID) references PEOPLE(Person_ID)
);
commit;