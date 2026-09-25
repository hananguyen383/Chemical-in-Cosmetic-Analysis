-- Explore All Category
SELECT
	COUNT(DISTINCT(ProductName)) AS TotalProduct,
	COUNT(DISTINCT(ChemicalName)) AS TotalChemical
FROM cscpopendata1

-- Explore Subcategories
SELECT DISTINCT PrimaryCategory, SubCategory FROM cscpopendata1

-- Percent of products most used
;WITH ProductCounts AS (
    SELECT
        ProductName,
        COUNT(ProductName) AS QuantityofProduct
    FROM cscpopendata1
    GROUP BY ProductName
),
ProductPercentages AS (
    SELECT DISTINCT
        ProductName,
        QuantityofProduct,
        SUM(QuantityofProduct) OVER () AS SumofProduct
    FROM ProductCounts
)
SELECT TOP 3
    ProductName,
    QuantityofProduct,
    SumofProduct,
    ROUND(QuantityofProduct * 100.0 / SumofProduct, 2) AS Percentofmostusedproducts
FROM ProductPercentages
ORDER BY QuantityofProduct DESC;

--Table of chemical's name
SELECT TOP 10
	ChemicalName,
	COUNT(ChemicalName) AS CountofChemical
FROM cscpopendata1
GROUP BY ChemicalName
ORDER BY CountofChemical DESC

