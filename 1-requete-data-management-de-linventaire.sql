-- 1. Sélection de toutes les colonnes pour visualiser les tables brutes
SELECT * FROM stock_analysis;
SELECT * FROM stock_analysis;

-- 2. Vérification de la clé primaire pour circle_sales
-- Hypothèse : (date_date, product_id) est la PK
SELECT COUNT(DISTINCT CONCAT(date_date, "-", product_id)) AS distinct_ids,
       COUNT(*) AS total_rows
FROM stock_analysis;
-- Si identiques → clé primaire valide

-- 3. Vérification de la clé primaire pour circle_stock
-- Hypothèse : model seul n’est pas unique
SELECT model, COUNT(*) AS nb
FROM stock_analysis
GROUP BY model
HAVING nb > 1
ORDER BY nb DESC;

-- 4. Vérification de la PK composite (model, color, size)
SELECT model, color, size, COUNT(*) AS nb
FROM stock_analysis_stock
GROUP BY model, color, size
HAVING nb > 1
ORDER BY nb DESC;
-- Pas de doublons → combinaison valide

-- 5. Création d’un product_id en concaténant model, color et size
SELECT
  model,
  color,
  size,
  CONCAT(model, "_", color, "_", size) AS product_id,
  model_name,
  color_name,
  new,
  price,
  forecast_stock,
  stock
FROM stock_analysis;

-- 6. Gestion des NULL dans size → valeur par défaut 'no-size'
SELECT
  model,
  color,
  IFNULL(size, "no-size") AS size,
  CONCAT(model, "_", color, "_", IFNULL(size, "no-size")) AS product_id
FROM stock_analysis;

-- 7. Ajout d’une colonne product_name
SELECT
  CONCAT(model, "_", color, "_", IFNULL(size, "no-size")) AS product_id,
  CONCAT(model_name, " ", color_name, " - Size ", IFNULL(size, "no-size")) AS product_name,
  *
FROM stock_analysis;

-- 8. Classification des modèles par type
SELECT
  CONCAT(model, "_", color, "_", IFNULL(size, "no-size")) AS product_id,
  CASE
    WHEN REGEXP_CONTAINS(LOWER(model_name), "t-shirt") THEN "T-shirt"
    WHEN REGEXP_CONTAINS(LOWER(model_name), "short") THEN "Short"
    WHEN REGEXP_CONTAINS(LOWER(model_name), "legging") THEN "Legging"
    WHEN REGEXP_CONTAINS(REPLACE(LOWER(model_name),"è","e"), "brassiere|crop-top") THEN "Crop-top"
    WHEN REGEXP_CONTAINS(LOWER(model_name), "débardeur|haut") THEN "Top"
    WHEN REGEXP_CONTAINS(LOWER(model_name), "tour de cou|tapis|gourde") THEN "Accessories"
    ELSE NULL
  END AS model_type,
  *
FROM stock_analysis;

-- 9. Ajout d’une colonne in_stock (0/1)
SELECT
  CONCAT(model, "_", color, "_", IFNULL(size, "no-size")) AS product_id,
  IF(stock > 0, 1, 0) AS in_stock,
  *
FROM stock_analysis;

-- 10. Ajout d’une colonne stock_value
SELECT
  CONCAT(model, "_", color, "_", IFNULL(size, "no-size")) AS product_id,
  IF(stock > 0, 1, 0) AS in_stock,
  ROUND(stock * price, 2) AS stock_value,
  *
FROM stock_analysis;
