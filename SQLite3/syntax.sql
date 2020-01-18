
CREATE DATABASE yc_database;

DROP DATABASE yc_database;

USE yc_database; 

CREATE TABLE customers(
    id INT NOT NULL AUTO_INCREMENT,
    firstName VARCHAR(255),
    lastNAme VARCHAR(255),
    email VARCHAR(255),
    `address` VARCHAR(255),
    PRIMARY KEY(id)
)

INSERT INTO customers (firstName, lastName, email, `address`)
VALUES ("YC", "PARK", "yc091893@gmail.com", "Seoul"),
("Madison", "Lee", "md.lee@gmail.com", "Seoul"),
("Rick", "Sanchez", "rsanchez@gmail.com", "Earth-D137");

UPDATE customers 
SET email="updated@gmail.com"
WHERE id=3;


DELETE FROM customers
WHERE id=3;

ALTER TABLE customers 
ADD newCol VARCHAR(255);

ALTER TABLE customers
MODIFY COLUMN testCol INT(11);

ALTER TABLE customers
DROP COLUMN testCol;



SELECT * FROM customers
WHERE id=3;


SELECT firstName FROM customers
ORDER BY lastName DESC;

SELECT DISTINCT `address` FROM customers; 
/* Get unique values of address column */

SELECT * FROM customers WHERE age < 30; 

SELECT * FROM customers WHERE firstName <> "Rick"; /* Not equals to */


SELECT * FROM customers WHERE age BETWEEN 15 AND 30; 


SELECT * FROM customers WHERE firstName LIKE "R%"; 
/* Starts with R */ 

SELECT * FROM customers WHERE firstName NOT LIKE "R%"; 
/* Doesn't start with R */ 

SELECT * FROM customers WHERE email IS NOT NULL;

SELECT * FROM customers WHERE dept IS NOT DISTINCT FROM receivables; 
/* Is equal to value or both are nulls (missing data) */

SELECT employee AS 'department1';
/* Used to change a field name when viewing results */

SELECT * FROM customers
WHERE `address` IN ('Seoul', 'Pyoungyang')
/* Get all record with address equal to either Seoul or PY */


/*
Indexes speeds up searches/queries.
Should create indexes on columns which are searched frequently
*/

CREATE INDEX CIndex
on customers(firstName);

SELECT firstName FROM customers;
/* This apparently should be faster now */

DROP INDEX CIndex on customers;



CREATE TABLE orders(
    id INT NOT NULL AUTO_INCREMENT,
    orderNumber INT,
    productId INT,
    customerId INT,
    orderDate DATETIME default CURRENT_TIMESTAMP,
    PRIMARY KEY(id),
    FOREIGN KEY(custoemrId) REFERENCES customers(id)
    FOREIGN KEY(productId) REFERENCES products(id)
);



/* INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN */

SELECT customers.firstName, customers.lastName, orders.orderNumber
FROM customers
INNER JOIN orders
ON customers.id = orders.customerId
ORDER BY orders.orderNumber;


SELECT customers.firstName, customers.lastName, orders.orderNumber, orders.orderDate
FROM customers
LEFT JOIN orders ON customers.id = orders.customerId
ORDER BY customers.lastName;


SELECT orders.orderNumber, customers.firstName, customers.lastName
FROM orders
RIGHT JOIN customers 
ON orders.customerId = customers.id
ORDER BY orders.orderNumber;


SELECT orders.orderNumber, customers.firstName, customers.lastName, products.name
FROM orders
  INNER JOIN products
    ON orders.productId = products.id
  INNER JOIN customers
    ON orders.customerId = customers.id
ORDER BY orders.orderNumber;

/* ALIASES */

SELECT firstName AS "First Name", lastName AS "Last Name" FROM customers;
/* Changes the column names */

SELECT CONCAT(firstName, " ", lastName) AS "Name", address FROM customers;
/* Join the value of the two columns */


SELECT o.id, o.orderDate, c.firstName, c.lastName
FROM customers AS c, orders AS o


/* AGGREGATE FUNCTIONS */

SELECT COUNT(age) FROM customers;
SELECT MAX(age) FROM customers;
SELECT MIN(age) FROM customers;
SELECT AVG(age) from customers;
SELECT SUM(age) FROM customers;

SELECT age, COUNT(age)
FROM customers
WHERE age > 30
GROUP BY age;


SELECT age, COUNT(age)
FROM customers
WHERE age > 30
GROUP BY age
HAVING COUNT(age) >= 2;


SELECT LCASE(firstName), UCASE(lastName) FROM customers;
/* Makes all the values into lower/uppercase */
