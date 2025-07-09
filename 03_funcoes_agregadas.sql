-- Funções De Agregação

SELECT COUNT(*)
FROM sales.funnel;

SELECT *
FROM sales.funnel
limit 10;

SELECT COUNT(paid_date)
FROM sales.funnel;

SELECT COUNT(DISTINCT product_id)
FROM sales.funnel
WHERE visit_page_date BETWEEN '2021-01-01' AND '2021-01-31';

SELECT MIN(price), MAX(price), AVG(price)
FROM sales.products;

SELECT MAX(price)
FROM sales.products;

SELECT *
FROM sales.products
WHERE price = (
	SELECT MAX(price)
	FROM sales.products
);

-- GROUP BY

SELECT state, COUNT (*) as contagem
FROM sales.customers
GROUP BY state
ORDER BY contagem DESC;

SELECT state, professional_status, COUNT (*) as contagem
FROM sales.customers
GROUP BY state, professional_status
ORDER BY state, contagem DESC;

SELECT DISTINCT state
FROM sales.customers;

SELECT state
FROM sales.customers
GROUP BY state;

-- HAVING
SELECT
	state,
	COUNT(*)
FROM sales.customers
GROUP BY state
HAVING COUNT(*) > 100
	AND state <> 'MG';

-- EXERCÍCIOS ########################################################################

-- (Exercício 1) Conte quantos clientes da tabela sales.customers tem menos de 30 anos

SELECT COUNT(*)
FROM sales.customers
WHERE ((CURRENT_DATE - birth_date)/365) < 30;

-- (Exercício 2) Informe a idade do cliente mais velho e mais novo da tabela sales.customers

SELECT
	MAX((CURRENT_DATE - birth_date)/365),
	MIN((CURRENT_DATE - birth_date)/365)
FROM sales.customers;


-- (Exercício 3) Selecione todas as informações do cliente mais rico da tabela sales.customers
-- (possívelmente a resposta contém mais de um cliente)

SELECT *
FROM sales.customers
WHERE income = (
	SELECT MAX(income)
	FROM sales.customers
);


-- (Exercício 4) Conte quantos veículos de cada marca tem registrado na tabela sales.products
-- Ordene o resultado pelo nome da marca

SELECT brand, COUNT(*)
FROM sales.products
GROUP BY brand
ORDER BY brand;


-- (Exercício 5) Conte quantos veículos existem registrados na tabela sales.products
-- por marca e ano do modelo. Ordene pelo nome da marca e pelo ano do veículo

SELECT brand, model_year, COUNT(*)
FROM sales.products
GROUP BY brand, model_year
ORDER BY brand, model_year;


-- (Exercício 6) Conte quantos veículos de cada marca tem registrado na tabela sales.products
-- e mostre apenas as marcas que contém mais de 10 veículos registrados

SELECT brand, COUNT(*)
FROM sales.products
GROUP BY brand
HAVING COUNT(*) > 10;









