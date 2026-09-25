-- create a database
CREATE DATABASE AmazonDB;
USE AmazonDB;
SELECT DATABASE();
-- Creating the Users table
CREATE TABLE Users (user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    registered_date DATE NOT NULL,
    membership ENUM('Basic', 'Prime') DEFAULT 'Basic'
);
DESC Users;
-- Creating the Products table
CREATE TABLE Products (product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    category VARCHAR(100) NOT NULL,
    stock INT NOT NULL
);
DESC Products;
-- Creating the Orders table
CREATE TABLE Orders (order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
-- Creating the OrderDetails table(depends on both Orders and Products)
CREATE TABLE OrderDetails (order_details_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
-- To Insert Users
INSERT INTO Users(name, email, registered_date, membership)
VALUES('Alice Johnson', 'alice.j@example.com', '2024-01-15', 'Prime'),
('Bob Smith', 'bob.s@example.com', '2024-02-01', 'Basic'),
('Charlie Brown', 'charlie.b@example.com', '2024-03-10', 'Prime'),
('Daisy Ridley', 'daisy.r@example.com', '2024-04-12', 'Basic');
SELECT * FROM Users;
-- To Insert Products
INSERT INTO Products(name, price, category, stock)
VALUES('Echo Dot', 49.99, 'Electronics', 120),
('Kindle Paperwhite', 129.99, 'Books', 50),
('Fire Stick', 39.99, 'Electronics', 80),
('Yoga Mat', 19.99, 'Fitness', 200),
('Wireless Mouse', 24.99, 'Electronics', 150);
SELECT * FROM Products;
-- To Insert Orders
INSERT INTO Orders(user_id, order_date, total_amount)
VALUES(1, '2024-05-01', 79.98),
(2, '2024-05-03', 129.99),
(1, '2024-05-04', 49.99),
(3, '2024-05-05', 24.99);
SELECT * FROM Orders;
-- To Insert OrderDetails
INSERT INTO OrderDetails(order_id, product_id, quantity)
VALUES(1, 1, 2),
(2, 2, 1),
(3, 1, 1),
(4, 5, 1);
SELECT * FROM OrderDetails;

-- 1.List all customers who have made purchases of more than $80.
SELECT Users.user_id, Users.name, Users.email, Orders.total_amount
FROM Users
INNER JOIN Orders
    ON Users.user_id = Orders.user_id
WHERE Orders.total_amount > 80;

-- 2.Retrieve all orders placed in the last 280 days along with the customer name and email.
SELECT Orders.order_id, Orders.order_date, Orders.total_amount, Users.name, Users.email
FROM Orders
INNER JOIN Users
    ON Orders.user_id = Users.user_id
WHERE Orders.order_date >= DATE_SUB('2024-05-05', INTERVAL 280 DAY);


-- 3.Find the average product price for each category.
SELECT Products.category, AVG(Products.price) AS average_price
FROM Products
GROUP BY Products.category;


-- 4. List all the Customers who purchased Electronics
SELECT DISTINCT Users.user_id, Users.name, Users.email
FROM Users
INNER JOIN Orders
    ON Users.user_id = Orders.user_id
INNER JOIN OrderDetails
    ON Orders.order_id = OrderDetails.order_id
INNER JOIN Products
    ON OrderDetails.product_id = Products.product_id
WHERE Products.category = 'Electronics';

-- 5.Find the Total products sold and total revenue for each product
SELECT Products.product_id, Products.name, 
	SUM(OrderDetails.quantity) AS total_products_sold,
    SUM(OrderDetails.quantity * Products.price) AS total_revenue
FROM Products
INNER JOIN OrderDetails
    ON Products.product_id = OrderDetails.product_id
GROUP BY Products.product_id, Products.name;


-- 6. Update the price of all book product Increase the price by 10%
SET SQL_SAFE_UPDATES = 0;
UPDATE Products
SET price = price * 1.10
WHERE category = 'Books';
SET SQL_SAFE_UPDATES = 1;


-- 7. Remove all orders before 2020
SET SQL_SAFE_UPDATES = 0;
DELETE FROM Orders
WHERE order_date < '2020-01-01';
SET SQL_SAFE_UPDATES = 1;
SELECT * FROM Orders;


-- 8. Order details for 2024-05-01 to fetch the order details, including customer name, product name, and quantity
SELECT Users.name AS customer_name, Products.name AS product_name, OrderDetails.quantity, Orders.order_date
FROM Users
INNER JOIN Orders
    ON Users.user_id = Orders.user_id
INNER JOIN OrderDetails
    ON Orders.order_id = OrderDetails.order_id
INNER JOIN Products
    ON OrderDetails.product_id = Products.product_id
WHERE Orders.order_date = '2024-05-01';


-- 9. Fetch all customers and the total number of orders they have placed.
SELECT Users.user_id, Users.name, COUNT(Orders.order_id) AS total_orders
FROM Users
LEFT JOIN Orders
    ON Users.user_id = Orders.user_id
GROUP BY Users.user_id, Users.name;

-- 10.Retrieve the average rating for all products in the Electronics category.
ALTER TABLE Products
ADD rating DECIMAL(2,1);
SELECT AVG(Products.rating) AS average_rating
FROM Products
WHERE Products.category = 'Electronics';


-- 11.List all customers who purchased more than 1 units of any product, including the product name and total quantity purchased.
SELECT Users.name AS customer_name, Products.name AS product_name, SUM(OrderDetails.quantity) AS total_quantity
FROM Users
INNER JOIN Orders
    ON Users.user_id = Orders.user_id
INNER JOIN OrderDetails
    ON Orders.order_id = OrderDetails.order_id
INNER JOIN Products
    ON OrderDetails.product_id = Products.product_id
GROUP BY Users.user_id, Users.name, Products.product_id, Products.name
HAVING SUM(OrderDetails.quantity) > 1;


-- 12. Find the total revenue generated by each category along with the category name.
SELECT Products.category, SUM(OrderDetails.quantity * Products.price) AS total_revenue
FROM Products
INNER JOIN OrderDetails
    ON Products.product_id = OrderDetails.product_id
GROUP BY Products.category;