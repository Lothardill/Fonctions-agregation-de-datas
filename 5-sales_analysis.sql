-- 1) Sales Aggregation - Global

-- 1.1 Statistiques globales
SELECT
  COUNT(DISTINCT orders_id)   AS nb_orders,
  COUNT(DISTINCT products_id) AS nb_products,
  COUNT(DISTINCT customers_id) AS nb_customers,
  SUM(turnover)       AS sum_turnover,
  SUM(purchase_cost)  AS sum_purchase_cost,
  SUM(qty)            AS sum_qty
FROM sales_data;


-- 1.2 Statistiques par catégorie_1
SELECT
  category_1,
  COUNT(DISTINCT orders_id)   AS nb_orders,
  COUNT(DISTINCT products_id) AS nb_products,
  COUNT(DISTINCT customers_id) AS nb_customers,
  SUM(turnover)       AS sum_turnover,
  SUM(purchase_cost)  AS sum_purchase_cost,
  SUM(qty)            AS sum_qty
FROM sales_data
GROUP BY category_1;


-- 1.3 Classement des catégories par chiffre d’affaires
SELECT
  category_1,
  COUNT(DISTINCT orders_id)   AS nb_orders,
  COUNT(DISTINCT products_id) AS nb_products,
  COUNT(DISTINCT customers_id) AS nb_customers,
  SUM(turnover)       AS sum_turnover,
  SUM(purchase_cost)  AS sum_purchase_cost,
  SUM(qty)            AS sum_qty
FROM sales_data
GROUP BY category_1
ORDER BY sum_turnover DESC;

-- 2) Focus sur la catégorie "Bébé & Enfant"

-- 2.1 Identifier les sous-catégories dominantes
SELECT
  category_2,
  category_3,
  SUM(turnover) AS sum_turnover
FROM sales_data
WHERE category_1 = 'Bébé & Enfant'
GROUP BY category_2, category_3
ORDER BY sum_turnover DESC;


-- 2.2 Nombre d’ordres et de clients par sous-catégorie
SELECT
  category_2,
  category_3,
  COUNT(DISTINCT orders_id)   AS nb_orders,
  COUNT(DISTINCT customers_id) AS nb_customers
FROM sales_data
WHERE category_1 = 'Bébé & Enfant'
GROUP BY category_2, category_3;


-- 2.3. Nombre d’ordres par client
SELECT
  category_2,
  category_3,
  COUNT(DISTINCT orders_id)   AS nb_orders,
  COUNT(DISTINCT customers_id) AS nb_customers,
  COUNT(DISTINCT orders_id) / COUNT(DISTINCT customers_id) AS nb_orders_per_customer
FROM sales_data
WHERE category_1 = 'Bébé & Enfant'
GROUP BY category_2, category_3
ORDER BY nb_orders_per_customer DESC;


-- 2.4. Prix d’achat moyen et nb de produits distincts
SELECT
  category_2,
  category_3,
  COUNT(DISTINCT products_id) AS nb_products,
  AVG(purchase_cost)          AS avg_purchase_cost
FROM sales_data
WHERE category_1 = 'Bébé & Enfant'
GROUP BY category_2, category_3
ORDER BY avg_purchase_cost DESC;
