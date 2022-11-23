use northwind;
--  Happy coding 🥳

-- 1.Extraed información de los productos "Beverages"
-- En este caso nuestro jefe nos pide que le devolvamos toda la información necesaria para identificar un tipo de producto. 
-- En concreto, tienen especial interés por los productos con categoría "Beverages". Devuelve el ID del producto, el nombre del producto y 
-- su ID de categoría.
select*
from products
left join categories
on products.category_id=categories.category_id
where category_name="Beverages";

-- 2.Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país
-- Suponemos que si se trata de ofrecer un mejor tiempo de entrega a los clientes, entonces podría dirigirse a estos países para buscar 
-- proveedores adicionales.
-- Los resultados de esta query son:

select country
from customers
where country not in(
select country
from suppliers)
group by country;

-- 3.Extraer los clientes que compraron mas de 20 articulos "Grandma's Boysenberry Spread"
-- Extraed el OrderId y el nombre del cliente que pidieron más de 20 artículos del producto "Grandma's Boysenberry Spread" (ProductID 6) 
-- en un solo pedido.

select order_id,customer_id
from orders
where order_id in(
	select order_id
	from order_details
	where product_id in (
		select product_id
		from products
having count(product_name="Grandma's Boysenberry Spread" >20)))
group by customer_id;


-- 4.Extraed los 10 productos más caros
-- Nos siguen pidiendo más queries correlacionadas. En este caso queremos saber cuáles son los 10 productos más caros.
select product_name,unit_price
from products
order by  unit_price desc
limit 10;



-- 5.BONUS:
-- Qué producto es más popular
-- Extraed cuál es el producto que más ha sido comprado y la cantidad que se compró.

select product_name, sum(quantity) 
from products natural join order_details
group  by product_name
order by sum(quantity) desc
limit 1;

(select product_id, sum(quantity)
from order_details
group by product_id
order by sum(quantity) desc;) segun esto, camembert vendio 1577 y cabrales 706...

