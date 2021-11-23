
#1
#SELECT NAME AS 'Product', PRODUCT_TYPE_CD AS 'Type'
#FROM product


#2
#SELECT NAME, city, last_name, title
#FROM branch, employee


#3
#SELECT UNIQUE title
#FROM employee

#4
#SELECT last_name, title, last_name AS 'Boss Last Name', title AS 'Boss Title', superior_emp_id
#FROM employee 


#5
#SELECT unique product_type_cd AS 'name', avail_balance, last_name
#FROM `account`, customer, individual, product
#WHERE product_type_cd IN ('account');
