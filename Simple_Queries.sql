#1
SELECT productName AS 'Name', productLine AS 'Product Line', buyPrice AS 'Buy Price'
FROM products
ORDER BY buyPrice
DESC;


#2
SELECT contactFirstName AS 'First Name', contactLastName AS 'Last Name', city AS 'City', country 
FROM customers
WHERE country='germany'
ORDER BY contactLastName
ASC; 


#3
SELECT UNIQUE status
FROM orders
ORDER BY status
asc; 


#4
SELECT * 
FROM payments
WHERE paymentDate >= '2005-1-1'
ORDER BY paymentDate
ASC;

#5
#SELECT lastName, firstName, email, jobTitle, city
#FROM employees, offices
#WHERE city = 'San Francisco'
#ORDER BY lastName
#ASC;


#6
SELECT productName, productLine, productScale, productVendor
FROM products
WHERE productLine IN ('Vintage Cars','Classic Cars')
ORDER by productName
asc;
