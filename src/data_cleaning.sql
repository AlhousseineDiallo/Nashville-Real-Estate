/* 

Cleaning the data in SQL

*/

SELECT *
FROM PortfolioProject1.dbo.NashvilleHousing;

-- Standardize Date Format

SELECT SaleDate
FROM PortfolioProject1.dbo.NashvilleHousing;


SELECT SaleDate, CONVERT(Date, SaleDate, 120)
FROM PortfolioProject1.dbo.NashvilleHousing;

UPDATE PortfolioProject1.dbo.NashvilleHousing
SET SaleDate = CONVERT(Date, SaleDate, 120);

ALTER TABLE PortfolioProject1.dbo.NashvilleHousing
ALTER COLUMN saledate Date;

SELECT *
FROM PortfolioProject1.dbo.NashvilleHousing;


-- Populate property address data


SELECT PropertyAddress
FROM PortfolioProject1.dbo.NashvilleHousing
WHERE PropertyAddress IS NULL;


SELECT *
FROM PortfolioProject1.dbo.NashvilleHousing
WHERE PropertyAddress IS NULL;

SELECT *
FROM PortfolioProject1.dbo.NashvilleHousing
--WHERE PropertyAddress IS NULL
ORDER BY ParcelID;

/*
Now we want to fill the null values of the PropertyAddress
*/

-- First we detect the Property address which have the same ParcelID and we'll use it to fill the null values

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject1.dbo.NashvilleHousing AS a
INNER JOIN PortfolioProject1.dbo.NashvilleHousing AS b
	ON a.ParcelID = b.ParcelID
	  AND a.UniqueID != b.UniqueID 
WHERE a.PropertyAddress IS NULL;

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject1.dbo.NashvilleHousing AS a
INNER JOIN PortfolioProject1.dbo.NashvilleHousing AS b
	ON a.ParcelID = b.ParcelID
	  AND a.UniqueID != b.UniqueID 
WHERE a.PropertyAddress IS NULL;

-- Breaking out Address into Individual columns (Address, City, State)

SELECT PropertyAddress
FROM PortfolioProject1.dbo.NashvilleHousing;


SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) AS address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) AS city
FROM PortfolioProject1.dbo.NashvilleHousing;


ALTER TABLE PortfolioProject1.dbo.NashvilleHousing
ADD propertyaddress Nvarchar(255);

UPDATE PortfolioProject1.dbo.NashvilleHousing
SET propertyaddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1);



ALTER TABLE PortfolioProject1.dbo.NashvilleHousing
ADD property_city Nvarchar(255);

UPDATE PortfolioProject1.dbo.NashvilleHousing
SET property_city = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) 


SELECT *
FROM PortfolioProject1.dbo.NashvilleHousing;


-- 



SELECT OwnerAddress
FROM PortfolioProject1.dbo.NashvilleHousing;


SELECT 
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
FROM PortfolioProject1.dbo.NashvilleHousing;


ALTER TABLE PortfolioProject1.dbo.NashvilleHousing
ADD owner_address Nvarchar(255);

UPDATE PortfolioProject1.dbo.NashvilleHousing
SET owner_address = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) ;



ALTER TABLE PortfolioProject1.dbo.NashvilleHousing
ADD owner_city Nvarchar(255);

UPDATE PortfolioProject1.dbo.NashvilleHousing
SET owner_city  = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2);

ALTER TABLE PortfolioProject1.dbo.NashvilleHousing
ADD owner_state Nvarchar(255);

UPDATE PortfolioProject1.dbo.NashvilleHousing
SET owner_state  = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1);

SELECT * 
FROM PortfolioProject1.dbo.NashvilleHousing;


-- Change Y and N to Yes and No in the 'Sold as vacant' field

SELECT DISTINCT(SoldAsVacant)
FROM PortfolioProject1.dbo.NashvilleHousing;


SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM PortfolioProject1.dbo.NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY 2;

SELECT SoldAsVacant,
CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	 WHEN SoldAsVacant = 'N' THEN 'No'
	 ELSE SoldAsVacant
	 END
FROM PortfolioProject1.dbo.NashvilleHousing;

UPDATE PortfolioProject1.dbo.NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	 WHEN SoldAsVacant = 'N' THEN 'No'
	 ELSE SoldAsVacant
	 END;

SELECT * 
FROM PortfolioProject1.dbo.NashvilleHousing;


-- Remove duplicates

WITH RowNumsCTE AS(
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SaleDate,
				 SalePrice,
				 LegalReference
				 ORDER BY UniqueID ) AS row_num
FROM PortfolioProject1.dbo.NashvilleHousing)

SELECT *
FROM RowNumsCTE
WHERE row_num > 1;






---------------------------------------------------------------------------------------------------------------------------------------------------
-- Delete unused columns

SELECT *
FROM PortfolioProject1.dbo.NashvilleHousing;

ALTER TABLE PortfolioProject1.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, property_city;

-- Rename some columns
SELECT *
FROM PortfolioProject1.dbo.NashvilleHousing;
 