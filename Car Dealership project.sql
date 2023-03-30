--Question 1
--The sales manager’s full name, his total sales (based on car price), and the percentage of his target left (based on car price)
with t1 as
(select *, date_part('month', sold_on) as monthno
 from sales_data),
t2 as
(select *,concat("first_name",' ',"last_name") as "fullname",
	case when "monthno" = 4 then 'April'
		 when "monthno" = 5 then 'May'
		 when "monthno" = 6 then 'June'
		 when "monthno" = 7 then 'July'
		 when "monthno" = 8 then 'August'
	else 'September' end as "months"
from t1
join "car_data" cd
on cd.car_code = t1.customer_car_code
join "sales_team" st
on st.sales_manager_id = t1.sales_manager_id)
select fullname, sum(monthly_target) as target_per_month, sum(car_price) over(partition by months,fullname)as car_sum,months,
round(((monthly_target - sum(car_price))/monthly_target)*100,2) as "percentage_left(%)"
from t2
group by fullname,months,car_price,monthly_target
order by fullname;

--QUESTION 2
--Sales manager with id as 12134 which cars constituted how much percentage of his target?

with t1 as
(select *, date_part('month', sold_on) as monthno
 from sales_data),
t2 as
(select *,concat("first_name",' ',"last_name") as "fullname",
	case when "monthno" = 4 then 'April'
		 when "monthno" = 5 then 'May'
		 when "monthno" = 6 then 'June'
		 when "monthno" = 7 then 'July'
		 when "monthno" = 8 then 'August'
	else 'September' end as "months"
from t1
join "car_data" cd
on cd.car_code = t1.customer_car_code
join "sales_team" st
on st.sales_manager_id = t1.sales_manager_id)
select car_name, sum(monthly_target) as target_per_month, sum(car_price) over(partition by months)as car_sum,months,
round(((sum(car_price))/monthly_target)*100) as "target_percentage(%)"
from t2
where fullname = 'Ajay Alex'
group by car_name,months,car_price,monthly_target;

--QUESTION 3
--Who has the least and the most deposit collected as a percentage of the total price of cars sold by each sales manager?
--We want the Manager's name, the deposit collected as a percentage of the total price,
--third column that has Max or Min tags to identify which row in the output represents the minimum and which represents the maximum

select "first_name" || ' ' || "last_name" as "fullname",
Round(sum(sd.deposit_paid_for_booking)/sum(c.car_price)*100, 2) as percentage_deposit,
case 
	when rank() over(order by Round(sum(sd.deposit_paid_for_booking)/sum(c.car_price)*100, 2)) = 1 then 'minimum'
	when rank() over(order by Round(sum(sd.deposit_paid_for_booking)/sum(c.car_price)*100, 2)desc) = 1 then 'maximum'
	else null
end as "min_max"
from "sales_data" sd
join "sales_team" sm
on sm.sales_manager_id = sd.sales_manager_id
join "car_data" c
on c.car_code = sd.customer_car_code
group by "fullname"
order by percentage_deposit desc;


--QUESTION 4
--Which car contributed to the minimum sales for each sales manager and what is the amount? (We want the Sales Manager's Name, the Name of the Car which contributed to the least sales by car price for that manager, Total Amount (Total of Car Price) for that car sold for that manager)

-- question 4
with t1 as
(select *, date_part('month', sold_on) as monthno
 from sales_data),
t2 as
(select *,concat("first_name",' ',"last_name") as "fullname",
	case when "monthno" = 4 then 'April'
		 when "monthno" = 5 then 'May'
		 when "monthno" = 6 then 'June'
		 when "monthno" = 7 then 'July'
		 when "monthno" = 8 then 'August'
	else 'September' end as "months"
from t1
join "car_data" cd
on cd.car_code = t1.customer_car_code
join "sales_team" st
on st.sales_manager_id = t1.sales_manager_id),
t3 as
(select fullname,car_name,sum(car_price) as "total_car_sum"
,row_number() over (partition by fullname order by sum(car_price))  as rn
from t2
group by fullname,car_name
order by fullname,"total_car_sum")
select fullname,car_name,total_car_sum
from t3
where rn < 2;

-- Question 5
--What is the average number of days between cars sold? 
select round(avg(sd2.sold_on - sd1.sold_on),2) as avg_date_diff
from "sales_data" sd1
join "sales_data" sd2 on sd1.customer_car_code = sd2.customer_car_code
and sd1.sold_on < sd2.sold_on;

--JOIN ALL TABLES and add fullname column
select *, concat("first_name", ' ', "last_name") as "fullname" from car_data as cd
left join "sales_data" as sd
on cd.car_code = sd.customer_car_code
left join "sales_team" as st
on sd. sales_manager_id = st.sales_manager_id