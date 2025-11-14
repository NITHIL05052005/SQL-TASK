CREATE DATABASE ecommerce;
USE ecommerce;
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(150),
    address VARCHAR(200)
);
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    description TEXT
);
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);
INSERT INTO customers (name, email, address) VALUES
('Alice', 'alice@example.com', 'Chennai'),
('Bob', 'bob@example.com', 'Coimbatore'),
('Charlie', 'charlie@example.com', 'Salem');
INSERT INTO products (name, price, description) VALUES
('Product A', 20.00, 'Basic product'),
('Product B', 35.50, 'Advanced product'),
('Product C', 50.00, 'Premium product');
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, CURDATE() - INTERVAL 10 DAY, 120.00),
(2, CURDATE() - INTERVAL 35 DAY, 200.00),
(1, CURDATE() - INTERVAL 5 DAY, 180.00);
SHOW TABLES;
SELECT DISTINCT c.*
FROM customers c
JOIN orders o ON c.id = o.customer_id
WHERE o.order_date >= CURDATE() - INTERVAL 30 DAY;
SELECT c.name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id;
UPDATE products
SET price = 45.00
WHERE name = 'Product C';
ALTER TABLE products
ADD discount DECIMAL(5,2) DEFAULT 0;
SELECT *
FROM products
ORDER BY price DESC
LIMIT 3;
SELECT DISTINCT c.name
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
WHERE p.name = 'Product A';
SELECT c.name, o.order_date, o.total_amount
FROM customers c
JOIN orders o ON c.id = o.customer_id;
SELECT *
FROM orders
WHERE total_amount > 150;
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT DEFAULT 1,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 1),
(3, 1, 1);
SELECT AVG(total_amount) AS average_order_value
FROM orders;
