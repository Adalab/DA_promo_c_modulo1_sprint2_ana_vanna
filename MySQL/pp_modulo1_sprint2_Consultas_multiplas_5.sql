USE northwind;

/* Ejercicio 1.
Extraed los pedidos con el máximo "order_date" para cada empleado.

Nuestro jefe quiere saber la fecha de los pedidos más recientes que ha gestionado cada empleado. 
Para eso nos pide que lo hagamos con una query correlacionada.

Enlace https://books.adalab.es/materiales-d.a-promo-c/L56FacyaIcg8H1zCzuLk/
modulo-1-python-basico-y-sql-basico/modulo-1-bases-de-datos-y-sql/
modulo-1-leccion-13-sql-correlated-like/pairprogramming-sql-13-sql-correlated-like
*/

SELECT order_id AS OrderID,customer_id AS CustomerID, employee_id AS EmployeeID,order_date AS OrderDate,required_date AS RequiredDate
FROM orders as o1
WHERE order_date = ( 
	SELECT max(order_date)
	FROM  orders as o2
    WHERE o1.employee_id = o2.employee_id);

/* Ejercicio 2.
Extraed el precio unitario máximo (unit_price) de cada producto vendido.

Supongamos que ahora nuestro jefe quiere un informe de los productos vendidos y su precio unitario. 
De nuevo lo tendréis que hacer con queries correlacionadas.

Enlace https://books.adalab.es/materiales-d.a-promo-c/L56FacyaIcg8H1zCzuLk/
modulo-1-python-basico-y-sql-basico/modulo-1-bases-de-datos-y-sql/
modulo-1-leccion-13-sql-correlated-like/pairprogramming-sql-13-sql-correlated-like
*/

SELECT product_id AS ProductID, unit_price as MAX_unit_price_sold
FROM order_details as o1
WHERE unit_price = ( 
	SELECT max(unit_price)
	FROM  order_details as o2
	WHERE o2.product_id like o1.product_id)
GROUP by 1,2
ORDER BY 1,2;

/* Ejercicio 3.
Ciudades que empiezan con "A" o "B".

Por un extraño motivo, nuestro jefe quiere que le devolvamos una tabla con aquelas compañias que están 
afincadas en ciudades que empiezan por "A" o "B".
 
Necesita que le devolvamos la ciudad, el nombre de la compañia y el nombre de contacto.

Enlace https://books.adalab.es/materiales-d.a-promo-c/L56FacyaIcg8H1zCzuLk/
modulo-1-python-basico-y-sql-basico/modulo-1-bases-de-datos-y-sql/
modulo-1-leccion-13-sql-correlated-like/pairprogramming-sql-13-sql-correlated-like
*/


SELECT city, company_name,contact_name  
FROM customers  
WHERE city BETWEEN "A%" AND "C%";

SELECT city AS City, company_name AS CompanyName,contact_name AS ContactName  
FROM customers  
WHERE city LIKE "A%" OR city LIKE "B%";

/* Ejercicio 4.
Número de pedidos que han hecho en las ciudades que empiezan con L.

En este caso, nuestro objetivo es devolver los mismos campos que en 
la query anterior el número de total de pedidos que han hecho todas 
las ciudades que empiezan por "L".

Enlace https://books.adalab.es/materiales-d.a-promo-c/L56FacyaIcg8H1zCzuLk/
modulo-1-python-basico-y-sql-basico/modulo-1-bases-de-datos-y-sql/
modulo-1-leccion-13-sql-correlated-like/pairprogramming-sql-13-sql-correlated-like
*/

SELECT customers.city AS ciudad, customers.company_name as empresa, customers.contact_name as persona_contacto, count(orders.order_id) AS numero_pedido
FROM customers 
LEFT JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY 1,2,3
HAVING customers.city LIKE "l%";

/* Ejercicio 5.
Todos los clientes cuyo "contact_title" no incluya "Sales".

Nuestro objetivo es extraer los clientes que no tienen el contacto "Sales" en su "contact_title". 
Extraer el nombre de contacto, su posisión (contact_title) y el nombre de la compañia.

Enlace https://books.adalab.es/materiales-d.a-promo-c/L56FacyaIcg8H1zCzuLk/
modulo-1-python-basico-y-sql-basico/modulo-1-bases-de-datos-y-sql/
modulo-1-leccion-13-sql-correlated-like/pairprogramming-sql-13-sql-correlated-like
*/

SELECT contact_name, contact_title, company_name
FROM customers
WHERE contact_title NOT LIKE "%Sales%"
GROUP BY 2,1,3;


/* Ejercicio 6.
Todos los clientes que no tengan una "A" en segunda posición en su nombre.
Devolved unicamente el nombre de contacto.

Enlace https://books.adalab.es/materiales-d.a-promo-c/L56FacyaIcg8H1zCzuLk/
modulo-1-python-basico-y-sql-basico/modulo-1-bases-de-datos-y-sql/
modulo-1-leccion-13-sql-correlated-like/pairprogramming-sql-13-sql-correlated-like
*/

SELECT contact_name AS ContactName
FROM customers
WHERE contact_name NOT LIKE "_a%";

