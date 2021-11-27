/****** Script for SelectTopNRows command from SSMS  ******/

SELECT
*
FROM dbo.crypto_price

SELECT
*
FROM dbo.gold_price


SELECT
*
FROM dbo.rate



WITH DATA_HISTORY AS
(
SELECT 
       [golds#date]				AS date,
       [golds#value#buy]		AS buy,
       [golds#value#sell]		AS sell,
       [loai]					AS type,
       [chinhanh]				AS brand
  FROM [GOLD_PRICE].[dbo].[gold_history]
  
  UNION ALL
 
  SELECT
 
	  date,
	  value#buy					AS buy,
	  value#sell				AS sell,
	  value#name				AS type,
	  bank						AS brand	
  FROM dbo.rate_history
  )

  SELECT
  *
  FROM DATA_HISTORY
  ORDER BY DATA_HISTORY.type,DATA_HISTORY.date



SELECT
*
FROM dbo.gold_price
