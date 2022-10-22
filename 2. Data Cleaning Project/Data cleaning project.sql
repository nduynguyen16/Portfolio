
--first glance at Sba_industry_standard Dataset
SELECT * 
FROM Sba_industry_standard
-- Objectives
-- for purpose analysis we just need sector in NAICS_Industry_Decription Row
-- we create a new Standard table contain to 3 colums NAICS_Industry_Depription, Lookupcodes, and sectors column

-- Select all data we need to use 
SELECT 
    [NAICS _Codes], 
    [NAICS _Industry _Description]
FROM Sba_industry_standard 
WHERE [NAICS _Codes] =' ' -- this is filter to remove all outliers because every Row in NAICS_Industry_Description also have blank in NAICS_Codes

-- create new lookupCodes column 
SELECT 
    [NAICS _Industry _Description],
    SUBSTRING([NAICS _Industry _Description],8,2) 
FROM Sba_industry_standard 
WHERE [NAICS _Codes] =' '

--create new Sectors column
SELECT 
    [NAICS _Industry _Description],
    SUBSTRING([NAICS _Industry _Description],8,2) AS LookupCocdes,
    SUBSTRING([NAICS _Industry _Description],CHARINDEX('–',[NAICS _Industry _Description]) +1,LEN(([NAICS _Industry _Description]))) AS Sectors
FROM Sba_industry_standard 
WHERE [NAICS _Codes] =' '

-- Remove Space before String in Sectors column 
-- use ltrim() function because the space in the left side of string
SELECT 
    [NAICS _Industry _Description],
    SUBSTRING([NAICS _Industry _Description],8,2) AS LookupCocdes,
    ltrim(SUBSTRING([NAICS _Industry _Description],CHARINDEX('–',[NAICS _Industry _Description]) +1,LEN(([NAICS _Industry _Description])))) AS Sectors
FROM Sba_industry_standard 
WHERE [NAICS _Codes] =' '

--Remove all NA values and outliers Values in LookupCodes AND Create a new table (sba_NAICS_codes_sectors)
SELECT*
INTO sba_NAICS_codes_sectors
FROM 
(

SELECT 
    [NAICS _Industry _Description],
    SUBSTRING([NAICS _Industry _Description],8,2) AS LookupCocdes,
    ltrim(SUBSTRING([NAICS _Industry _Description],CHARINDEX('–',[NAICS _Industry _Description]) +1,LEN(([NAICS _Industry _Description])))) AS Sectors
FROM Sba_industry_standard 
WHERE [NAICS _Codes] =' '

) AS temp_table
WHERE LookupCocdes != 'NA' AND LookupCocdes != 'bu'


--Select all data from the new table (sba_NAICS_codes_sectors) have just been created 
SELECT *
FROM sba_NAICS_codes_sectors

-- We realize some missing codes those are 32, 43,47 in lookupCodes column
-- Insert new code values in sba_NAICS_codes_sectors table

INSERT INTO sba_NAICS_codes_sectors
VALUES  ('Sector 31 – 33 – Manufacturing',32,'Manufacturing'),
        ('Sector 44 - 45 – Retail Trade',43,'Retail Trade'),
        ('Sector 48 - 49 – Transportation and Warehousing',49,'Transportation and Warehousing')


--We realize in Sectors columns have an error string (33 – Manufacturing)
--fix an error string (33 – Manufacturing)

UPDATE sba_NAICS_codes_sectors
SET Sectors ='Manufacturing'
WHERE [NAICS _Industry _Description] = 'Sector 31 – 33 – Manufacturing'


-- SELECT all data in a new table (sba_NAICS_codes_sectors) we just have cleaned completely
SELECT *
FROM sba_NAICS_codes_sectors
ORDER BY LookupCocdes
