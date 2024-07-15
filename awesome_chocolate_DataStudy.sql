/* TO KNOW THE TABLES PRESENT IN THE DATABASE */
show tables;
/* TO KNOW THE ENTITIES OF THE TABLE sales */
desc sales;
select * from sales;
/* I WANT TO SEE SOME COLUMNS IN THE sales TABLE */
select SaleDate, Amount, Boxes from sales;
/* CALCULATE THE AMOUNT PER BOX */
select SaleDate, Amount, Boxes, Amount / Boxes from sales;
/* ADD A NAME OF THE COLUMN */
select SaleDate, Amount, Boxes, Amount / Boxes 'Amount per Box' from sales;
/* SHOW THE AMOUNT GREATER THAN 10000 */
select * from sales where Amount > 10000;
/* SHOW THE AMOUNT (GREATER THAN 10000) IN ASCENDING ORDER */
select * from sales where Amount > 10000 order by Amount;
/* SHOW THE AMOUNT (GREATER THAN 10000) IN DECENDING ORDER  */
select * from sales where Amount > 10000 order by Amount desc;
/* SHOW THE AMOUNT IN DECENDING ORDER PRESENT IN (PID) AND SORT (ORDER BY) THE PID WHERE GEOID=G1 */
select * from sales where GeoID= 'G1' order by PID, Amount desc;
/* SHOW ALL THE SALES WHERE AMOUNT>10000 AND YEAR=2022 - YY-MM-DD (USE CONDITIONAL)*/
select * from sales where Amount > 10000 and SaleDate >= '2022-01-01';
select SaleDate, Amount from sales where Amount > 10000 and year(SaleDate) = 2022 order by Amount desc;
/* SHOW THE BOXES BETWEEN 0 AND 50 WHICH WAS SALE */
select * from sales where Boxes > 0 and Boxes <= 50;
select * from sales where Boxes between 0 and 50;
/* SHOW THE DATE, AMOUNT AND BOXES IN THE SALE TABLE WHERE THE BOXES ARE SOLD ON FRIDAY (here monday=0, tuesday=1... friday=4 in weekdays) */
select SaleDate, Amount, Boxes, weekday(SaleDate) as 'Day of Week' from sales where weekday(SaleDate) = 4;

/* use People table */
select * from people;
/* SHOW ALL THE TEAM IN DELISH AND JUCIES */
select * from people where Team = 'Delish' or Team = 'Jucies';
select * from people where Team in ('Delish','Jucies');   /*to add multiple conditions*/
/* SHOW THE SALEPERSON WHOSE FIRST AND/OR LAST NAMES STARTS WITH 'B' */
select * from people where Salesperson like '%B%';  /* like %B% matches the pattern in the records */

select * from sales;
/* USE CATAGORY THE RECORDS WITH THE FOLLOWING CONDITIONS */
select SaleDate, Amount, 
	case when Amount < 1000 then 'under 1k'
		when Amount < 5000 then 'under 5k'
        when Amount < 10000 then 'under 10k'
	else
		'10k or more'
	end as'Amount Catagory'
from sales;
/* SHOW HOW MANY BOXES ARE SOLD BY EACH SALESPERSON */
select s.SaleDate, s.Amount, p.Salesperson from sales as s 
	join 
		people as p on p.SPID = s.SPID;
/* SHOW PRODUCTS AND TOTAL AMOUNTS SOLD BY THE SALESPERSON ONLY IN INDIA AND USA UPTO 10 ENTRIES*/
        select * from products;
        select * from people;
        select * from geo;
select s.SaleDate, s.Amount, s.SPID, pd.Product, p.Salesperson, g.Geo from sales as s
	join
		people as p on p.SPID=s.SPID
	join 
		geo as g on g.GeoID=s.GeoID 
	left join
		products as pd on pd.PID = s.PID where g.Geo in ('India','USA') limit 10;
/* SHOW THE TOTAL AMOUNTS AND TOTAL BOXES IN EACH GEO (use group by clause) */
select g.Geo, sum(Amount), sum(Boxes) from sales as s
	join
		geo as g on s.GeoID = g.GeoID group by g.Geo;
