--question one A
Select sum ("PROFIT") as "anglo_franco"
from 
(select *,
case when "COUNTRIES" in ('Nigeria', 'Ghana') then 'Anglophone'
else 'Francophone' end as "Territory"
from "SalesTable") as "Table_One";

-- another question one formula
select sum ("PROFIT")
FROM "SalesTable"

-- another question one formula with individual years
select sum ("PROFIT") as "Total_Profit", "YEARS"
FROM "SalesTable"
where "YEARS" in (2017, 2018, 2019)
group by "YEARS"
order by "Total_Profit"

--question two A

select "TERRITORY", sum("PROFIT") as "PROFIT_SUM"
from
--subquery 1st ends at SalesTable from next line
(select *,
case when "COUNTRIES" in ('Nigeria', 'Ghana') then 'Anglophone'
 else  'Francophone' end as "TERRITORY"
from "SalesTable") as "Table_One"
 group by "TERRITORY"
 order by "PROFIT_SUM" desc;
 
 --question three A
 select "COUNTRIES", sum("PROFIT") as "COUNTRY_PROFIT"
 from "SalesTable"
 where "YEARS" in (2019)
 group by "COUNTRIES"
 order by "COUNTRY_PROFIT" desc;
 
 --question 4 A
 select "YEARS", sum("PROFIT") as "YEAR_PROFIT"
 from "SalesTable"
 group by "YEARS"
 order by "YEAR_PROFIT" desc;
 
 --question 5 A
 select "MONTHS", "YEARS", sum("PROFIT") as "PROFIT_SUM"
 from "SalesTable"
 group by "MONTHS", "YEARS"
 order by "PROFIT_SUM" asc;
 
 --question six A
 sElect min("PROFIT")
 FROM "SalesTable"
 where "MONTHS" = 'December' and "YEARS" = 2018;

 --another question six formula A
 sElect ("PROFIT")
 FROM "SalesTable"
 where "MONTHS" = 'December' and "YEARS" = 2018
 order by "PROFIT";
 
 --Question seven A
 
 select "MONTHS", round((sum("PROFIT")/sum("COST"))*100,3) as "Percentage_Profit%"
from "SalesTable"
where "YEARS" in (2019)
group by "MONTHS"
order by "Percentage_Profit%" desc;

--Question eight A

select "BRANDS", sum("PROFIT") as "Total_Profit"
from "SalesTable"
where "COUNTRIES" = 'Senegal'
group by "BRANDS"
Order by "Total_Profit" desc

--BRAND SECTION
--QUESTION ONE B
select "BRANDS", sum("QUANTITY") as "Total_Quantity"
from
(select *,
case when "COUNTRIES" in ('Nigeria', 'Ghana') then 'Anglophone'
else 'Francophone' end as "TERRITORY"
from "SalesTable") as "Table-One"
 where "YEARS" in (2019, 2018) and "TERRITORY" = 'Francophone'
 group by "BRANDS"
 order by "Total_Quantity" desc
 limit 3
 ;
 
--QUESTION TWO B

select "BRANDS", sum("QUANTITY") as "Total_Quantity"
from "SalesTable"
where "COUNTRIES" = 'Ghana'
group by "BRANDS"
order by "Total_Quantity" desc
limit 2
;

--QUESTION 3 B
SELECT "BRANDS", sum("QUANTITY") as "Total_Qty"
from "SalesTable"
where "COUNTRIES" = 'Nigeria' and "BRANDS" not like '%malt' 
group by "BRANDS"
order by "Total_Qty" desc
;

--Question 4
--formula 1

select "BRANDS", sum("QUANTITY") as "QTY"
from "SalesTable"
where "COUNTRIES" in ('Nigeria', 'Ghana') and "YEARS" in (2018,2019) and "BRANDS" like '%malt'
group by "BRANDS"
order by "QTY" desc;

--formula 2
select "BRANDS", sum("QUANTITY") as "Total_Qty"
from
(select*,
case when "COUNTRIES" in ('Nigeria', 'Ghana') then 'Anglophone'
else 'Francophone' end as "TERRITORY"
from "SalesTable") as "Table_One"
where "BRANDS" like '%malt' and "TERRITORY" = 'Anglophone' and "YEARS" in (2018, 2019)
group by "BRANDS"
order by "Total_Qty" desc
;

--QUESTION 5 B
select "BRANDS", sum("QUANTITY") as "Total_Qty"
from "SalesTable"
where "COUNTRIES" = 'Nigeria' and "YEARS" = 2019
group by "BRANDS"
order by "Total_Qty" desc
;

--QUESTION 6 B
select "BRANDS", sum("QUANTITY") as "Total_Qty"
from "SalesTable"
where "COUNTRIES" = 'Nigeria' and "REGION" = 'southsouth'
group by "BRANDS"
order by "Total_Qty" desc
;

--QUESTION SEVEN B
select sum("QUANTITY") as "Total_Qty"
from "SalesTable"
where "COUNTRIES" ='Nigeria' and "BRANDS" not like '%malt'
;

--QUESTION EIGHT B
select "REGION", sum("QUANTITY") as "Total_Qty"
from "SalesTable"
where "COUNTRIES" = 'Nigeria' and "BRANDS" = 'budweiser'
group by "REGION"
order by "Total_Qty" desc
;

--QUESTION NINE B
select "REGION", sum("QUANTITY") as "Total_Qty"
from "SalesTable"
where "COUNTRIES" = 'Nigeria' and "BRANDS" = 'budweiser' and "YEARS" = 2019
group by "REGION"
order by "Total_Qty"
;

--COUNTRY ANALYSIS
--QUESTION ONE C

select "COUNTRIES", sum("QUANTITY") as "Total_Qty"
from "SalesTable"
where "BRANDS" not like '%malt'
group by "COUNTRIES"
order by "Total_Qty" desc
;


--QUESTION TWO C

select "SALES_REP", sum("QUANTITY") as "Total_Qty"
from "SalesTable"
where "BRANDS" = 'budweiser' and "COUNTRIES" = 'Senegal'
group by "SALES_REP"
order by "Total_Qty" desc
;

--question THREE C
--FORMULA 1

select "COUNTRIES", sum("PROFIT") as "Total_Profit"
from "SalesTable"
where "MONTHS" in ('October', 'November', 'December') and "YEARS" =2019
group by "COUNTRIES"
order by "Total_Profit" desc
;

--FORMULA 2

select "COUNTRIES", sum("PROFIT") as "Total_Profit"
from
(select*,
case when "MONTHS" in ('October', 'November', 'December') then 'Q4'
else 'others' end as "QUARTERS"
from "SalesTable") as "Table_one"
where "QUARTERS" = 'Q4' and "YEARS" = 2019
group by "COUNTRIES"
order by "Total_Profit" desc
;
