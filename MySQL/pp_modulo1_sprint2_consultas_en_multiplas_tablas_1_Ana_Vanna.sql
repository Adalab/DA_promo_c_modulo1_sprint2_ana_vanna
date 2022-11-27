USE northwind;

-- Antes de empezar vamos a abrir el "Reverse Engineer" para revisar las relaciones entre las differentes tablas.
-- Instrucciones para abrir el diagrama ER, DATABASE >> Reverse Engineering >> Seguir el WIZARD paso a paso.

/* Ejercicio 1.
Pedidos por empresa en UK:
Desde las oficinas en UK nos han pedido con urgencia que realicemos una consulta a la base 
de datos con la que podamos conocer cuántos pedidos ha realizado cada empresa cliente de UK. 

Nos piden el ID del cliente y el nombre de la empresa y el número de pedidos.*/

SELECT customers.company_name AS NombreEmpresa, customers.customer_id AS Identificador, count(orders.order_id) AS NumeroPedido
FROM customers INNER JOIN orders
ON customers.customer_id = orders.customer_id
WHERE country = "UK"
GROUP BY customers.company_name, customers.customer_id;

/* Ejercicio 2.
Productos pedidos por empresa en UK por año:
Desde Reino Unido se quedaron muy contentas con nuestra rápida respuesta a su petición anterior 
y han decidido pedirnos una serie de consultas adicionales. 

La primera de ellas consiste en una query que nos sirva para conocer cuántos objetos 
ha pedido cada empresa cliente de UK durante cada año. 

Nos piden concretamente conocer el nombre de la empresa, el año, y la cantidad de objetos que han pedido. 

Para ello hará falta hacer 2 joins.
El resultado será una tabla similar a esta: NombreEmpresa (se repite la misma) , Año, NumObjectos (es una suma) */

SELECT YEAR(orders.order_date) AS Year, customers.company_name AS CompanyName, SUM(order_details.quantity)
FROM order_details 
INNER JOIN orders ON order_details.order_id = orders.order_id
INNER JOIN customers ON customers.customer_id = orders.customer_id
WHERE customers.country = "UK"
GROUP BY 1,2
ORDER BY 2,1;

-- SELECT YEAR(orders.order_date) AS Year, customers.company_name AS CompanyName, SUM(order_details.quantity) AS Quantity
-- FROM order_details 
-- INNER JOIN orders USING (order_id)
-- INNER JOIN customers USING (customer_id)
-- WHERE customers.country = "UK"
-- GROUP BY Year, CompanyName
-- ORDER BY CompanyName,Year;


/* Ejercicio 3.

Mejorad la query anterior:
Lo siguiente que nos han pedido es la misma consulta anterior pero con la adición de la cantidad de dinero 
que han pedido por esa cantidad de objetos, teniendo en cuenta los descuentos, etc. 

Ojo que los descuentos en nuestra tabla nos salen en porcentajes, 15% nos sale como 0.15.

La tabla resultante será: NombreEmpresa, Año, NumObjecto, DineroTotal 
Crear esta columna utilizando en la select query el (*)
 (será primero calcular el descuento moltiplicandolo y despues restar del total esta cantitad) */
 
SELECT YEAR(orders.order_date) AS Year, customers.company_name AS CompanyName, SUM(order_details.quantity) AS Quantity, SUM(order_details.quantity*(order_details.unit_price-(order_details.unit_price*discount))) AS DineroTotal
FROM order_details 
INNER JOIN orders USING (order_id)
INNER JOIN customers USING (customer_id)
WHERE customers.country = "UK"
GROUP BY Year, CompanyName
ORDER BY CompanyName,Year; 

-- Para calcular el DineroTotal se tiene que hacer (cantidad * (precio_unidad-(precio_unidad * descuento))
 
 /* BONUS: Pedidos que han realizado cada compañía y su fecha:
 
Después de estas solicitudes desde UK y gracias a la utilidad de los resultados que se han obtenido, 
desde la central nos han pedido una consulta que indique el nombre de cada compañia cliente junto con cada pedido que han realizado y su fecha.
El resultado deberá ser: ver tabla en GITBOOK*/ 

SELECT  orders.order_id AS OrderID, customers.company_name AS CompanyName, orders.order_date AS OrderDate
FROM orders
INNER JOIN customers ON customers.customer_id = orders.customer_id
ORDER BY 2;

 
 /* BONUS: Tipos de producto vendidos:

Ahora nos piden una lista con cada tipo de producto que se han vendido, sus categorías, nombre de la categoría y el nombre del producto,
 y el total de dinero por el que se ha vendido cada tipo de producto (teniendo en cuenta los descuentos).
Pista Necesitaréis usar 3 joins.*/


SELECT categories.category_id AS CategoryID, categories.category_name AS CategoryName, products.product_name AS ProductName , ROUND(SUM(order_details.quantity*(order_details.unit_price-(order_details.unit_price*discount))),1) AS ProductSales
FROM products
INNER JOIN categories USING (category_id)
INNER JOIN order_details USING (product_id)
GROUP BY 1,2,3;




