-- 1. Exploration des tables brutes
SELECT * FROM logistics.shipments;
SELECT * FROM logistics.shipments_products;

-- 2. Vérification des clés primaires
-- Table shipments
SELECT COUNT(DISTINCT parcel_id) AS distinct_ids,
       COUNT(*) AS total_rows
FROM logistics.shipments;

-- Table shipments_products
SELECT parcel_id, model_name, COUNT(*) AS nb
FROM logistics.shipments_products
GROUP BY parcel_id, model_name
HAVING nb > 1;

-- 3. Ajout du statut des colis (livré, en transit, annulé, etc.)
SELECT
  parcel_id,
  parcel_tracking,
  transporter,
  priority,
  PARSE_DATE("%B %e, %Y", date_purchase) AS date_purchase,
  PARSE_DATE("%B %e, %Y", date_shipping) AS date_shipping,
  PARSE_DATE("%B %e, %Y", date_delivery) AS date_delivery,
  PARSE_DATE("%B %e, %Y", date_cancelled) AS date_cancelled,
  CASE
    WHEN date_cancelled IS NOT NULL THEN 'Cancelled'
    WHEN date_shipping IS NULL THEN 'In Progress'
    WHEN date_delivery IS NULL THEN 'In Transit'
    WHEN date_delivery IS NOT NULL THEN 'Delivered'
    ELSE NULL
  END AS status
FROM logistics.shipments;

-- 4. Ajout des temps d’expédition, livraison et total
SELECT
  parcel_id,
  parcel_tracking,
  transporter,
  priority,
  PARSE_DATE("%B %e, %Y", date_purchase) AS date_purchase,
  PARSE_DATE("%B %e, %Y", date_shipping) AS date_shipping,
  PARSE_DATE("%B %e, %Y", date_delivery) AS date_delivery,
  PARSE_DATE("%B %e, %Y", date_cancelled) AS date_cancelled,
  CASE
    WHEN date_cancelled IS NOT NULL THEN 'Cancelled'
    WHEN date_shipping IS NULL THEN 'In Progress'
    WHEN date_delivery IS NULL THEN 'In Transit'
    WHEN date_delivery IS NOT NULL THEN 'Delivered'
    ELSE NULL
  END AS status,
  DATE_DIFF(PARSE_DATE("%B %e, %Y", date_shipping), PARSE_DATE("%B %e, %Y", date_purchase), DAY) AS shipping_time,
  DATE_DIFF(PARSE_DATE("%B %e, %Y", date_delivery), PARSE_DATE("%B %e, %Y", date_shipping), DAY) AS delivery_time,
  DATE_DIFF(PARSE_DATE("%B %e, %Y", date_delivery), PARSE_DATE("%B %e, %Y", date_purchase), DAY) AS total_time
FROM logistics.shipments;

-- 5. Agrégation globale
SELECT
  COUNT(*) AS nb_shipments,
  ROUND(AVG(shipping_time),2) AS avg_shipping_time,
  ROUND(AVG(delivery_time),2) AS avg_delivery_time,
  ROUND(AVG(total_time),2) AS avg_total_time
FROM logistics.shipments_kpi;

-- 6. Agrégation par transporteur
SELECT
  transporter,
  COUNT(*) AS nb_shipments,
  ROUND(AVG(shipping_time),2) AS avg_shipping_time,
  ROUND(AVG(delivery_time),2) AS avg_delivery_time,
  ROUND(AVG(total_time),2) AS avg_total_time
FROM logistics.shipments_kpi
GROUP BY transporter;

-- 7. Agrégation par priorité
SELECT
  priority,
  COUNT(*) AS nb_shipments,
  ROUND(AVG(shipping_time),2) AS avg_shipping_time,
  ROUND(AVG(delivery_time),2) AS avg_delivery_time,
  ROUND(AVG(total_time),2) AS avg_total_time,
  SAFE_DIVIDE(ROUND(AVG(shipping_time),2), ROUND(AVG(total_time),2)) AS ratio_shipping_total
FROM logistics.shipments_kpi
GROUP BY priority;

-- 8. Agrégation par mois
SELECT
  EXTRACT(MONTH FROM date_purchase) AS month_purchase,
  COUNT(*) AS nb_shipments,
  ROUND(AVG(shipping_time),2) AS avg_shipping_time,
  ROUND(AVG(delivery_time),2) AS avg_delivery_time,
  ROUND(AVG(total_time),2) AS avg_total_time
FROM logistics.shipments_kpi
GROUP BY month_purchase
ORDER BY month_purchase;

-- 9. Calcul du taux de retard
SELECT
  COUNT(*) AS nb_shipments,
  ROUND(AVG(shipping_time),2) AS avg_shipping_time,
  ROUND(AVG(delivery_time),2) AS avg_delivery_time,
  ROUND(AVG(total_time),2) AS avg_total_time,
  ROUND(AVG(IF(total_time > 5, 1, 0)),2) AS delay_rate
FROM logistics.shipments_kpi;
