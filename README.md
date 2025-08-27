# SQL – Agrégatation de datas

Ce dépôt regroupe plusieurs exercices réalisés dans le cadre d’une montée en compétence en SQL.  
Chaque partie correspond à une compétence ou une notion particulière, et contient les fichiers SQL et jeux de données associés.

## Partie 1 – Requêtes SQL de base (inventaire)

Objectif : ce projet illustre comment explorer, nettoyer et enrichir une table de stock afin de créer des identifiants produits uniques, classifier les modèles, et calculer des indicateurs clés (rupture, valeur de stock).

Fichiers :
- `1-requete-data-management-de-linventaire.sql` : requêtes permettant de passer d’une table brute de stock à une table enrichie exploitable pour l’analyse.
- `1-stock_analysis.csv` : dataset brute de stock contenant les colonnes modèle, couleur, taille, prix et niveaux de stock.

## Partie 2 – Transformation & indicateurs (inventory_stats)

Objectif : enrichir les données prêtes de la Partie 1 pour produire des indicateurs métiers (disponibilité, valeur de stock), catégoriser les modèles et préparer les agrégations.

Fichiers :
- `2-inventory_stats.sql` : requêtes permettant de passer d’une table brute de stock à une table enrichie exploitable pour l’analyse.
- `2-inventory_stats.csv` : dataset brute de stock contenant les colonnes modèle, couleur, taille, prix et niveaux de stock.

## Partie 3 – Analyse logistique des expéditions

Objectif : analyser et enrichir des données d’expédition pour calculer des statuts, délais et indicateurs logistiques clés.

Fichiers :
- `3-shipments_analysis.sql` : requêtes SQL pour transformer les données brutes en tables enrichies (statuts, délais, KPIs).
- `3-shipments.csv`, `3-shipments_products.csv` : datasets
  
## Partie 4 – Analyse du funnel commercial

Objectif : analyser et enrichir des données du funnel commercial afin de suivre les étapes de conversion (leads → opportunités → clients), calculer les taux de conversion et les délais moyens.

Fichiers :
- `4-sales_funnel_analysis.sql` : requêtes SQL pour explorer et enrichir les données du funnel (stages, taux, délais).
- `4-sales_funnel.csv` : dataset brut du funnel commercial.

## Partie 5 – Analyse des ventes

Objectif : analyser les ventes (commandes, clients, produits) afin de calculer des agrégats clés par catégorie et sous-catégorie, et d’identifier les segments générateurs de chiffre d’affaires.

Fichiers :
- `5-sales_analysis.sql` : requêtes SQL permettant d’explorer les ventes, calculer des KPIs (commandes, clients, CA, coûts, quantités) et analyser les catégories de produits.
- `5-sales_sample.csv` : échantillon de 2 000 lignes extrait du dataset complet afin de rester compatible avec GitHub.

⚠️ Le dataset complet (~50 Mo) n’est pas versionné pour des raisons de taille. Cet échantillon est fourni pour la démonstration, mais toutes les requêtes du script SQL sont applicables à l’intégralité du jeu de données.
