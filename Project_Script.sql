Scenarios :

Scenario 1:
To check the way the encryption and image is stored in the DB.

Query :
Select * from person;

------------------------------------------------------------------------------------------------------------------------------------------

Scenario 2:
Check how many Users are both Customers and Hosts with their contact information 

Query :
select firstname as 'Person First Name', lastName as 'Person Last Name', emailID as 'Person Email ID', phoneNumber as 'Person Phone Number' from  person 
where personID in (select customerID from customer where customerID in (select hostID from host where customerID=hostID));

------------------------------------------------------------------------------------------------------------------------------------------

Scenario 3 :
Find out the number of positive feedback received by AirBNB Enterprise.

Query:
create view view_positive_feedback
as
select * from feedback
where feedbackDescription like '%good%' or feedbackDescription like '%best%';


select * from view_positive_feedback;

------------------------------------------------------------------------------------------------------------------------------------------

Scenario 4 :
Find out the number of negative feedback received by AirBNB Enterprise.

Query:
create view view_negative_feedback
as
select * from feedback
where feedbackDescription like '%bad%' or feedbackDescription like '%worse%';

select * from view_negative_feedback;

------------------------------------------------------------------------------------------------------------------------------------------

Scenario 5 :
Find the Number of feedbacks given by each person to the AIRBNB enterprise.

Query :
SELECT feedback.personID, firstName,lastName, COUNT(*) as 'Number of Feedbacks' FROM feedback
inner join person
on person.personID=feedback.personID
GROUP BY personID 
ORDER BY 'Number of Feedbacks' DESC;

------------------------------------------------------------------------------------------------------------------------------------------

Scenario 6 :
To find the number of houses in each location.

Query:
create view view_max_houses_location
as
SELECT house.LocationID, country,state, city, COUNT(*) as 'Number of Houses' FROM house
inner join location
on house.locationID=location.locationID
GROUP BY locationID 
ORDER BY 'Maximum Houses';

select * from view_max_houses_location;

------------------------------------------------------------------------------------------------------------------------------------------

Scenario 7 :
Find the host who has maximum number of houses put up on rent

Query :
create view view_max_houses_host
as
SELECT hostID, FirstName,lastName, COUNT(*) as NumberofHouses FROM house
inner join person
on house.hostID=person.personID
GROUP BY hostID 
ORDER BY NumberofHouses desc
limit 1;

select * from view_max_houses_host;

------------------------------------------------------------------------------------------------------------------------------------------


Scenario 8 :
Find the Customer who has the highest number of bookings

Query :
create view view_max_customer_booking
as
SELECT PersonID, FirstName,lastName, count(*) as NumberofBookings FROM Booking
inner join Person
on Booking.CustomerID=person.personID
GROUP BY CustomerID 
ORDER BY NumberofBookings desc;

select * from view_max_customer_booking;

------------------------------------------------------------------------------------------------------------------------------------------

Scenario 9 :
IF person deactivates his account and if the person is a host, then the house listing posted by the host should be deleted.

Query :
delimiter //
create trigger delete_house_of_host
after update
on person
for each row
begin
if new.accountStatus= 'inactive'
then
delete from house where house.hostID=new.personID;
end if;
end
//


select * from house;
select * from person;
update person set accountStatus = 'inactive' where personId=3;
select * from person;
select * from house;

------------------------------------------------------------------------------------------------------------------------------------------

Scenario 10
If a person wants to delete his account and the person is a customer, then he should not be able to delete his account if he has made atleast one booking .

Query :
Create
delimiter //
create trigger delete_customer_without_booking
after update
on person
for each row
begin
if new.accountStatus= 'inactive'
then
if (new.personID in (Select customerID from booking))
then 
insert into message values ('Cannot delete customer');
end if;
else
delete from booking where booking.customerID=new.personID;
end if;
end
//

create table message
(
messagename varchar(200)
);

select * from booking

update person set accountStatus = 'inactive' where personId=3;

select messageName as 'Action' from message;

select * from person; 

------------------------------------------------------------------------------------------------------------------------------------------

Scenario 11 :
Suppose a person deleted his account and want to activate it again. Then a new row should not be created but the status of the person in the person table should be made active.

Query :
delimiter //
create procedure sp_active_person(in email varchar(200))
begin
update person set accountstatus='active'
where EMailID=email;
end
//

update person set accountStatus = 'inactive' where personId=3;

Select * from person

call sp_active_person('vikas.singh@gmail.com');

Select * from person

------------------------------------------------------------------------------------------------------------------------------------------

Scenario 12 :
If a booking is done, the payment table should get populated and the after the payment table, the airbnb_earnings and host_earnings should be populated.

Query :
To get the booking cost in the booking table 
delimiter //
create procedure sp_bookingcost_in_booking ()
begin
/*create view view_booking*/
update booking join
(select booking.houseid,(booking.BookingStartDate-booking.BookingEndDate)*house.CostPerNight as bookingAmount from booking inner join house on house.houseid=booking.houseid) temp
on booking.houseid=temp.houseid
set finalCost=temp.bookingAmount;
select bookingId,houseID,bookingStartDate,bookingEndDate,finalCost from Booking;
end 
//


Creating a dummy table booking_dummy

create table booking_dummy
	(
	BookingID int,
	BookingStartDate date,
	BookingEndDate date,
	BookingStatus varchar(20),
	HouseID int,
	CustomerID int,
	FinalCost double,
	timestamp datetime
	);

	
