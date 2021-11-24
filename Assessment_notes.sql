#1 Create a query to return all orders made by users with the first name of “Marion” 
#SELECT orders. * #the * the.orders* narrows it down.
#FROM orders
#LEFT JOIN users ON users.user_id = orders.user_id
#WHERE users.first_name = 'Marion'


#SELECT o.* 

#FROM orders o  #o is the alias for orders
#JOIN users u USING(USER_ID) 
#WHERE first_name = 'Marion';

#SELECT * FROM orders
#WHERE orders.USER_ID IN (SELECT USER_ID 
#FROM users 
#WHERE first_name = 'Marion');


#SET @rownum:=0;
# 1 + 1= 2
#SELECT @rownum:=@rownum+1 AS '', order_id, user_id, store_id
#FROM orders
#JOIN users
#USING (user_id)
#WHERE first_name = 'Marion';    
# //with an increment before each row



#2 Create a query to select all users that have not made an order 

#SELECT * 
#FROM users
#WHERE `user_id` NOT IN (SELECT user_id FROM orders)

SELECT * FROM users
WHERE USER_ID NOT IN (SELECT user_id FROM orders 
GROUP BY user_id);

SELECT * FROM users
WHERE users.USER_ID NOT IN (SELECT USER_ID FROM orders);


SELECT * FROM USERS WHERE USER_ID NOT IN (
SELECT DISTINCT(USER_ID) FROM orders);


SELECT u.*
FROM users u
LEFT JOIN orders o USING (USER_ID)
WHERE ISNULL(ORDER_ID);


SELECT u.* FROM users U 
LEFT OUTER JOIN orders  O ON u.USER_ID = o.USER_ID 
WHERE O.USER_ID IS NULL;




#3 Create a Query to select the names and prices of all items that have been part of 2 or 
#more separate orders.


SELECT * FROM ITEMS WHERE ITEM_ID IN
(
SELECT ITEM_ID 
FROM ORDER_ITEMS 
GROUP BY ITEM_ID 
HAVING COUNT(ORDER_ID) > 1);


SELECT i.NAME, i.PRICE  
FROM items I, ORDER_ITEMS OI 
GROUP BY oI.ORDER_ID 
HAVING COUNT(DISTINCT OI.ITEM_ID) > 1;


SELECT items.NAME, items.PRICE
FROM items
JOIN order_items
ON items.ITEM_ID = order_items.ITEM_ID
GROUP BY order_items.ITEM_ID
HAVING COUNT(order_items.ITEM_ID) >= 2;


SELECT * FROM users
WHERE USER_ID NOT IN (SELECT user_id FROM orders GROUP BY user_id);


SELECT NAME,PRICE
 FROM  ITEMS
JOIN  ORDER_ITEMS 
 ON ITEMS.ITEM_ID = ORDER_ITEMS.ITEM_ID
WHERE 1 <(SELECT COUNT(ORDER_ITEMS.ITEM_ID) FROM order_items)
GROUP BY  ITEMS.ITEM_ID;


#4

SELECT order_items.ORDER_ID, items.NAME, items.PRICE, order_items.QUANTITY
FROM items
JOIN order_items
ON items.ITEM_ID = order_items.ITEM_ID
JOIN orders
ON orders.ORDER_ID = order_items.ORDER_ID
JOIN stores
ON orders.STORE_ID = stores.STORE_ID
WHERE stores.CITY = 'New York'
ORDER BY orders.ORDER_ID;


SELECT oi.order_id, i.NAME, oi.quantity, i.PRICE
FROM order_items oi
JOIN items i
USING (item_id)
WHERE order_id IN
(
SELECT order_id
FROM orders
JOIN stores
USING (store_id)
WHERE city = 'New York')
ORDER BY order_id;


