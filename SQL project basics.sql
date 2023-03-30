--to create database 
CREATE DATABASE "choicename";

--to create car data table
CREATE TABLE "car_data"(
"car_code" numeric,
"car_name" text,
"car_price" numeric
);

--to create sales team table
CREATE TABLE "sales_team"(
"sales_manager_id" numeric,
"first_name" text,
"last_name" text,
"monthly_target" numeric
);

--to create salesdata table
CREATE TABLE "sales_data"(
"sales_manager_id" numeric,
"customer_name" text,
"customer_car_code" numeric,
"deposit_paid_for_booking" numeric,
"sold_on" date
);
--to call all data from sales data table
select *
from "sales_data";

--to concatenate first name and last name
SELECT CONCAT("first_name", ' ', "last_name") as fullname
from "sales_team"

--to join all the tables
select *
from "sales_data" as sd
join "sales_team" as st
on sd.sales_manager_id = st.sales_manager_id
join "car_data" as cd
on sd.customer_car_code = cd.car_code
