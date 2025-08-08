SELECT a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress,ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM NH a 
JOIN NH b 
ON  a.ParcelID= b.ParcelID
AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL


Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From NH a
JOIN NH b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null





SELECT PropertyAddress
FROM NH


SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

From NH


ALTER TABLE NH
Add PropertySplitAddress Nvarchar(255);

Update NH
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )

ALTER TABLE NH
Add PropertySplitCity Nvarchar(255);

Update NH
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))


SELECT * 
FROM NH


SELECT OwnerAddress
FROM NH



SELECT OwnerAddress
FROM NH

Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From NH

ALTER TABLE NH 
ADD OwnerSplitAddress NVARCHAR(255);

UPDATE NH 
SET OwnerSplitAddress= PARSENAME(REPLACE(OwnerAddress,',','.'),3)

ALTER TABLE NH 
ADD OwnerSplitState NVARCHAR(255);

UPDATE NH 
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'),1)

SELECT * 
FROM NH



-- Change Y and N to Yes and No in "Sold as Vacant" field

SELECT DISTINCT (SoldAsVacant),COUNT(SoldAsVacant)
FROM NH
GROUP BY SoldAsVacant
ORDER BY 2

SELECT SoldAsVacant,
CASE WHEN SoldAsVacant = '1' THEN 'Y'
when SoldAsVacant = '0' THEN 'N'
else SoldAsVacant
END  
FROM NH

Update NH
SET SoldAsVacant = CASE When SoldAsVacant = '1' THEN 'Y'
	   When SoldAsVacant = '0' THEN 'N'
	   ELSE SoldAsVacant
	   END

-- remove Duplicates

WITH RowNumCTE AS(SELECT *,
ROW_NUMBER() OVER(
    PARTITION BY ParcelID,
    PropertyAddress,
    SalePrice,
    SaleDate,
    LegalReference
    ORDER BY 
    UniqueID
) row_num
FROM NH 
)
SELECT * 
FROM RowNumCTE
WHERE row_num > 1
ORDER by PropertyAddress

Select * 
FROM NH


--DELETE UNUSED COLUMNS

SELECT * 
FROM NH

ALTER TABLE NH 
DROP COLUMN OwnerAddress,TaxDistrict, PropertyAddress, SaleDate





