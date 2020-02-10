Insert Person :

insert into person values (1,'Sanika','Bhagat','sanika.s.bhagat@gmail.com',md5('qwert'),'C:\Users\sanik\Desktop\NEU Subjects\DMDD\ER1.png','1993/12/08','8578004072','Male','Active');
insert into person values (2,'Gauri','Chavan','gauri.chavan@gmail.com',md5('zxcvb'),'C:\Users\sanik\Desktop\NEU Subjects\DMDD\ER1.png','1992/09/05','5186704072','Female','Active');
insert into person values (3,'Vikas','Singh','vikas.singh@gmail.com',md5('hgfrt'),'C:\Users\sanik\Desktop\NEU Subjects\DMDD\ER1.png','1993/12/08','8576534689','Male','Active');
insert into person values (4,'Himanshu','Bhagat','himanshu.s.bhagat@gmail.com',md5('mbvssw'),'C:\Users\sanik\Desktop\NEU Subjects\DMDD\ER1.png','1989/05/12','8572688090','Male','Active');
insert into person values (5,'Sadhana','Bhagat','sadhana.s.bhagat@gmail.com',md5('uhrc'),'C:\Users\sanik\Desktop\NEU Subjects\DMDD\ER1.png','1964/09/23','9967307187','Female','Active');
insert into person values (6,'Sambhaji','Bhagat','sambhaji.s.bhagat@gmail.com',md5('wsccb'),'C:\Users\sanik\Desktop\NEU Subjects\DMDD\ER1.png','1962/07/14','9820251011','Male','Active');
insert into person values (7,'Preshita','Chaudhari','preshita.chaudhari@gmail.com',md5('cbsfsdfjb'),'C:\Users\sanik\Desktop\NEU Subjects\DMDD\ER1.png','1993/11/26','9969169369','Female','Active');
insert into person values (8,'Tanmayee','Varpe','tanmayee.varpe@gmail.com',md5('odhuqd'),'C:\Users\sanik\Desktop\NEU Subjects\DMDD\ER1.png','1993/12/31','9833304498','Female','Active');
insert into person values (9,'Mohit','Nangare','mohit.nangare@gmail.com',md5('cmsbd'),'C:\Users\sanik\Desktop\NEU Subjects\DMDD\ER1.png','1993/10/23','9324022277','Male','Active');
insert into person values (10,'Rituja','Gupte','rituja.gupte@gmail.com',md5('lksvts'),'C:\Users\sanik\Desktop\NEU Subjects\DMDD\ER1.png','1992/12/12','9773424474','Female','Active');


Insert Customer :

insert into customer values(1,'credit card','1234567887654321','234','Sanika Bhagat');
insert into customer values(2,'debit card','4779967699739193','436','Gauri Chavan');
insert into customer values(3,'credit card','3623807819164948','293','Vikas Singh');
insert into customer values(4,'debit card','1234567887654321','236','Himanshu Bhagat');
insert into customer values(5,'credit card','8341245715421217','987','Sadhana Bhagat');
insert into customer values(6,'debit card','1748590099750292','679','Sambhaji Bhagat');
insert into customer values (7,'credit card','2345678912345678','762','Preshita Chaudhari')


Insert Host :

insert into host values(1,'Santander','checking','36552587167','75908686');
insert into host values(2,'BOFA', 'checking','02812679024','38051212');
insert into host values(3,'Citi', 'checking','97487333861','65388827');



Insert Location :

insert into location values (110,'US','New York','Huntington Station',11746);
insert into location(country,state,city,zipcode) values ('US','Arizona','Pheonix',85001);
insert into location values (112,'US','Massachusetts','Boston',02115);


Insert House :

insert into house values (1,19,'Saint Germain Street',6,'Available',50,112,1);
insert into house values (2,10,'May Street',8,'Available',100,110,1);
insert into house values (3,53,'BLack Canyon',54,'Available',75,111,2);
insert into house values (4,23,'Arizona Grand',2,'Available',120,111,3);	
insert into house values (5,27,'Cave Creek',1024,'Available',20,111,2);
insert into house values (6,75,'Cityview',612,'Available',83,112,2);





Insert Feedback :

