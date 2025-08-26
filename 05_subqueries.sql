-- PARA QUE SERVE ##################################################################
-- Servem para consultar dados de outras consultas.


-- TIPOS ###########################################################################
-- Subquery no WHERE
-- Subquery com WITH
-- Subquery no FROM
-- Subquery no SELECT


-- EXEMPLOS ########################################################################

-- (Exemplo 1) Subquery no WHERE
-- Informe qual é o veículo mais barato da tabela products

SELECT *
FROM sales.products
WHERE price = (SELECT MIN(price) FROM sales.products);

-- (Exemplo 2) Subquery com WITH
-- Calcule a idade média dos clientes por status profissional

WITH alguma_tabela AS (
	SELECT
		professional_status,
		(current_date - birth_date)/365 AS idade
	FROM sales.customers
)
SELECT
	professional_status,
	AVG(idade) AS idade_media
FROM alguma_tabela
GROUP BY professional_status;

-- (Exemplo 3) Subquery no FROM
-- Calcule a média de idades dos clientes por status profissional

SELECT
	professional_status,
	AVG(idade) AS idade_media
FROM (
		SELECT
			professional_status,
			(current_date - birth_date)/365 AS idade
		FROM sales.customers
	) AS alguma_tabela
GROUP BY professional_status;

-- (Exemplo 4) Subquery no SELECT
-- Na tabela sales.funnel crie uma coluna que informe o nº de visitas acumuladas 
-- que a loja visitada recebeu até o momento

SELECT
	fun.visit_id,
	fun.visit_page_date,
	sto.store_name,
	(
		SELECT COUNT(*)
		FROM sales.funnel AS fun2
		WHERE fun2.visit_page_date <= fun.visit_page_date
			AND fun2.store_id = fun.store_id
	)
FROM sales.funnel AS fun
LEFT JOIN sales.stores AS sto
	ON fun.store_id = sto.store_id
ORDER BY sto.store_name, fun.visit_page_date;

-- RESUMO ##########################################################################
-- (1) Servem para consultar dados de outras consultas.
-- (2) Para que as subqueries no WHERE e no SELECT funcionem, elas devem retornar 
-- apenas um único valor
-- (3) Não é recomendado utilizar subqueries diretamente dentro do FROM pois isso 
-- dificulta a legibilidade da query. 


-- EXEMPLOS ########################################################################

-- (Exemplo 1) Análise de recorrência dos leads
-- Calcule o volume de visitas por dia ao site separado por 1ª visita e demais visitas

WITH primeira_visita AS (
	SELECT customer_id, min(visit_page_date) as visita_1
	FROM sales.funnel
	GROUP BY customer_id
)
SELECT
	fun.visit_page_date,
	(fun.visit_page_date <> primeira_visita.visita_1) AS lead_recorrente,
	COUNT(*)
FROM sales.funnel AS fun
LEFT JOIN primeira_visita
	ON fun.customer_id = primeira_visita.customer_id
GROUP BY fun.visit_page_date, lead_recorrente
ORDER BY fun.visit_page_date DESC, lead_recorrente;

-- (Exemplo 2) Análise do preço versus o preço médio
-- Calcule, para cada visita ao site, quanto o preço do um veículo visitado pelo cliente
-- estava acima ou abaixo do preço médio dos veículos daquela marca 
-- (levar em consideração o desconto dado no veículo)

WITH preco_medio AS(
	SELECT brand, AVG(price) as preco_medio_da_marca
	FROM sales.products
	GROUP BY brand
)
SELECT
	fun.visit_id,
	fun.visit_page_date,
	pro.brand,
	(pro.price - (1+fun.discount)) AS preco_final,
	preco_medio.preco_medio_da_marca,
	((pro.price - (1+fun.discount)) - preco_medio.preco_medio_da_marca) AS preco_vs_media
FROM sales.funnel AS fun
LEFT JOIN sales.products as pro
	ON fun.product_id = pro.product_id
LEFT JOIN preco_medio
	ON pro.brand = preco_medio.brand;

-- EXERCÍCIOS ########################################################################

-- (Exercício 1) Crie uma coluna calculada com o número de visitas realizadas por cada
-- cliente da tabela sales.customers

WITH numero_de_visitas AS (
	SELECT customer_id, COUNT(*) AS n_visitas
	FROM sales.funnel
	GROUP BY customer_id
)
SELECT
	cus.*,
	n_visitas

FROM sales.customers AS cus
LEFT JOIN numero_de_visitas AS ndv
	ON cus.customer_id = ndv.customer_id;



