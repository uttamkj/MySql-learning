USE youtube;
SHOW tables;
select * from orders_hotel;
-- Q2 — Average delivery time per restaurant
SELECT restaurant_name,
	   round(avg(timestampdiff(minute,order_time,delivery_time)),2) as avg_time 
FROM orders_hotel
GROUP BY restaurant_name;
-- Q3 — Running wallet balance per customer
CREATE TABLE wallet_transactions (
    txn_id INT PRIMARY KEY,
    customer_id INT,
    txn_date DATE,
    txn_type VARCHAR(10),   -- CREDIT or DEBIT
    amount DECIMAL(10,2)
);

INSERT INTO wallet_transactions VALUES
(1,1,'2024-01-01','CREDIT',1000.00),
(2,1,'2024-01-03','DEBIT',200.00),
(3,1,'2024-01-05','CREDIT',500.00),
(4,1,'2024-01-07','DEBIT',300.00),
(5,2,'2024-01-01','CREDIT',2000.00),
(6,2,'2024-01-04','DEBIT',700.00);

SELECT * ,
    sum(
		CASE
			WHEN txn_type = 'CREDIT' THEN amount
            WHEN txn_type = 'DEBIT' THEN -amount
            ELSE 0
        END
    ) over(partition by customer_id order by txn_date) as running_total
FROM wallet_transactions;

-- Q4 — Distinct active users per month

CREATE TABLE watch_history (
    watch_id INT PRIMARY KEY,
    user_id INT,
    content_id INT,
    watch_date DATE
);
INSERT INTO watch_history VALUES
(1,1,101,'2024-01-05'),
(2,2,102,'2024-01-10'),
(3,1,103,'2024-01-20'),
(4,3,101,'2024-02-01'),
(5,1,104,'2024-02-15'),
(6,4,105,'2024-02-20'),
(7,2,101,'2024-03-01'),
(8,3,103,'2024-03-05');

SELECT
    DATE_FORMAT(watch_date, '%Y-%m') AS month,
    COUNT(DISTINCT user_id) AS active_users
FROM watch_history
GROUP BY DATE_FORMAT(watch_date, '%Y-%m')
ORDER BY month;


-- Q5 — Trip cancellation rate per city
SELECT * from trips;
CREATE TABLE trips (
    trip_id INT PRIMARY KEY,
    city VARCHAR(30),
    rider_id INT,
    driver_id INT,
    trip_status VARCHAR(20)  -- COMPLETED, CANCELLED_BY_RIDER, CANCELLED_BY_DRIVER
);

INSERT INTO trips VALUES
(1,'Mumbai',1,10,'COMPLETED'),
(2,'Mumbai',2,11,'CANCELLED_BY_RIDER'),
(3,'Mumbai',3,10,'COMPLETED'),
(4,'Mumbai',4,12,'CANCELLED_BY_DRIVER'),
(5,'Delhi',5,13,'COMPLETED'),
(6,'Delhi',6,14,'COMPLETED'),
(7,'Delhi',7,13,'CANCELLED_BY_RIDER'),
(8,'Pune',8,15,'COMPLETED');

SELECT city, 
		count(*) as total_trips,
        sum(CASE WHEN trip_status LIKE 'CANCELLED%' THEN 1 ELSE 0 END ) as total_cancelled_trips,
        round((sum(CASE WHEN trip_status LIKE 'CANCELLED%' THEN 1 ELSE 0 END )*100 )/count(*) ,2) as percentage_cancelled
from trips
GROUP BY city;


