insert into feedback values(1,'AirBNB is good',curtime(),1);
insert into feedback values(2,'AirBNB is the best renting website',curtime(),1);
insert into feedback values(3,'AirBNB is moderate',curtime(),2);
insert into feedback values(4,'AirBNB provides good services',curtime(),3);
insert into feedback values(5,'AirBNB is good',curtime(),1);
insert into feedback values (6,'AirBNB is bad',now(),6);
insert into feedback values (7,'AirBNB service is worse than many other websites',now(),5);


Insert Facilities :

insert into facilities values (1,'Wifi');
insert into facilities values (2,'AC');
insert into facilities values (3,'Closet/Drawer');
insert into facilities values (4,'TV');
insert into facilities values (5,'Heat');
insert into facilities values (6,'Breakfast');
insert into facilities values (7,'Workspace');




Insert into House Facilities :

insert into house_facilities values (1,1);
insert into house_facilities values (2,1);
insert into house_facilities values (4,1);
insert into house_facilities values (5,1);
insert into house_facilities values (1,2);
insert into house_facilities values (2,2);
insert into house_facilities values (3,2);
insert into house_facilities values (4,2);
insert into house_facilities values (5,2);
insert into house_facilities values (6,2);
insert into house_facilities values (7,2);
insert into house_facilities values (1,3);
insert into house_facilities values (5,4);
insert into house_facilities values (6,4);
insert into house_facilities values (7,5);
insert into house_facilities values (6,5);
insert into house_facilities values (5,5);
insert into house_facilities values (1,5);
insert into house_facilities values (1,6);
insert into house_facilities values (5,6);
insert into house_facilities values (4,6);





Insert Booking :

insert into booking(BookingID,bookingStartDate,BookingEndDate,bookingStatus,houseID,CustomerID,timestamp) values (1,'2017/12/08','2017/12/12','open',1,1,now());
insert into booking(BookingID,bookingStartDate,BookingEndDate,bookingStatus,houseID,CustomerID,timestamp) values (2,'2018/01/01','2018/01/03','open',1,1,now());
insert into booking(BookingID,bookingStartDate,BookingEndDate,bookingStatus,houseID,CustomerID,timestamp) values (3,'2018/03/08','2018/03/12','open',2,2,now());
insert into booking(BookingID,bookingStartDate,BookingEndDate,bookingStatus,houseID,CustomerID,timestamp) values (4,'2017/12/23','2017/12/25','open',3,3,now());
insert into booking(BookingID,bookingStartDate,BookingEndDate,bookingStatus,houseID,CustomerID,timestamp) values (5,'2017/12/29','2017/12/31','open',6,4,now());
insert into booking(BookingID,bookingStartDate,BookingEndDate,bookingStatus,houseID,CustomerID,timestamp) values (6,'2018/02/08','2018/02/14','open',5,4,now());




Insert Review :

insert into review values (1,'The house is just perfect for a family vacation. Totally enjoyed staying here','2017-10-08 11:00:00',1,6);
insert into review values (2,'The house is the most beautiful house I have ever stayed in','2017-09-08 09:00:00',2,2);
insert into review values (3,'The house lacked the basic amenities such as heat and wifi. Not a good experience','2017-09-08 01:00:00',4,5);
insert into review values (4,'There were no hotels or stores close to this house. I almost died of hunger.','2017-01-01 12:00:00',4,6);
insert into review values (5,'The house has a nice scenic view','2017-08-08 09:00:00',1,1);
insert into review values (6,'Did not enoy staying here.','2016-12-23 09:00:00',3,3);
insert into review values (7,'I can never get bored of this house. Just love staying here.',now(),2,2);
insert into review values (8,'My parents love this house because it has a country touch to it','2017-09-08 09:00:00',1,4);
insert into review values (9,'Worst place ever','2017-09-08 09:00:00',6,3);
insert into review values (10, 'Nice place','2017-09-08 09:00:00',4,2);




Insert Rating :

insert into rating values(1,'2','Very Rude and Arrogant','2','Very loud and left the house dirty',1,1,1); 
insert into rating values(2,'5','Best Host ever','4','Nice Guests',1,1,2); 
insert into rating values(3,'1','Poor Treatment','2','Good enough',2,2,3); 
insert into rating values(4,'4','Good','4','Decent People',3,3,4); 
insert into rating values(5,'3','Boring Host','4','Friendly Guests',4,2,5); 
insert into rating values(6,'2','Hostile','1','Very ill mannered',4,2,6); 
