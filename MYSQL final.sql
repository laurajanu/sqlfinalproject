USE sql_invoicing;

-- No1

SELECT client_id, invoice_total, number
FROM invoices
ORDER BY client_id ASC, invoice_total DESC;

-- No2

SELECT client_id
FROM invoices
GROUP BY client_id
ORDER BY client_id DESC;

-- No3

SELECT SUM(amount) AS 'is viso',
AVG(amount) AS 'mokejimu vidurkis',
MIN(amount) AS 'maziausias',
MAX(amount) AS 'didziausias',
COUNT(DISTINCT client_id) AS klientai,
COUNT(DISTINCT invoice_id) AS saskaitos 
FROM payments;

-- No4

USE sql_hr;

SELECT *, (salary * 115/100) AS new_salary
FROM employees
WHERE salary < 40000
ORDER BY salary DESC;

-- No5

USE sql_store;

SELECT POSITION('e' IN name) AS pozicija, name
FROM products
ORDER BY pozicija DESC;

-- No6

SELECT *
FROM customers
WHERE (city = 'Vilnius' OR city = 'Klaipėda' OR city = 'Šiauliai') AND (points < 1000)
ORDER BY points ASC;

-- No7

USE sql_hr;

SELECT SUM(salary) AS sum_salary
FROM employees
WHERE job_title LIKE '%Operacijų%';

USE sql_store;

-- No 8

SELECT s.name, COUNT(DISTINCT oi.product_id) AS cnt_unique_products, COUNT(DISTINCT o.order_id) AS cnt_unique_orders
FROM orders AS o
JOIN order_items AS oi
ON o.order_id = oi.order_id
JOIN shippers as s
ON s.shipper_id = o.shipper_id
GROUP BY s.name
ORDER BY s.name ASC;

USE SAKILA;

-- No 9

SELECT title,
	CASE
	WHEN rating IN ('PG', 'G')
    THEN 'PG_G'
    WHEN rating IN ('NC-17', 'PG-13')
    THEN 'NC17_PG13'
    ELSE 'NESVARBU'
END AS 'reitingo grupe'
FROM film;

-- No 10

SELECT 
	CASE
	WHEN rating IN ('PG', 'G')
    THEN 'PG_G'
    WHEN rating IN ('NC-17', 'PG-13')
    THEN 'NC17_PG13'
    ELSE 'NESVARBU'
END AS reitingo_grupe,
	COUNT(*) AS rating_count
FROM film
GROUP BY reitingo_grupe
HAVING rating_count BETWEEN 250 AND 450;


SELECT
	CASE
		WHEN rating = 'PG' THEN 'PG_G'
        WHEN rating = 'G' THEN 'PG_G'
        WHEN rating = 'NC-17' THEN 'NC-17_PG-13'
        WHEN rating = 'PG-13' THEN 'NC-17_PG-13'
        ELSE 'NESVARBU'
	END AS reitingo_grupe,
    COUNT(*) AS reitingo_count
FROM film
GROUP BY reitingo_grupe
HAVING reitingo_count BETWEEN 250 AND 450;

-- No 11

SELECT first_name, last_name, F.film_id, F.title
FROM rental AS R
	JOIN customer AS C
ON R.customer_id = C.customer_id
	JOIN inventory AS I
ON R.inventory_id = I.inventory_id
	JOIN film AS F
ON I.film_id = F.film_id
WHERE title = 'AGENT TRUMAN'
ORDER BY first_name ASC;

SELECT
  (SELECT first_name FROM customer WHERE customer_id = R.customer_id) AS first_name,
  (SELECT last_name FROM customer WHERE customer_id = R.customer_id) AS last_name,
  (SELECT film_id FROM inventory WHERE inventory_id = R.inventory_id) AS film_id,
  F.title
FROM rental AS R
JOIN customer AS C ON R.customer_id = C.customer_id
JOIN inventory AS I ON R.inventory_id = I.inventory_id
JOIN film AS F ON I.film_id = F.film_id
WHERE F.title = 'AGENT TRUMAN'
ORDER BY first_name ASC;

-- No12

USE sql_invoicing;

SELECT C.client_id, C.name, SUM(I.payment_total - I.invoice_total) AS skola, MIN(I.payment_date) AS min_payment_date, COUNT(*) AS count
FROM clients AS C
JOIN invoices AS I
ON C.client_id = I.client_id
GROUP BY C.client_id, C.name
ORDER BY skola ASC;


USE sql_store;

-- No 13

SELECT name,
	CASE
		WHEN name LIKE '% %' THEN REPLACE(name, ' ', '***')
        ELSE CONCAT('!!!', name)
	END AS new_name
FROM products;

-- No 14

SELECT CONCAT(first_name, ' ', last_name) AS name, points
FROM customers
WHERE points > (SELECT AVG(points) FROM customers)
ORDER BY points DESC;

-- No 15

CREATE TABLE new_table (
    vardas VARCHAR(50),
    `VCS Mysql kursas` VARCHAR(50),
    `surinkau tasku` VARCHAR(50)
);

INSERT INTO new_table (vardas, `VCS Mysql kursas`, `surinkau tasku`)
VALUES ('Laura', 'labai patiko', 'daug');