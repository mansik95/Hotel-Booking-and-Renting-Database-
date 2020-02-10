Log Table Syntax :

Create Person Log Table :

create table create_person_table_logs
(
LOGID INT NOT  NULL AUTO_INCREMENT,
 PersonID INT NOT NULL,
  Email VARCHAR(50) NOT NULL,
  Password VARCHAR(50) NOT NULL,
  TimeStamp datetime,
  primary key(logid)
);


Trigger :
delimiter //
create trigger create_person_log
after insert
on person
for each row
begin
insert into create_person_table_logs(personid,email,password,timestamp) values (new.personID,new.emailID,md5(new.password),now());
end
//

Update Person Log Table :
Query:
CREATE TABLE person_table_update_logs (
LogID int not null auto_increment,
PersonID INT,
OldFirstName VARCHAR(50) ,
NewFirstName VARCHAR(50) ,
OldLastName VARCHAR(50) ,
NewLastName VARCHAR(50) ,
OldEmail VARCHAR(50) ,
NewEmail VARCHAR(50) ,
OldPassword VARCHAR(50) ,
NewPassword VARCHAR(50) ,
OldPhoto BLOB(100) ,
NewPhoto BLOB(100) ,
OldBirthDate DATE ,
NewBirthDate DATE,
OldPhoneNumber VARCHAR(15) ,
NewPhoneNumber VARCHAR(15) ,
OldGender ENUM('MALE', 'FEMALE') ,
NewGender ENUM('MALE', 'FEMALE') ,
OldAccountStatus ENUM('ACTIVE', 'INACTIVE'),
NewAccountStatus ENUM('ACTIVE', 'INACTIVE') ,
TimeStamp datetime,
PRIMARY KEY (`LogID`)
);
drop table person_table_update_logs

Trigger:
delimiter //
create trigger update_person_record
after update
on person
for each row
begin 
if(new.firstName!=old.firstName) then
insert into person_table_update_logs(PersonId,OldFirstName,NewFirstName,TimeStamp)
values (new.personID,old.firstName,new.firstName,now());
end if;

if(new.lastName!=old.lastName) then
insert into person_table_update_logs(PersonId,OldLastName,NewLastName,TimeStamp)
values (new.personID,old.lastName,new.lastName,now());
end if;

if(new.emailID!=old.emailID) then
insert into person_table_update_logs(PersonId,Oldemail,Newemail,TimeStamp)
values (new.personID,old.emailID,new.emailID,now());
end if;

if(new.password!=old.password) then
insert into person_table_update_logs(PersonId,Oldpassword,Newpassword,TimeStamp)
values (new.personID,md5(old.password),md5(new.password),now());
end if;

if(new.photo!=old.photo) then
insert into person_table_update_logs(PersonId,Oldphoto,Newphoto,TimeStamp)
values (new.personID,old.photo,new.photo,now());
end if;

if(new.birthDate!=old.birthDate) then
insert into person_table_update_logs(PersonId,OldbirthDate,NewbirthDate,TimeStamp)
values (new.personID,old.birthDate,new.birthDate,now());
end if;

if(new.phoneNumber!=old.phoneNumber) then
insert into person_table_update_logs(PersonId,OldphoneNumber,NewphoneNumber,TimeStamp)
values (new.personID,old.phoneNumber,new.phoneNumber,now());
end if;

if(new.gender!=old.gender) then
insert into person_table_update_logs(PersonId,Oldgender,Newgender,TimeStamp)
values (new.personID,old.gender,new.gender,now());
end if;

if(new.accountStatus!=old.accountStatus) then
insert into person_table_update_logs(PersonId,OldaccountStatus,NewaccountStatus,TimeStamp)
values (new.personID,old.accountStatus,new.accountStatus,now());
end if;

end
//

Testing :
select * from person_table_update_logs

update person set firstname='Dad' where personID=7;

