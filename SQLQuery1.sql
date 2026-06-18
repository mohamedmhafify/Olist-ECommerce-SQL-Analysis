-- 1- اول حاجة هنعملها هي اننا ننشئ داتا بيز
Create Database Olist;

-- 2- Create & Insert Tables "علشان نحط التابلز بالداتا في الداتا بيز"

-- 2.1- Insert Customers Table
-- 2.2- Insert Geolocation Table
-- 2.3- Insert Sellers Table
-- 2.4- Insert Products Table
-- 2.5- Insert Product Category Translation Table
-- 2.6- Insert Orders Table
-- 2.7- Insert Order Items Table
-- 2.8- Insert Order Payments Table
-- 2.9- Insert Order Reviews Table

-- 3- Create Diagram and Relations

-- 4- الأسئلة

-- 4.1- حساب المبيعات السنوية بالاضافة الى عدد الطلبات والربع سنوية بالاضافة الى عدد الطلبات في كل ربع

SELECT
YEAR(o.order_purchase_timestamp) AS sales_year,

COUNT(DISTINCT CASE
WHEN DATEPART(QUARTER, o.order_purchase_timestamp) = 1
THEN o.order_id
END) AS Q1_Orders,
SUM(CASE
WHEN DATEPART(QUARTER, o.order_purchase_timestamp) = 1
THEN oi.price
ELSE 0
END) AS Q1_Sales,

COUNT(DISTINCT CASE
WHEN DATEPART(QUARTER, o.order_purchase_timestamp) = 2
THEN o.order_id
END) AS Q2_Orders,
SUM(CASE
WHEN DATEPART(QUARTER, o.order_purchase_timestamp) = 2
THEN oi.price
ELSE 0
END) AS Q2_Sales,

COUNT(DISTINCT CASE
WHEN DATEPART(QUARTER, o.order_purchase_timestamp) = 3
THEN o.order_id
END) AS Q3_Orders,
SUM(CASE
WHEN DATEPART(QUARTER, o.order_purchase_timestamp) = 3
THEN oi.price
ELSE 0
END) AS Q3_Sales,

COUNT(DISTINCT CASE
WHEN DATEPART(QUARTER, o.order_purchase_timestamp) = 4
THEN o.order_id
END) AS Q4_Orders,
SUM(CASE
WHEN DATEPART(QUARTER, o.order_purchase_timestamp) = 4
THEN oi.price
ELSE 0
END) AS Q4_Sales,

COUNT(DISTINCT o.order_id) AS Total_Orders,
SUM(oi.price) AS Total_Year_Sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY YEAR(o.order_purchase_timestamp)
ORDER BY sales_year;

-- 4.2- أكتر و اقل المنتجات مبيعا
Select
p.product_id, pt.product_category_name_english as category,
count(oi.order_id) as total_orders,
sum(oi.price) as total_revenue
From order_items oi
Join products p on oi.product_id = p.product_id
Left Join product_category_name_translation pt on p.product_category_name = pt.product_category_name
Group by p.product_id , pt.product_category_name_english
Order by total_orders Desc;

-- 4.3- اكتر و اقل المنتجات تقييما
Select
p.product_id,pt.product_category_name_english as category,
count(r.review_id) as total_reviews,
AVG(cast(r.review_score as float)) as avg_rating
From order_items oi
Join products p on oi.product_id = p.product_id
Join order_reviews r on oi.order_id = r.order_id
Left Join product_category_name_translation pt on p.product_category_name = pt.product_category_name
Group by p.product_id, pt.product_category_name_english
Having count(r.review_id) >= 5
Order by total_reviews desc,avg_rating desc;

-- 4.4- اكتر و اقل المناطق طلبا
Select c.customer_state,
count(distinct o.order_id) as total_orders,
sum(oi.price) as total_sales
From orders o
Join customers c on o.customer_id = c.customer_id
Join order_items oi on o.order_id = oi.order_id
Where o.order_status = 'delivered'
Group by c.customer_state
Order by total_orders desc;

-- 4.5- افضل او اكتر وسيلة دفع عند العملاء
Select
payment_type,
count(*) as total_tranactions,
sum(payment_value) as total_amount,
avg(payment_value) as avg_payment_value
From order_payments
Group by payment_type
order by total_tranactions desc;

-- 4.6- حساب اجمالي الناس الي دفعت تقسيط و كاش
Select
payment_type,
count(distinct o.customer_id) as unique_customers,
count(case
When op.payment_installments > 1
Then 1
End ) as intallment_transctions,
count(case
When op.payment_installments = 1
Then 1
End ) as full_payment_transactions
From order_payments op
Join orders o on op.order_id = o.order_id
Group by payment_type
Order by unique_customers desc ;

-- 4.7- اكتر و اقل التجار مبيعا
Select
s.seller_id, s.seller_state,
count(distinct oi.order_id) as total_orders,
sum(oi.price) as total_sales
From order_items oi
Join sellers s on oi.seller_id = s.seller_id
Group by s.seller_id, s.seller_state
Order by total_sales desc;

