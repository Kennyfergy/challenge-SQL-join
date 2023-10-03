--1. Get all customers and their addresses.
Select * FROM "customers", "addresses";

--2. Get all orders and their line items (order id, order date, quantity, and product description).

SELECT 
    o.id AS order_id,
    o.order_date,
    li.quantity,
    p.description
FROM
    orders o
JOIN
    line_items li ON o.id = li.order_id
JOIN
    products p ON li.product_id = p.id;

--3. Which warehouses have cheetos?
SELECT
    w.warehouse
FROM
    products p
JOIN
    warehouse_product wp ON p.id = wp.product_id
JOIN
    warehouse w ON wp.warehouse_id = w.id
WHERE
    p.description = 'cheetos';

--to go a step further, only display if there are more tha 0,
WHERE
    p.description = 'cheetos' AND wp.on_hand > 0;

--4. Which warehouses have diet pepsi?
SELECT
    w.warehouse
FROM
    products p
JOIN
    warehouse_product wp ON p.id = wp.product_id
JOIN    
    warehouse w ON wp.warehouse_id = w.id
WHERE
    p.description = 'diet pepsi' AND wp.on_hand > 0;

--5. Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.
SELECT 
    c.first_name,
    c.last_name,
    COUNT(o.id) AS number_of_orders
FROM 
    customers c
LEFT JOIN 
    addresses a ON c.id = a.customer_id
LEFT JOIN 
    orders o ON a.id = o.address_id
GROUP BY  
    c.id, c.first_name, c.last_name
ORDER BY 
    number_of_orders DESC;
--6. How many customers do we have?
SELECT Count(*) from customers;

--7. How many products do we carry?
SELECT Count(*) from products;

--8. What is the total available on-hand quantity of diet pepsi?
    SELECT 
    SUM(wp.on_hand) AS total_available_quantity
FROM 
    products p
JOIN 
    warehouse_product wp ON p.id = wp.product_id
WHERE 
    p.description = 'diet pepsi';


## Stretch
--9. How much was the total cost for each order?
SELECT 
    o.id AS order_id,
    SUM(li.quantity * p.unit_price) AS total_cost
FROM 
    orders o
JOIN 
    line_items li ON o.id = li.order_id
JOIN 
    products p ON li.product_id = p.id
GROUP BY 
    o.id
ORDER BY 
    total_cost DESC;

--10. How much has each customer spent in total?
    SELECT 
    c.first_name,
    c.last_name,
    SUM(li.quantity * p.unit_price) AS total_spent
FROM 
    customers c
JOIN 
    addresses a ON c.id = a.customer_id
JOIN 
    orders o ON a.id = o.address_id
JOIN 
    line_items li ON o.id = li.order_id
JOIN 
    products p ON li.product_id = p.id
GROUP BY 
    c.id, c.first_name, c.last_name
ORDER BY 
    total_spent DESC;

--11. How much has each customer spent in total? Customers who have spent $0 should still show up in the table. It should say 0, not NULL (research coalesce).
SELECT 
    c.first_name,
    c.last_name,
    COALESCE(SUM(li.quantity * p.unit_price), 0) AS total_spent
FROM 
    customers c
LEFT JOIN 
    addresses a ON c.id = a.customer_id
LEFT JOIN 
    orders o ON a.id = o.address_id
LEFT JOIN 
    line_items li ON o.id = li.order_id
LEFT JOIN 
    products p ON li.product_id = p.id
GROUP BY 
    c.id, c.first_name, c.last_name
ORDER BY 
    total_spent DESC;