SELECT oi.ORDER_ID, i.NAME, i.PRICE, oi.QUANTITY
FROM ORDER_ITEMS oi
JOIN ITEMS i ON oi.ITEM_ID = i.ITEM_ID
JOIN ORDERS o ON oi.ORDER_ID = o.ORDER_ID
JOIN STORES s ON o.STORE_ID = s.STORE_ID
WHERE s.CITY = 'New York'
ORDER BY o.ORDER_ID;


SELECT OI.ORDER_ID, I.NAME, I.PRICE, OI.QUANTITY FROM ORDER_ITEMS OI, ITEMS I WHERE OI.ITEM_ID = I.ITEM_ID
AND ORDER_ID IN (
SELECT ORDER_ID FROM ORDERS WHERE STORE_ID IN 
(SELECT STORE_ID FROM STORES WHERE CITY = 'NEW YORK')) ORDER BY OI.ORDER_ID;



SELECT o.ORDER_ID, i.NAME, i.PRICE, oi.QUANTITY   FROM items AS i
INNER JOIN order_items AS oi ON i.ITEM_ID=oi.ITEM_ID 
INNER JOIN orders AS o ON oi.ORDER_ID=o.ORDER_ID
 INNER JOIN stores AS s ON o.STORE_ID=s.STORE_ID 
 WHERE s.CITY='New York' ORDER BY o.ORDER_ID;


SELECT
	oi.order_id AS 'Order ID',
	i.`name` AS 'Item name',
	i.price AS 'Item price',
	oi.quantity AS 'Quantity'
FROM items i
JOIN order_items oi USING(ITEM_ID)
JOIN orders o USING(ORDER_ID)
JOIN stores s USING(STORE_ID)
WHERE s.CITY = 'New York'
ORDER BY oi.order_id ASC;


SELECT o.ORDER_ID, i.NAME, i.PRICE, oi.QUANTITY
FROM items i JOIN order_items oi ON i.ITEM_ID = oi.ITEM_ID
     JOIN orders o ON oi.ORDER_ID = o.ORDER_ID
     JOIN stores s ON o.STORE_ID = s.STORE_ID
WHERE s.CITY = 'New York'
ORDER BY oi.ORDER_ID;


#5

SELECT i.NAME AS 'ITEM_NAME', SUM(oi.QUANTITY)*i.PRICE AS REVENUE 
FROM items AS i 
inner join order_items AS oi ON   i.ITEM_ID=oi.ITEM_ID 
GROUP BY oi.ITEM_ID 
ORDER BY REVENUE DESC ;


SELECT NAME AS ITEM_NAME, price*sum(quantity) AS REVENUE
FROM order_items
JOIN items
USING (item_id)
GROUP BY item_id


SELECT items.NAME AS 'ITEM_NAME', SUM(items.PRICE*order_items.QUANTITY) AS 'REVENUE'
FROM items
JOIN order_items
ON order_items.ITEM_ID = items.ITEM_ID
GROUP BY items.NAME
ORDER BY REVENUE DESC;


SELECT I.NAME AS ITEM_NAME, (SUM(OI.QUANTITY)*I.PRICE) AS REVENUE 
FROM items I 
JOIN order_items OI ON I.ITEM_ID = OI.ITEM_ID 
JOIN ORDERS O ON OI.ORDER_ID=O.ORDER_ID 
GROUP BY I.NAME;



SELECT
	NAME,
	price,
	COUNT(*) AS 'total',
	SUM(price*quantity) AS 'RESULT'
FROM 
	order_items
	JOIN items USING (item_id)
GROUP BY
	item_id
ORDER BY
	SUM(price*quantity) DESC
	
	
SELECT
	i.`NAME` AS ITEM_NAME,
	SUM(i.price * oi.quantity) AS REVENUE
FROM order_items oi
JOIN items i USING(item_id)
GROUP BY i.`NAME`
ORDER BY REVENUE DESC;
	
	
SELECT I.NAME , SUM(OI.QUANTITY * I.PRICE) AS REVENUE 
 FROM ORDER_ITEMS OI 
 JOIN ITEMS I WHERE OI.ITEM_ID = I.ITEM_ID
 GROUP BY NAME 
 order by revenue desc ;

