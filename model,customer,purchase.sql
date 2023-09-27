create database bike
----------------------------
create table model( 
Model_id int primary key,
Model_name varchar(40),
cost int
)
insert into model values(1111,'R15',215000)
insert into model values(2222,'MT_15',205000)
insert into model values(3333,'Ninja',695900)
insert into model values(4444,'Hatabusa',955000)
insert into model values(5555,'Clasic_350',255000)
insert into model values(6666,'Activa',155000)
insert into model values(7777,'Ola',99000)
---------------------------------------------------------
create table Customer(
Customer_id int primary key,
First_Name varchar(20),
Last_Name varchar(20),
Mobile_no varchar(20),
Gender varchar(15),
Email varchar(60)
)
insert into customer values(100,'Sandesh','Kshirsagar','8600820892','Male','Sandeshk505@gmail.com') 
insert into customer values(101,'Rohit','Jadhav','7038848007','Male','Rohitj@gmail.com') 
insert into customer values(102,'Chidanad','Gurav','9856475852','Male','CHidanadg758@gmail.com') 
insert into customer values(103,'Sagar','Andure','7584962121','Male','Sagara852@gmail.com') 
insert into customer values(104,'Payal','Gujar','7859468575','Female','Payalg@gmail.com') 
insert into customer values(105,'Alisha','Mhasake',null,'Female','Alisha452@gmail.com') 
insert into customer values(106,'Shubham','Dalvi','958647585',null,'Shubhamd@gmail.com') 
insert into customer values(107,'Riya','Malpani','8574962135','Female',null) 

-----------------------------------------------------------
create table Payment_Mode(
Payment_id int primary key,
Payment_Type varchar(20),
)
insert into Payment_Mode values(11,'Online')
insert into Payment_Mode values(22,'Cash')
insert into Payment_Mode values(33,'Cheque')

---------------------------------------------
create table Feedback_Rating(
Rating_id int primary key,
ratring Varchar(20)
)
insert into Feedback_Rating values (5,'Excellent')
insert into Feedback_Rating values (4,'Good')
insert into Feedback_Rating values (3,'Average')
insert into Feedback_Rating values (2,'Bad')
insert into Feedback_Rating values (1,'Complaint')


create table Purchase(
Purchase_id int primary key,
Customer_id int,
Constraint fk_Customer_Customer_id foreign key (Customer_id) references Customer(Customer_id),
Model_id int,
constraint fk_Model_Modelid foreign key (Model_id) references model(model_id),
Booking_amt int,
Payment_id int,
constraint Fk_Payment_mode_Pay_id foreign key (Payment_id) references Payment_Mode(Payment_id),
Purchase_date date,
Rating_id int,
constraint Fk_Feedback_Rating_Rating_id foreign key (Rating_id) references Feedback_Rating(Rating_id),
)
insert into Purchase values (90,100,1111,45000,11,'2023/01/11',5)

insert into Purchase values (91,101,2222,12000,22,'2019/02/28',1)
insert into Purchase values (92,102,3333,85452,33,'2021/05/12',4)
insert into Purchase values (93,103,4444,15000,22,'2022/10/25',2)
insert into Purchase values (94,104,5555,55000,33,'2020/11/11',3)

insert into Purchase values (95,105,6666,99000,11,'2023/09/11',5)
insert into Purchase values (96,106,7777,45000,33,'2022/01/11',2)
insert into Purchase values (97,100,7777,45000,22,'2022/11/21',4)
insert into Purchase values (98,104,3333,null,33,'2023/03/07',3)
insert into Purchase values (99,101,3333,695900,11,'2023/07/07',3)
update Purchase set Rating_id=null where Purchase_id=99
--------------------------------------------------------------------
  select *from model
  select *from Customer
  select *from Payment_Mode
  select *from Feedback_Rating
  select *from Purchase

---------------------------------------------------------------------

--1)WAQ to get the balance amount for customers who made cash payment 
select (m.cost-p.Booking_amt)as'Cash payment Customers'
from model m
inner join Purchase p  on m.Model_id=p.Model_id
inner join Customer c  on c.Customer_id=p.Customer_id
inner join Payment_Mode pt  on pt.Payment_id=p.Payment_id
where pt.Payment_Type='cash'

--2)Delete all the records of customer who have paid complete amount as that of bike cost.(SubQuery)
delete from customer where Customer_id in (select p.Customer_id from Purchase p 
inner join model m on m.model_id=p.model_id
where (m.cost-p.Booking_amt)=0)

--3.Create an index to have faster retrival of data on the basis of booking_amount.
CREATE INDEX idx_booking_amount ON Purchase(booking_amt)


--4.WAQ to change payment mode to cash for ‘activa’ purchased by customer with id 11. 
 update Purchase set Payment_id=11 where purchase_id in
 (
 select p.Purchase_id from Purchase p
 inner join model m on m.Model_id=p.Model_id
 where Model_name= 'activa')

--8.WAQ to get all customer names who haven’t given ratings yet. 
select c.First_Name,c.Last_Name from Customer c
join Purchase p on p.Customer_id=c.Customer_id
where Rating_id is null

--9.Delete all complaint records from purchase. 
delete from Purchase where complaint_id=51

--10.Update ratings given by Mr Vaibhav from good to excellent.

--11.Reduce cost of all bikes for which rating is bad by 10%. 
update model set cost=(cost-(cost*0.1)) where model_id=12

--12.Write a to display highest selling model along with name and count 
  select top 1 m.Model_name,COUNT(*)as 'Count' from model m
  inner join purchase p on p.Model_id=m.Model_id
  group by m.Model_id,m.Model_name 
  order by count(p.customer_id)  desc







