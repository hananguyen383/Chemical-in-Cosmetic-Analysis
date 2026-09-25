--Distribution of each chemicals
SELECT
    ChemicalName,
    COUNT(*)AS product_count,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS percent_distribution
FROM cscpopendata1
GROUP BY ChemicalName
ORDER BY product_count DESC

--Distribution of 10 most used Chemicals
WITH Chemical_counts AS (
    SELECT
        ChemicalName,
        COUNT(*) AS Chemical_count
    FROM cscpopendata1
    GROUP BY ChemicalName
),
Top10Chemical AS (
    SELECT TOP 10
        ChemicalName,
        Chemical_count
    FROM Chemical_counts
    ORDER BY Chemical_count DESC
)
SELECT
    ChemicalName,
    Chemical_count,
    ROUND(
        Chemical_count * 100.0 / SUM(Chemical_count) OVER (),
        2
    ) AS Percent_Chemical_Distribution
FROM Top10Chemical
ORDER BY Chemical_count DESC;

--Which product have most discontinued Chemical
WITH CountDiscontinuedProduct AS (
    SELECT
        ProductName,
        COUNT(*) AS CountDiscontinuedProduct
    FROM cscpopendata1
    WHERE DiscontinuedDate IS NOT NULL
    GROUP BY ProductName
)
SELECT TOP 10
    ProductName,
    CountDiscontinuedProduct
FROM CountDiscontinuedProduct
ORDER BY CountDiscontinuedProduct DESC;
----------------


--Which company had use most discontinued Chemical
WITH CompanyMostUsedDiscontinedChemical AS (
    SELECT
      CompanyName
    FROM cscpopendata1
    WHERE DiscontinuedDate IS NOT NULL)
    SELECT TOP 10
      CompanyName,
    COUNT(*) AS CompanyWithDiscontinuedChemical
    FROM CompanyMostUsedDiscontinedChemical
    GROUP BY CompanyName
    ORDER BY CompanyWithDiscontinuedChemical DESC