#6
SELECT
	sn AS 'Store Name',
	oq AS 'Order Quantity',
	CASE
		WHEN oq > 3 THEN 'High'
		WHEN oq > 1
			AND oq <= 3 THEN 'Medium'
		WHEN oq <= 1 THEN 'Low'
		ELSE 'Error'
	END AS 'Sales Figure'
FROM(
	SELECT
		s.`NAME` AS sn,
		COUNT(o.order_ID) AS oq
	FROM stores s
	LEFT JOIN orders o USING(store_id)
	GROUP BY sn
) AS storedata
ORDER BY oq DESC;


SELECT stores.NAME, COUNT(orders.STORE_ID) AS 'ORDER_QUANTITY', 
CASE
	WHEN COUNT(orders.STORE_ID) > 3 THEN 'HIGH'
	WHEN COUNT(orders.STORE_ID) <= 3 AND COUNT(orders.STORE_ID) > 1 THEN 'MEDIUM'
	ELSE 'LOW'
	END AS 'SALES_FIGURE'
FROM stores
JOIN orders
ON orders.STORE_ID = stores.STORE_ID
GROUP BY orders.STORE_ID
ORDER BY ORDER_QUANTITY DESC;



SELECT s.NAME, COUNT(o.STORE_ID) AS ORDER_QUANTITY, 
CASE 
	WHEN COUNT(o.STORE_ID) > 3 THEN 'High'
	WHEN COUNT(o.STORE_ID) <= 3 AND COUNT(o.STORE_ID) > 1 THEN 'Medium'
	ELSE 'Low'
END AS SALES_FIGURE
FROM STORES s
JOIN ORDERS o ON s.STORE_ID = o.STORE_ID
GROUP BY s.NAME
ORDER BY COUNT(o.STORE_ID) DESC;


SELECT S.NAME as NAME,  COUNT(O.ORDER_ID) AS ORDER_QUANTITY ,
CASE WHEN COUNT(O.ORDER_ID) > 3 THEN 'High' 
	 WHEN COUNT(O.ORDER_ID) > 1 AND COUNT(O.ORDER_ID) <= 3 THEN 'Medium ' 
	 ELSE 'Low' 
 END AS SALES_FIGURE
from orders O , stores S 
where o.store_id = s.store_id
group by s.name
order by ORDER_QUANTITY desc;


SELECT
	s.name AS 'Store Name',
	COUNT(o.order_id) AS 'Order Quantity',
	case
		when COUNT(o.order_id) > 3 then 'High'
		when COUNT(o.order_id) <= 1 then 'Low'
		ELSE 'Medium'
	END AS 'Sales Figure'
FROM stores s left JOIN orders o USING(store_id)
GROUP BY store_id
ORDER BY COUNT(o.order_id) DESC;



SELECT s.NAME, count(o.STORE_ID) AS ORDER_QUANTITY, 

(CASE WHEN count(o.STORE_ID)>3 then 'High'
WHEN count(o.STORE_ID)<4 AND COUNT(o.STORE_ID)>=2 then 'Medium'
WHEN count(o.STORE_ID)<2 then 'Low'

END )  as SALES_FIGURE
FROM stores AS s INNER JOIN orders AS o ON s.STORE_ID=o.STORE_ID
 GROUP  BY s.NAME ORDER BY ORDER_QUANTITY DESC
;



SELECT s.NAME, COUNT(o.ORDER_ID) AS 'Order Quantity' ,
      case  when COUNT(o.ORDER_ID) > 3 then 'High'
            when COUNT(o.ORDER_ID) <= 3 AND COUNT(o.ORDER_ID) > 1 then 'Medium'
            when COUNT(o.ORDER_ID) <= 1 then 'Low'
      END AS 'Sales Figure'
                                    
FROM stores s JOIN orders o ON s.STORE_ID = o.STORE_ID
GROUP BY s.STORE_ID
ORDER BY COUNT(o.ORDER_ID) DESC;













