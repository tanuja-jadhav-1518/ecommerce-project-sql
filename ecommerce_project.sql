CREATE DATABASE ecommerce_db;
USE ecommerce_db;

CREATE TABLE Customerss (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    phone VARCHAR(15)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock_quantity INT
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id)
    REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id)
    REFERENCES Orders(order_id),
    FOREIGN KEY (product_id)
    REFERENCES Products(product_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(50),
    payment_status VARCHAR(20),
    FOREIGN KEY (order_id)
    REFERENCES Orders(order_id)
);

SHOW TABLES;

INSERT INTO Customerss VALUES
(1, 'Rahul Sharma', 'rahul@gmail.com', 'Mumbai', '9876543210'),
(2, 'Priya Patel', 'priya@gmail.com', 'Pune', '9876501234'),
(3, 'Amit Joshi', 'amit@gmail.com', 'Delhi', '9876512345'),
(4, 'Sneha Kapoor', 'sneha@gmail.com', 'Bangalore', '9876523456');

INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 55000, 10),
(102, 'Mobile', 'Electronics', 20000, 20),
(103, 'Headphones', 'Accessories', 1500, 50),
(104, 'Keyboard', 'Accessories', 1200, 30);

INSERT INTO Orders VALUES
(1001, 1, '2026-05-10', 56500),
(1002, 2, '2026-05-11', 20000),
(1003, 3, '2026-05-12', 1500),
(1004, 4, '2026-05-13', 1200);

INSERT INTO Order_details VALUES
(1, 1001, 101, 1, 55000),
(2, 1001, 103, 1, 1500),
(3, 1002, 102, 1, 20000),
(4, 1003, 103, 1, 1500),
(5, 1004, 104, 1, 1200);

INSERT INTO payments VALUES
(1, 1001, 'UPI', 'Completed'),
(2, 1002, 'Credit Card', 'Completed'),
(3, 1003, 'Cash on Delivery', 'Pending'),
(4, 1004, 'Debit Card', 'Completed');

SELECT * FROM Customerss;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM Order_details;
-- Total Sales
SELECT SUM(total_amount) AS Total_Sales
FROM Orders;

-- Top Selling Products
SELECT p.product_name,
SUM(od.quantity) AS Total_Sold
FROM order_details od
JOIN products p
ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY Total_Sold DESC;

-- Customer Order Report
SELECT c.customer_name,
COUNT(o.order_id) AS Total_Orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

-- Revenue By Category
SELECT p.category,
SUM(od.quantity * od.price) AS Revenue
FROM order_details od
JOIN products p
ON od.product_id = p.product_id
GROUP BY p.category;

-- Payment Status Report
SELECT payment_status,
COUNT(*) AS Total_Payments
FROM payments
GROUP BY payment_status;