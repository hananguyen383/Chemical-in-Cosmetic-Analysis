-- Find the significant date
SELECT
    MAX(DiscontinuedDate) AS RecentDiscontinuedDate,
    MIN(Chemical_Create_At) AS FirstChemicalCreateAt,
    MAX(Chemical_Create_At) AS LastChemicalCreateAt,
    MAX(Chemical_Update_at) AS RecentUpdatedChemical
FROM cscpopendata1;

-- Find the average time one product get updated or disappeared
SELECT
    DATEDIFF(MONTH, Chemical_Create_At, DiscontinuedDate) AS MonthBetweenDiscontined,
    AVG(DATEDIFF(MONTH, Chemical_Create_At, DiscontinuedDate))
        OVER () AS AvgMonthBetweenCreateAndDiscontinue,
    DATEDIFF(MONTH, Chemical_Create_At, Chemical_Update_at) AS MonthBetweenUpdated,
    AVG(DATEDIFF(MONTH, Chemical_Create_At, Chemical_Update_at))
        OVER () AS AvgMonthBetweenCreateAndUpdate
FROM cscpopendata1
WHERE DiscontinuedDate IS NOT NULL
  AND Chemical_Update_at IS NOT NULL
  AND Chemical_Create_At IS NOT NULL;