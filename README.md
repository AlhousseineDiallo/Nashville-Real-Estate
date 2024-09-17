![pr3_03ED31A61F4BB0B6A5D0](https://github.com/user-attachments/assets/b9f76bd9-1d4a-4c4b-a8d2-88a53da84e4d)

# Nettoyage et Préparation des Données de l'Ensemble de Données NashvilleHousing


### Structure du Répertoire
Le projet est structuré comme suit :

- **README.md** : Ce fichier fournit une vue d'ensemble sur la structure du repo, sur la documentation technique du projet et un Reporting.

- **src/** : Ce dossier contient le code source, les datasets et les fichiers liés à l'analyse.
  - **data/** : Ce sous-dossier contient les fichiers de données.
    - **data** : Contient un lien pour télécharger les données utilisées pour le projet.
  - **main/** : Contient les codes sql utilisés pour l'analyse exploratoire et le prétraitement des données.


## Contexte
Ce projet a pour but de nettoyer et préparer les données de l'ensemble de données `NashvilleHousing` pour une analyse ultérieure. Les opérations effectuées incluent la normalisation des formats de date, la gestion des valeurs manquantes, la décomposition des adresses en colonnes individuelles, et la modification de certaines valeurs de champ pour une meilleure cohérence. Le nettoyage des données est crucial pour assurer l'exactitude des analyses et des modèles qui seront appliqués par la suite.

 
### 1. Standardisation du Format de Date
- **Objectif :** Uniformiser le format des dates dans la colonne `SaleDate`.
- **Opérations Réalisées :**
  - Conversion des dates au format standard (YYYY-MM-DD).
  - Mise à jour des valeurs de la colonne `SaleDate` avec le nouveau format.

### 2. Remplissage des Valeurs Nulles pour les Adresses
- **Objectif :** Compléter les adresses manquantes dans la colonne `PropertyAddress`.
- **Opérations Réalisées :**
  - Identification des enregistrements avec des adresses manquantes.
  - Remplissage des valeurs nulles en utilisant les adresses associées au même `ParcelID`.

### 3. Décomposition des Adresses
- **Objectif :** Décomposer les adresses complètes en colonnes séparées pour l'adresse, la ville et l'état.
- **Opérations Réalisées :**
  - Création de nouvelles colonnes `propertyaddress` (adresse), `property_city` (ville) et `property_state` (état).
  - Mise à jour de ces colonnes avec les parties respectives extraites de la colonne `PropertyAddress`.

### 4. Traitement des Adresses des Propriétaires
- **Objectif :** Décomposer les adresses des propriétaires en colonnes individuelles pour l'adresse, la ville et l'état.
- **Opérations Réalisées :**
  - Création des colonnes `owner_address`, `owner_city`, et `owner_state`.
  - Extraction et mise à jour des nouvelles colonnes avec les informations respectives de la colonne `OwnerAddress`.

### 5. Normalisation des Valeurs de Champ
- **Objectif :** Standardiser les valeurs de la colonne `SoldAsVacant` de 'Y' et 'N' en 'Yes' et 'No'.
- **Opérations Réalisées :**
  - Remplacement des valeurs 'Y' par 'Yes' et 'N' par 'No'.

### 6. Suppression des Doublons
- **Objectif :** Identifier et supprimer les doublons dans la table.
- **Opérations Réalisées :**
  - Utilisation d'une Common Table Expression (CTE) pour détecter les doublons basés sur des colonnes clés.
  - Suppression des lignes en double en gardant une seule occurrence.

### 7. Nettoyage des Colonnes Inutiles
- **Objectif :** Supprimer les colonnes non nécessaires pour simplifier la structure des données.
- **Opérations Réalisées :**
  - Suppression des colonnes `OwnerAddress`, `TaxDistrict`, `PropertyAddress`, et `property_city`.

### 8. Renommage de Colonnes
- **Objectif :** Renommer certaines colonnes pour améliorer la lisibilité et la cohérence des noms de colonnes.
- **Opérations Réalisées :**
  - Examen des colonnes restantes pour des ajustements de noms éventuels.

## Reporting et Recommandations

### Analyse Exploratoire

Après avoir nettoyé et préparé les données, nous avons effectué une analyse exploratoire pour comprendre les tendances et les caractéristiques des données. Voici les principales observations :

1. **Distribution des Dates de Vente :**
   - La majorité des ventes se concentrent autour des années 2010. Une concentration accrue des ventes pourrait être observée dans des années spécifiques, ce qui pourrait indiquer des périodes de marché actif.

2. **Propriétés avec Adresses Manquantes :**
   - Les valeurs d'adresse ont été complétées avec succès pour les enregistrements précédemment manquants. Cela a permis de remplir les lacunes et d'améliorer la qualité des données.

3. **Décomposition des Adresses :**
   - Les adresses ont été correctement décomposées en colonnes distinctes pour l'adresse, la ville et l'état. Cette décomposition facilite des analyses géographiques plus détaillées.

4. **Adresses des Propriétaires :**
   - Les adresses des propriétaires ont également été décomposées, ce qui permet une meilleure gestion des informations de contact et une analyse plus fine des propriétés détenues.

5. **Normalisation des Champs :**
   - La normalisation des valeurs dans la colonne `SoldAsVacant` a amélioré la cohérence des données, facilitant les analyses ultérieures.

6. **Gestion des Doublons :**
   - Les doublons ont été identifiés et supprimés, garantissant que chaque enregistrement est unique et précis, ce qui améliore la fiabilité des analyses.

7. **Colonnes Inutiles :**
   - Les colonnes non nécessaires ont été supprimées, simplifiant ainsi la structure de la table et réduisant le bruit dans les données.

### Recommandations

1. **Analyse des Tendances de Vente :**
   - **Exploiter les Données de Vente :** Utilisez les tendances observées dans les années de vente pour identifier des périodes de marché spécifiques et potentiellement influencer les décisions d'achat ou de vente.

2. **Examen des Adresses Décomposées :**
   - **Analyse Géographique :** Profitez des colonnes décomposées pour effectuer des analyses géographiques, telles que la distribution des ventes par ville ou état. Cela peut fournir des informations sur les zones les plus actives du marché immobilier.

3. **Validation Continue des Données :**
   - **Surveillance des Valeurs Manquantes :** Mettre en place un processus régulier pour détecter et remplir les valeurs manquantes afin de maintenir la qualité des données à long terme.

4. **Optimisation des Données :**
   - **Évaluation des Colonnes :** Réévaluer périodiquement les colonnes restantes pour garantir qu'elles répondent aux besoins analytiques actuels et futurs. Ajouter ou supprimer des colonnes selon les besoins analytiques.

5. **Amélioration des Processus de Nettoyage :**
   - **Automatisation des Tâches :** Envisagez d'automatiser les processus de nettoyage et de normalisation pour garantir une mise à jour cohérente des données en temps réel.

6. **Documentation et Formation :**
   - **Mise à Jour de la Documentation :** Maintenez une documentation détaillée des modifications de la base de données pour aider les futurs utilisateurs et analystes.
   - **Formation des Utilisateurs :** Assurez-vous que les utilisateurs comprennent les modifications apportées aux données et comment utiliser les nouvelles structures de données.
