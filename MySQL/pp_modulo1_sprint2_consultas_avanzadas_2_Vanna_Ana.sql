USE northwind;

--  1 Relación entre número de pedidos y máxima carga:
-- 		Desde logística nos piden el número de pedidos y la máxima cantidad de carga de entre los mismos (freight) que han sido enviados 
-- 		por cada empleado (mostrando el ID de empleado en cada caso).

SELECT employee_id AS EmployeeId,COUNT(order_id) AS OrderId,MAX(freight) AS MaxFreight
FROM orders
GROUP BY employee_id;


--  2 Descartar pedidos sin fecha y ordénalos:
-- 	 Una vez han revisado los datos de la consulta anterior, nos han pedido afinar un poco más el "disparo". En el resultado anterior se han 
-- 	 incluido muchos pedidos cuya fecha de envío estaba vacía, por lo que tenemos que mejorar la consulta en este aspecto. 
-- 	 También nos piden que ordenemos los resultados según el ID de empleado para que la visualización sea más sencilla.

SELECT employee_id AS EmployeeId,COUNT(order_id) AS TotalOrders,MAX(freight) AS MaxFreight,shipped_date AS ShipDate
FROM orders
GROUP BY employee_id
HAVING shipped_date IS NOT NULL
ORDER BY employee_id ;

--  3 Números de pedidos por día:
-- 		El siguiente paso en el análisis de los pedidos va a consistir en conocer mejor la distribución de los mismos según las fechas. 
-- 		Por lo tanto, tendremos que generar una consulta que nos saque el número de pedidos para cada día, mostrando de manera separada 
-- 		el día (DAY()), el mes (MONTH()) y el año (YEAR()).



SELECT  count(order_id) AS pedidos,DAY(order_date) AS dia, MONTH(order_date) AS mes, YEAR(order_date) AS año
FROM orders
GROUP BY order_date;

-- 4 Número de pedidos por mes y año:
-- 		La consulta anterior nos muestra el número de pedidos para cada día concreto, pero esto es demasiado detalle. 
-- 		Genera una modificación de la consulta anterior para que agrupe los pedidos por cada mes concreto de cada año.


SELECT count(order_id) AS OrderId, MONTH(order_date) AS `Month`, YEAR(order_date) AS `Year`
FROM orders
GROUP BY `Month`;



--  5 Seleccionad las ciudades con 4 o más empleadas:
-- 		Desde recursos humanos nos piden seleccionar los nombres de las ciudades con 4 o más empleadas de cara a estudiar la apertura de 
-- 		nuevas oficinas.

SELECT city, COUNT(employee_id) AS EmployeeId, country
FROM employees
GROUP BY country
HAVING COUNT(employee_id)>4;

--  6 Cread una nueva columna basándonos en la cantidad monetaria:
-- 		Necesitamos una consulta que clasifique los pedidos en dos categorías ("Alto" y "Bajo") en función de la cantidad monetaria 
-- 		total que han supuesto: por encima o por debajo de 2000 euros.
SELECT 
CASE 
    WHEN (unit_price*quantity) < 2000 THEN 'Low'
	ELSE 'High'
    END AS Category, (unit_price*quantity) AS TotalPrice
FROM order_details
ORDER BY Category;
--  ordenamos por cantidad para mejor legibilidad

		
-- **Happy coding 😀**