Populating the dummy table
 
delimiter //
create procedure insert_into_dummy()
begin
insert into booking_dummy 
select * from booking order by timestamp desc limit 1;
end;
//


delimiter //
create trigger insert_into_paymenttable
after insert
on booking_dummy
for each row
begin
insert into payment(paymentAmount, timeStamp,BookingID) values (new.finalCost,now(),new.BookingID);
end
//

   
delimiter //
create trigger airbnb_trigger
after insert
on payment
for each row
begin
insert into `airbnb earnings` values (new.paymentID,new.paymentAmount*0.7);
end
//


delimiter //
create trigger host_earnings_trigger
after insert
on payment
for each row
begin
insert into `host earnings` values (new.paymentID,new.paymentAmount*0.3);
end
//


insert into booking(bookingID,BookingStartDAte,BookingEndDate,BookingStatus,HouseID,CustomerID,timestamp) values (4,'2017-12-08','2017-12-12','OPEN','1','1',now());

call sp_bookingcost_in_booking();

call insert_into_dummy();

------------------------------------------------------------------------------------------------------------------------------------------

Scenario 13:
How to find out the total earnings of the host till datetime

Query :
delimiter //
create procedure host_earnings_particular_host(in hostID1 int)
begin
select sum(earningsamount) as 'Total Earnings By This Host' from `host earnings` 
where payment_paymentID in(select paymentID from payment where bookingID in(select bookingID from booking where houseID in(select houseID from house where hostID=hostID1)));
end 
//

call host_earnings_particular_host(1);

------------------------------------------------------------------------------------------------------------------------------------------

Scenario 14 :
Find the total earnings of AirBNB

Query :
delimiter //
create procedure total_airbnb_earnings()
select sum(EarningsAmount) as 'Total AirBNB Earnings' from `airbnb earnings`
end 
//

call total_airbnb_earnings();

------------------------------------------------------------------------------------------------------------------------------------------

Scenario 15 :
If a booking is cancelled, then the refund table should be populated and the records from airbnb and host tables should be deleted as well

Query :
delimiter //
create trigger refund_policy
after update
on booking
for each row 
begin
if new.bookingStatus= 'cancelled'
then
insert into refund (payment_paymentID) select (paymentID)from payment where payment.bookingID=new.bookingID ;
end if;
end
//


delimiter //
create trigger delete_airbnb_host_earnings
after insert
on refund
for each row
begin
delete from `airbnb earnings` where Payment_paymentID=new.Payment_paymentID;
delete from `host earnings` where Payment_paymentID=new.Payment_paymentID;
end;
//


select * from booking;

update booking set bookingStatus='cancelled' where bookingID=5;

select * from refund;

select * from `airbnb earnings`

select * from `host earnings`	

------------------------------------------------------------------------------------------------------------------------------------------

Scenario 16 :
If a house has been booked for a number of days by a customer, the same house cannot be booked for the same number of days by any other customers.

Query :

delimiter //
create trigger booking_validation
after insert
on booking
for each row
begin
if (new.HouseID in (select BookingID from booking))
then
if ((new.BookingstartDate < any (select BookingEndDate from Booking)) and (new.BookingStartDate > any(select BookingStartDAte from booking)))
then
set @bookingID=new.BookingID;
end if;
end if;
end
//

delimiter //
create procedure p1()
begin 
delete from booking where bookingID=@bookingID;
end;
//

select * from booking;

insert into booking values()

insert into booking(BookingID,bookingStartDate,BookingEndDate,bookingStatus,houseID,CustomerID,timestamp) values (7,'2017/12/24','2017/12/26','open',4,4,now());

call p1();

------------------------------------------------------------------------------------------------------------------------------------------

Scenario 17 :
A person can choose whatever facilities he is looking for in  a house and then the houses with only those facilities will be displayed to the user.
Query :


delimiter //
create procedure facility_selection(in facility1 varchar(20))
begin
select * from house
where houseID in (select houseID from house_facilities where facilityID = all(select facilityID from facilities where facilityName=facility1 ));
end //


call facility_selection('workspace');

------------------------------------------------------------------------------------------------------------------------------------------

Scenario 18 :
Find the house which has got the maximum reviews :

Query :
select * from review

select houseID,count(*) as 'count'from review 
group by HouseID
order by count desc;

------------------------------------------------------------------------------------------------------------------------------------------

Scenario 19 :
Find out the customers who have not written any reviews.

Query:
create view customer_not_written_review as
SELECT CUSTOMERID,FirstName,LastName FROM CUSTOMER AS C
inner join person as p
on c.customerID=p.personID
WHERE CUSTOMERID NOT IN (SELECT CUSTOMERID FROM REVIEW AS R)

Select * from customer_not_written_review;

------------------------------------------------------------------------------------------------------------------------------------------

Scenario 20 :
Find out the hosts who have received poor ratings from the customer.

Query :
create view host_bad_ratings_by_customer as
select rating.hostID, firstName, lastName,  customerComments from rating 
inner join person
on rating.hostID=person.personID
where customerRating<3;

select * from host_bad_ratings_by_customer;

------------------------------------------------------------------------------------------------------------------------------------------

Scenario 21 :
Find out the customers who have received good ratings from host.

Query :
create view customer_good_ratings_by_host as
select rating.customerID, firstName, lastName, hostComments from rating 
inner join person
on rating.customerID=person.personID
where customerRating>2;

