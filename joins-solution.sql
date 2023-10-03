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


--6. How many customers do we have?


--7. How many products do we carry?


--8. What is the total available on-hand quantity of diet pepsi?



## Stretch
--9. How much was the total cost for each order?


--10. How much has each customer spent in total?


--11. How much has each customer spent in total? Customers who have spent $0 should still show up in the table. It should say 0, not NULL (research coalesce).
