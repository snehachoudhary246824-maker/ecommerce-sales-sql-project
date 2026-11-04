CREATE DATABASE ecommerce_project;
USE ecommerce_project;

CREATE TABLE customers(
     customer_id INT PRIMARY KEY,
     customer_name VARCHAR (100) NOT NULL, 
     email VARCHAR (100) UNIQUE,
     city VARCHAR (50)
);

CREATE TABLE products (
      product_id INT PRIMARY KEY, 
      product_name VARCHAR (100) NOT NULL,
      category VARCHAR (50),
      price DECIMAL (10,2) CHECK (price>0)
);


CREATE TABLE orders (
       order_id INT PRIMARY KEY ,
       customer_id INT  NOT NULL,
       order_date DATE NOT NULL, 
       order_status VARCHAR (30) DEFAULT 'prnding',
       FOREIGN KEY (customer_id)
           REFERENCES customers (customer_id)
);


CREATE TABLE order_item (
       order_id INT ,
       product_id INT ,
       quantity INT CHECK (quantity > 0),
       unit_price DECIMAL (10,2) CHECK (unit_price >0),
	   
       PRIMARY KEY (order_id, product_id ),
       
       FOREIGN KEY (order_id )
          REFERENCES orders (order_id),
	   
       FOREIGN KEY ( product_id )
          REFERENCES products (product_id)
);


CREATE TABLE payments (
     payment_id INT PRIMARY KEY,
     order_id INT UNIQUE,
     amount DECIMAL (10,2) CHECK (amount >=0),
     payment_method VARCHAR (30),
     payment_status VARCHAR (30) DEFAULT 'pending',
     
     FOREIGN KEY (order_id)
         REFERENCES orders (order_id)
);
 
 
INSERT INTO customers 
VALUES
(1, 'rahul', 'rahul@gmail.com', 'delhi'),
(2, 'priya', 'priya@gmail.com', 'mumbai'),
(3, 'aman', 'aman@gmail.com', 'delhi'),
(4, 'sneha', 'sneha@gamil.com', 'jaipur');


INSERT INTO products
VALUES
(101, 'laptop', 'electronics', 50000),
(102, 'mouse', 'electronics', 500),
(103, 'chair', 'furniture', 3000),
(104, 'notebook', 'staionary', 100),
(105, 'keyboard', 'electronics', 1200);

INSERT INTO orders
VALUES
(201, 1, '2026-10-01', 'deliverd'),
(202, 2, '2026-10-02', 'deliverd'),
(203, 1, '2026-10-05', 'pending'),
(204, 3, '2026-10-06', 'deliverd'),
(205, 4, '2026-10-08', 'cancelled');


INSERT INTO order_item
VALUES
(201, 101, 1, 50000),
(201, 102, 2, 500),
(202, 103, 1, 3000),
(203, 105, 1, 1200),
(204, 104, 5, 100),
(204, 102, 1, 500),
(205, 101, 1, 50000);

INSERT INTO payments
VALUES
(301, 201, 51000, 'UPI', 'paid'),
(302, 202, 3000, 'card', 'paid'),
(303, 203, 1200, 'UPI', 'pending'),
(304, 204, 1000, 'cash', 'paid'),
(305, 205, 5000, 'card', 'failed');

 -- Q1 how many total customer in company ?
 SELECT count(*) as total_customers FROM customers;
 
 -- 02 how much total products?
 SELECT count(*) as total_products FROM products;
 
 -- Q3 how much total order value? 
 SELECT (quantity * unit_price) as order_item_value FROM order_item;
 
 -- Q4 which product sell in high quantity?
 SELECT 
   p. product_name,
   SUM(oi.quantity) as total_quantity
FROM products p
JOIN order_item oi
    ON p. product_id = oi. product_id
GROUP BY p. product_name 
ORDER BY total_quantity desc;

-- Q5 how many order placed by every customer?

SELECT 
    c. customer_name,
    count(o.order_id) as total_orders
FROM customers c
LEFT JOIN orders o 
    ON c. customer_id = o. customer_id
GROUP BY c. customer_name;

-- Q6 the total value of who's orders which deliverd?
SELECT 
   SUM(oi. quantity* oi. unit_price) as deliverd_value
FROM orders o 
JOIN order_item oi 
   ON o. order_id = oi. order_id
WHERE o. order_status = 'deliverd';

-- Q7 who's customer from delhi?
SELECT *
FROM customers
WHERE city = 'delhi';

-- Q8 which orders payment was pending?
SELECT
   o. order_id,
   p. amount,
   p. payment_status
FROM orders o
JOIN payments p 
    ON o. order_id = p. order_id 
WHERE p. payment_status= 'pending';

-- Q9 which of the highest price product ?
SELECT * 
FROM products
ORDER BY price desc
LIMIT 1;

-- Q10 count the product category wise?
SELECT
   category,
   COUNT(*) as total_products
FROM products
GROUP BY category;




    
     
 
 





     
     
     
     
     
     
     