-- 4.8- حساب اكتر و اقل التجار تقييما من العملاء
select
s.seller_id,s.seller_state,
count(DISTINCT r.review_id) as total_reviews,
avg(cast(r.review_score as float)) as avg_rating
From order_items oi
Join sellers s on oi.seller_id = s.seller_id
Join order_reviews r on oi.order_id = r.order_id
Group by s.seller_id , s.seller_state
Having count(r.review_id) >= 5
Order by total_reviews desc , avg_rating desc;

-- 4.9- حساب اكتر العملاء طلبا
Select
c.customer_unique_id,
count(distinct o.order_id) as total_orders,
sum(oi.price) as total_spent
From orders o
Join customers c on o.customer_id = c.customer_id
Join order_items oi on o.order_id = oi.order_id
Where o.order_status = 'delivered'
Group by c.customer_unique_id
Order by total_orders desc;

-- 4.10- حساب متوسط سعر الطلب للعميل الواحد بشكل جماعي
Select
count(distinct c.customer_unique_id) as total_customers,
count(distinct o.order_id) as total_orders,
sum(oi.price) as total_spent,
sum(oi.price) / count(distinct o.order_id) as avg_order_value
From orders o
Join customers c on o.customer_id = c.customer_id
Join order_items oi on o.order_id = oi.order_id
Where o.order_status = 'delivered';

-- 4.11- حساب متوسط سعر الطلب للعميل الواحد بشكل فردي
Select
c.customer_unique_id,
count(distinct o.order_id) as total_orders,
sum(oi.price) as total_spent,
sum(oi.price) / count(distinct o.order_id) as avg_order_value
From orders o
Join customers c on o.customer_id = c.customer_id
Join order_items oi on o.order_id = oi.order_id
Where o.order_status = 'delivered'
Group by c.customer_unique_id
Order by avg_order_value desc;

-- 4.12- حساب نسبة طلبات العملاء الي تحتوي على منتج واحد او اتنين او تلاتة او اكتر
With order_item_counts AS (
Select order_id,
Count(*) as num_items
From order_items
Group by order_id )
Select case
When num_items = 1 Then '1 Item'
When num_items = 2 Then '2 Items'
When num_items = 3 Then '3 Items'
Else '4+ Items'
End as items_category,
Count(*) as total_orders,
Cast(count(*) as Float) *100 / Sum(count(*)) Over() as Perecentage
From order_item_counts
Group by
Case 
When num_items = 1 Then '1 Item'
When num_items = 2 Then '2 Items'
When num_items = 3 Then '3 Items'
Else '4+ Items'
End
order by total_orders desc;

-- 4.13- اكتر منتج بيتباع في كل منطقة
with product_sales_by_state as ( select
c.customer_state,p.product_id,pt.product_category_name_english as category,
count(*) as total_sold,Rank() Over(PARTITION by c.customer_state
order by count(*) desc ) as rnk
From orders o
Join customers c on o.customer_id = c.customer_id
Join order_items oi on o.order_id = oi.order_id
Join products p on oi.product_id = p.product_id
Left Join product_category_name_translation pt on p.product_category_name = pt.product_category_name
Where o.order_status = 'delivered'
Group by c.customer_state , p.product_id, pt.product_category_name_english )
Select customer_state, product_id , category , total_sold
From product_sales_by_state 
Where rnk = 1
Order by total_sold desc , customer_state;

-- 4.14- حساب و اسماء المنتجات الي بتتطلب مع بعض
Select
p1.product_id as product_1,
pt1.product_category_name_english as category_1,
p2.product_id as product_2,
pt2.product_category_name_english as category_2,
count(*) as times_bought_together
From order_items oi1
Join order_items oi2 on oi1.order_id = oi2.order_id And oi1.product_id < oi2.product_id
Join products p1 on oi1.product_id = p1.product_id
Join products p2 on oi2.product_id = p2.product_id
Left Join product_category_name_translation pt1 on p1.product_category_name = pt1.product_category_name
Left Join product_category_name_translation pt2 on p2.product_category_name = pt2.product_category_name
Group by p1.product_id, pt1.product_category_name_english,p2.product_id,pt2.product_category_name_english
Having count(*) >= 3
Order by times_bought_together desc;

-- 4.15- حساب مدة كل طلب من الشراء لحد التسليم
Select
o.order_id,o.order_purchase_timestamp,o.order_delivered_customer_date,
DATEDIFF(Day, o.order_purchase_timestamp, o.order_delivered_customer_date) as delivery_days,
DATEDIFF(Hour, o.order_purchase_timestamp, o.order_delivered_customer_date) as delivery_hours
From orders o
Where o.order_status = 'delivered' and o.order_delivered_customer_date is not null
order by delivery_days asc;

--4.16- متوسط وقت التوصيل لكل تاجر على كل منتجاته
Select
s.seller_id,s.seller_state,
count(distinct o.order_id) as total_orders,
avg(cast(DATEDIFF(Day, o.order_purchase_timestamp, o.order_delivered_customer_date) as Float)) as avg_delivery_days
From orders o
Join order_items oi on o.order_id = oi.order_id
Join sellers s on oi.seller_id = s.seller_id
Where o.order_status = 'delivered' and o.order_delivered_customer_date is not null
Group by s.seller_id , s.seller_state
Order by total_orders desc , avg_delivery_days asc;
