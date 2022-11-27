USE northwind;

/* 1. Enunciado
Extraer toda la información sobre las compañias que tengamos en la BBDD

Nuestros jefes nos han pedido que creemos una query que nos devuelva todos los clientes y proveedores 
que tenemos en la BBDD. 

Mostrad la ciudad a la que pertenecen, el nombre de la empresa y el nombre del contacto, 
además de la relación (Proveedor o Cliente). 

Pero importante! No debe haber duplicados en nuestra respuesta.

La columna Relationship no existe y debe ser creada como columna temporal. 
Para ello añade el valor que le quieras dar al campo y utilizada como alias Relationship.

Nota: Deberás crear esta columna temporal en cada instrucción SELECT.

link para acceder a la tabla deseada:
https://books.adalab.es/materiales-d.a-promo-c/L56FacyaIcg8H1zCzuLk/modulo-1-python-basico-y-sql-basico/
modulo-1-bases-de-datos-y-sql/modulo-1-leccion-11-sql-union-intersect-except/pairprogramming-sql-11-union-intesect-except */


SELECT city AS City, company_name AS CompanyName, contact_name AS ContactName,'Customers' as Relationship
FROM customers
UNION
SELECT city AS City, company_name as CompanyName, contact_name AS ContactName, 'Suppliers' as Relationship
FROM suppliers
ORDER BY 1;

/* 2. Enunciado

Extraer todos los pedidos gestinados por "Nancy Davolio"

En este caso, nuestro jefe quiere saber cuantos pedidos ha gestionado "Nancy Davolio",una de nuestras empleadas. 
Nos pide todos los detalles tramitados por ella.

Los resultados de la query deben parecerse a la siguiente tabla:

ENLACE para acceder a la tabla deseada:
https://books.adalab.es/materiales-d.a-promo-c/L56FacyaIcg8H1zCzuLk/modulo-1-python-basico-y-sql-basico/
modulo-1-bases-de-datos-y-sql/modulo-1-leccion-11-sql-union-intersect-except/pairprogramming-sql-11-union-intesect-except 
*/


SELECT *
FROM orders
	WHERE employee_id IN ( 
	SELECT employee_id
    FROM employees
    GROUP BY employees.last_name = "Davolio" AND employees.first_name = 'Nancy'
	);
    

/* 3. Enunciado
Extraed todas las empresas que no han comprado en el año 1997.

En este caso, nuestro jefe quiere saber cuántas empresas no han comprado en el año 1997.
💡 Pista 💡 Para extraer el año de una fecha, podemos usar el estamento year.

ENLACE para acceder a la tabla deseada:
https://books.adalab.es/materiales-d.a-promo-c/L56FacyaIcg8H1zCzuLk/modulo-1-python-basico-y-sql-basico/
modulo-1-bases-de-datos-y-sql/modulo-1-leccion-11-sql-union-intersect-except/pairprogramming-sql-11-union-intesect-except 
*/

SELECT company_name as CompanyName, country
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
    WHERE YEAR(order_date)=1997);
        

/* 4. Enunciado
Extraed toda la información de los pedidos donde tengamos "Konbu".

Estamos muy interesados en saber como ha sido la evolución de la venta de Konbu a lo largo del tiempo. 
Nuestro jefe nos pide que nos muestre todos los pedidos que contengan "Konbu".

💡 Pista 💡 En esta query tendremos que combinar conocimientos adquiridos en las lecciones anteriores
 como por ejemplo el INNER JOIN. 
 
 ENLACE para acceder a la tabla deseada:
https://books.adalab.es/materiales-d.a-promo-c/L56FacyaIcg8H1zCzuLk/modulo-1-python-basico-y-sql-basico/
modulo-1-bases-de-datos-y-sql/modulo-1-leccion-11-sql-union-intersect-except/pairprogramming-sql-11-union-intesect-except 
 */
 
 SELECT *
 FROM orders
 INNER JOIN order_details
 ON orders.order_id = order_details.order_id
	INNER JOIN products
    ON order_details.product_id = products.product_id
    HAVING product_name = "Konbu";
    
  
 
 