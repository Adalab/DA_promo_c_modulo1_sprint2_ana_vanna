use northwind;

--  	Happy coding 💪🏽

-- 1.Extraer en una CTE todos los nombres de las compañias y los id de los clientes.
-- Para empezar nos han mandado hacer una CTE muy sencilla el id del cliente y el nombre de la compañia de la tabla Customers.

WITH  company_name ( CustId,CompanyName) AS(
	SELECT customer_id, company_name
	FROM customers
	ORDER BY customer_id)
SELECT CustId, CompanyName
FROM company_name;

-- 2.Selecciona solo los de que vengan de "Germany"
-- Ampliemos un poco la query anterior. En este caso, queremos un resultado similar al anterior, pero solo queremos 
-- los que pertezcan a "Germany".

with company_name (customer_id, company_name, country) AS(
SELECT customer_id, company_name, country
FROM customers
WHERE country='Germany')
SELECT customer_id, company_name, country
FROM company_name;


-- 3.Extraed el id de las facturas y su fecha de cada cliente.
-- En este caso queremos extraer todas las facturas que se han emitido a un cliente, su fecha la compañia a la que pertenece.
-- 📌 NOTA En este caso tendremos columnas con elementos repetidos(CustomerID, y Company Name).

WITH ejercicio (customer_id,company_name,order_id,order_date) as( 
SELECT orders.customer_id,customers.company_name,orders.order_id,orders.order_date
FROM orders
JOIN customers
ON orders.customer_id=customers.customer_id)
SELECT *
FROM ejercicio;





-- 4.Contad el número de facturas por cliente
-- Mejoremos la query anterior. En este caso queremos saber el número de facturas emitidas por cada cliente.

WITH ejercicio4 (customer_id,company_name, numero_factura) AS (
SELECT customers.customer_id,customers.company_name,orders.order_id
FROM orders
LEFT JOIN customers
ON orders.customer_id=customers.customer_id)
SELECT customer_id,company_name, count(numero_factura)
FROM ejercicio4
GROUP BY 2
ORDER BY 1,2,3;

-- 5.Cuál la cantidad media pedida de todos los productos ProductID.
-- Necesitaréis extraer la suma de las cantidades por cada producto y calcular la media.

WITH ejercicio5 (producto, media) AS(
SELECT products.product_name,order_details.quantity
FROM order_details
LEFT JOIN products
ON products.product_id=order_details.product_id)
SELECT producto, avg(media)
FROM ejercicio5
GROUP BY 1
ORDER BY 1;

