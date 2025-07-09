-- SELECT

SELECT email
FROM sales.customers;

SELECT email, first_name, last_name
FROM sales.customers;

SELECT *
FROM sales.customers;

-- DISTINCT

SELECT brand
FROM sales.products;

SELECT DISTINCT brand
FROM sales.products;


SELECT DISTINCT brand, model_year
FROM sales.products;

-- WHERE

SELECT email, state
FROM sales.customers
WHERE state = 'SC';

SELECT email, state
FROM sales.customers
WHERE state = 'SC' or state = 'MS';

SELECT email, state, birth_date
FROM sales.customers
WHERE (state = 'SC' or state = 'MS') and birth_date < '1995-07-06';

-- ORDER BY

SELECT *
FROM sales.products
ORDER BY price;

SELECT DISTINCT state
FROM sales.customers
ORDER BY STATE;

-- LIMIT

SELECT *
FROM sales.funnel
LIMIT 10;

SELECT *
FROM sales.products
ORDER BY price DESC
LIMIT 10;

-- EXERCÍCIOS ######################################################################

-- (Exercício 1) Selecione os nomes de cidade distintas que existem no estado de
-- Minas Gerais em ordem alfabética (dados da tabela sales.customers)

SELECT DISTINCT city
FROM sales.customers
WHERE state = 'MG'
ORDER BY city;

-- (Exercício 2) Selecione o visit_id das 10 compras mais recentes efetuadas
-- (dados da tabela sales.funnel)

SELECT visit_id
FROM sales.funnel
WHERE paid_date IS NOT null
ORDER BY paid_date DESC
LIMIT 10;

-- (Exercício 3) Selecione todos os dados dos 10 clientes com maior score nascidos
-- após 01/01/2000 (dados da tabela sales.customers)

SELECT *
FROM sales.customers
ORDER BY score DESC
LIMIT 10;
