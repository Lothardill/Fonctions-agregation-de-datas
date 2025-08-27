-- 1. Exploration de la table brute
SELECT *
FROM sales.sales_acquisition_funnel;

-- 2. Vérification de la clé primaire
SELECT company, COUNT(*) AS nb
FROM sales.sales_acquisition_funnel
GROUP BY company
HAVING nb > 1
ORDER BY nb DESC;

-- 3. Ajout des colonnes de conversion et du stage du deal
SELECT
  company,
  sector,
  priority,
  date_lead,
  date_opportunity,
  date_customer,
  date_lost,
  CASE
    WHEN date_lost IS NOT NULL THEN "4 - Lost"
    WHEN date_customer IS NOT NULL THEN "3 - Customer"
    WHEN date_opportunity IS NOT NULL THEN "2 - Opportunity"
    WHEN date_lead IS NOT NULL THEN "1 - Lead"
    ELSE NULL
  END AS deal_stage,
  CASE
    WHEN date_lost IS NOT NULL THEN 0
    WHEN date_customer IS NOT NULL THEN 1
    ELSE NULL
  END AS lead2customer,
  CASE
    WHEN date_lost IS NOT NULL THEN 0
    WHEN date_opportunity IS NOT NULL THEN 1
    ELSE NULL
  END AS lead2opportunity,
  CASE
    WHEN date_lost IS NOT NULL AND date_opportunity IS NOT NULL THEN 0
    WHEN date_customer IS NOT NULL THEN 1
    ELSE NULL
  END AS opportunity2customer,
  DATE_DIFF(date_customer,date_lead,DAY) AS lead2customer_time,
  DATE_DIFF(date_opportunity,date_lead,DAY) AS lead2opportunity_time,
  DATE_DIFF(date_customer,date_opportunity,DAY) AS opportunity2customer_time
FROM sales.sales_acquisition_funnel;

-- 4. Agrégation globale
SELECT
  COUNT(*) AS prospects,
  COUNT(date_customer) AS customers,
  ROUND(AVG(lead2customer)*100,1) AS lead2customer_rate,
  ROUND(AVG(lead2opportunity)*100,1) AS lead2opportunity_rate,
  ROUND(AVG(opportunity2customer)*100,1) AS opportunity2customer_rate,
  ROUND(AVG(lead2customer_time),2) AS lead2customer_time,
  ROUND(AVG(lead2opportunity_time),2) AS lead2opportunity_time,
  ROUND(AVG(opportunity2customer_time),2) AS opportunity2customer_time
FROM sales.sales_acquisition_funnel_kpi;

-- 5. Agrégation par priorité
SELECT
  priority,
  COUNT(*) AS prospects,
  COUNT(date_customer) AS customers,
  ROUND(AVG(lead2customer)*100,1) AS lead2customer_rate,
  ROUND(AVG(lead2opportunity)*100,1) AS lead2opportunity_rate,
  ROUND(AVG(opportunity2customer)*100,1) AS opportunity2customer_rate,
  ROUND(AVG(lead2customer_time),2) AS lead2customer_time,
  ROUND(AVG(lead2opportunity_time),2) AS lead2opportunity_time,
  ROUND(AVG(opportunity2customer_time),2) AS opportunity2customer_time
FROM sales.sales_acquisition_funnel_kpi
GROUP BY priority;

-- 6. Agrégation par mois
SELECT
  EXTRACT(MONTH FROM date_lead) AS month_lead,
  COUNT(*) AS prospects,
  COUNT(date_customer) AS customers,
  ROUND(AVG(lead2customer)*100,1) AS lead2customer_rate,
  ROUND(AVG(lead2opportunity)*100,1) AS lead2opportunity_rate,
  ROUND(AVG(opportunity2customer)*100,1) AS opportunity2customer_rate,
  ROUND(AVG(lead2customer_time),2) AS lead2customer_time,
  ROUND(AVG(lead2opportunity_time),2) AS lead2opportunity_time,
  ROUND(AVG(opportunity2customer_time),2) AS opportunity2customer_time
FROM sales.sales_acquisition_funnel_kpi
GROUP BY month_lead
ORDER BY month_lead;
