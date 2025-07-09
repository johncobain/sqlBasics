-- JOINS

SELECT t1.cpf, t1.name, t2.state
FROM temp_tables.tabela_1 AS t1
LEFT JOIN temp_tables.tabela_2 AS t2
	ON t1.cpf=t2.cpf;


SELECT t1.cpf, t1.name, t2.state
FROM temp_tables.tabela_1 AS t1
INNER JOIN temp_tables.tabela_2 AS t2 -- = JOIN
	ON t1.cpf=t2.cpf;


SELECT t2.cpf, t1.name, t2.state
FROM temp_tables.tabela_1 AS t1
RIGHT JOIN temp_tables.tabela_2 AS t2
	ON t1.cpf=t2.cpf;


SELECT t1.cpf, t1.name, t2.state
FROM temp_tables.tabela_1 AS t1
FULL JOIN temp_tables.tabela_2 AS t2
	ON t1.cpf=t2.cpf;

-- EXERCÍCIOS ########################################################################

-- (Exemplo 1) Identifique qual é o status profissional mais frequente nos clientes 
-- que compraram automóveis no site


SELECT
	cus.professional_status,
	count(fun.paid_date) AS pagamentos
FROM sales.funnel AS fun
LEFT JOIN sales.customers AS cus
	ON fun.customer_id = cus.customer_id
GROUP BY cus.professional_status
ORDER BY pagamentos DESC;

-- (Exemplo 2) Identifique qual é o gênero mais frequente nos clientes que compraram
-- automóveis no site. Obs: Utilizar a tabela temp_tables.ibge_genders
select * from temp_tables.ibge_genders limit 10

SELECT
	ibge.gender,
	COUNT(fun.paid_date)
FROM sales.funnel AS fun
LEFT JOIN sales.customers AS cus
	ON fun.customer_id = cus.customer_id
LEFT JOIN temp_tables.ibge_genders AS ibge
	ON LOWER(cus.first_name) = ibge.first_name
GROUP BY ibge.gender;

-- (Exemplo 3) Identifique de quais regiões são os clientes que mais visitam o site
-- Obs: Utilizar a tabela temp_tables.regions
select * from sales.customers limit 10
select * from temp_tables.regions limit 10

SELECT 
	reg.region,
	COUNT(fun.visit_page_date) AS visitas
FROM sales.funnel AS fun
LEFT JOIN sales.customers AS cus
	ON fun.customer_id = cus.customer_id
LEFT JOIN temp_tables.regions AS reg
	ON LOWER(cus.city) = LOWER(reg.city)
	AND LOWER(cus.state) = LOWER(reg.state)
GROUP BY reg.region
ORDER BY visitas DESC;

-- EXERCÍCIOS ########################################################################

-- (Exercício 1) Identifique quais as marcas de veículo mais visitada na tabela sales.funnel

SELECT * FROM sales.funnel;
SELECT * FROM sales.products;

SELECT 
	pr.brand,
	COUNT(*) AS visits
FROM sales.funnel AS fn
JOIN sales.products AS pr
	ON fn.product_id = pr.product_id
GROUP BY pr.brand
ORDER BY visits DESC;

-- (Exercício 2) Identifique quais as lojas de veículo mais visitadas na tabela sales.funnel

SELECT * FROM sales.stores;
SELECT * FROM sales.funnel;

SELECT 
	st.store_name,
	COUNT(*) as visits
FROM sales.funnel AS fn
JOIN sales.stores AS st
	ON fn.store_id = st.store_id
GROUP BY st.store_name
ORDER BY visits DESC;


-- (Exercício 3) Identifique quantos clientes moram em cada tamanho de cidade (o porte da cidade
-- consta na coluna "size" da tabela temp_tables.regions)

SELECT * FROM temp_tables.regions;

SELECT 
	rg.size,
	COUNT(*) AS clients
FROM sales.customers AS cs
JOIN temp_tables.regions AS rg
	ON LOWER(cs.city) = LOWER(rg.city)
	AND LOWER(cs.state) = LOWER(rg.state)
GROUP BY rg.size
ORDER BY clients DESC;








	