create database pizzasales;
use pizzasales;

select * from pizza_sales

ALTER TABLE pizza_sales
ADD new_order_date DATE;
set sql_safe_updates =0;

UPDATE pizza_sales
SET  new_order_date = STR_TO_DATE(order_date, '%d-%m-%Y');

/* Find out the total revenue */

select sum(total_price) as Total_Revenue from pizza_sales;

/* Retrieve average order value */

select sum(total_price) /count(distinct order_id) as Avg_Order_Value from pizza_sales;

/* Find out total no: of pizzas sold */

select sum(quantity) as Total_Pizza_Sold from pizza_sales;

/* Find out Total order placed */

select count(distinct order_id)  as Total_Orders from pizza_sales;

 /* Average pizzas per order */
 
 select cast(cast(sum(quantity)  as decimal(10,2))/ cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) 
 as Avg_Pizza_per_order from pizza_sales;
 
 /* Retrieve Daily Trends for Total Orders*/
 
select
    DAYNAME(new_order_date) as order_day,
    COUNT(distinct ORDER_ID)as total_orders
from pizza_sales
group by DAYNAME(new_order_date) order by  order_day ;

/* Retrieve Monthly trends for Total Orders */

select
    DATE_FORMAT(new_order_date, '%M') as month_name,
    COUNT(distinct order_id) as total_orders
from pizza_sales
group by DATE_FORMAT(new_order_date, '%M') order by total_orders;

/*Retrieve percentage of sales of each category of pizza */

select pizza_category ,cast(sum(total_price)*100/
(select sum(total_price) from pizza_sales)as decimal(10,2)) as perc_total_sales from pizza_sales 
group by pizza_category;

/*Retrieve percentage of sales and total sales  with respect to their pizza size */

select pizza_size ,cast(sum(total_price) as decimal(10,2)) as total_sales ,cast(sum(total_price)*100/
(select sum(total_price) from pizza_sales) as decimal(10,2)) as perc_total_sales from pizza_sales
 group by pizza_size 
 order by perc_total_sales desc;
 
/* Retrieve top best sellers by revenue,total quantity and total orders */

select pizza_name,sum(total_price) as Total_Revenue from pizza_sales
group by pizza_name
order by Total_Revenue  desc limit 5;

select pizza_name,sum(quantity) as Total_Quantity from pizza_sales
group by pizza_name
order by Total_Quantity  desc limit 5;

select pizza_name,count(distinct order_id) as Total_Orders from pizza_sales
group by pizza_name
order by Total_Orders  desc limit 5;

/* Retrieve bottom sellers by revenue & total quantity,revenue  */

select pizza_name,sum(total_price) as Total_Revenue from pizza_sales
group by pizza_name
order by Total_Revenue  limit 5;

select pizza_name,sum(quantity) as Total_Quantity from pizza_sales
group by pizza_name
order by Total_Quantity   limit 5;

select pizza_name,sum(total_price) as Total_Price from pizza_sales
group by pizza_name
order by Total_Price   limit 5;

-- Perform some more queries 

/* Retrieve each day order count(daily trends) */

select 
   new_order_date as order_day, 
   count(distinct order_id) as total_orders 
from pizza_sales 
group by new_order_date;

/* Retrieve pizza_name whose category is classic and unit_price greater than 20 */

select pizza_name,pizza_category,unit_price from pizza_sales
 where pizza_category = 'Classic' and unit_price>20;

/* Retrieve total quantity of pizza sold in the initial and final day of 2015 */

select order_date ,sum(quantity) as Quantity from pizza_sales 
where order_date in('01-01-2015','31-12-2015') 
group by order_date;

/* retrieve the name,id category of pizzas whose unit price is greater than 20 */

select pizza_name,pizza_id,pizza_category,unit_price from pizza_sales
 where unit_price>20;


-- END --



