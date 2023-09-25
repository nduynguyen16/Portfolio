--Using the Table of size standards dataset from Table of size standards (sba.gov) to cleaning data


--First glance at Table of size standards  Dataset
SELECT * 
FROM Sba_industry_standard


-- Select all data we need to use for creating a new table
SELECT 
    [NAICS _Codes], 
    [NAICS _Industry _Description]
FROM Sba_industry_standard 
WHERE [NAICS _Codes] =' ' -- this is a filter to remove all outliers because every Row in the NAICS_Industry_Description column also has a blank in the NAICS_Codes column


-- Create a new LookupCodes column from the NAICS_Industry_Description column
SELECT 
    [NAICS _Industry _Description],
    SUBSTRING([NAICS _Industry _Description],8,2) 
FROM Sba_industry_standard 
WHERE [NAICS _Codes] =' '


--Create a new Sectors column from NAICS_Industry_Description column
SELECT 
    [NAICS _Industry _Description],
    SUBSTRING([NAICS _Industry _Description],8,2) AS LookupCocdes,
    SUBSTRING([NAICS _Industry _Description],CHARINDEX('–',[NAICS _Industry _Description]) +1,LEN(([NAICS _Industry _Description]))) AS Sectors
FROM Sba_industry_standard 
WHERE [NAICS _Codes] =' '


-- Remove Space before a new string in the Sectors column
SELECT 
    [NAICS _Industry _Description],
    SUBSTRING([NAICS _Industry _Description],8,2) AS LookupCocdes,
    ltrim(SUBSTRING([NAICS _Industry _Description],CHARINDEX('–',[NAICS _Industry _Description]) +1,LEN(([NAICS _Industry _Description])))) AS Sectors
--use ltrim() function because space on the left side of the string
FROM Sba_industry_standard 
WHERE [NAICS _Codes] =' '


--Remove all NA values and outliers values in the LookupCodes column AND create a new table (sba_NAICS_Codes_Sectors)
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



--First Glance at a new table (sba_NAICS_codes_sectors) has been created
SELECT *
FROM sba_NAICS_codes_sectors



-- We realize some missing codes are 32, 43, and 49 in LookupCodes Column
--Insert missing values into a new table (sba_NAICS_codes_sectors)
INSERT INTO sba_NAICS_codes_sectors
VALUES  ('Sector 31 – 33 – Manufacturing',32,'Manufacturing'),
        ('Sector 44 - 45 – Retail Trade',43,'Retail Trade'),
        ('Sector 48 - 49 – Transportation and Warehousing',49,'Transportation and Warehousing')




--We realize in a sectors column has an error string ( "33-Manufacturing")
--Fix  an error string ( "33-Manufacturing") by using UPDATE function
UPDATE sba_NAICS_codes_sectors
SET Sectors ='Manufacturing'
WHERE [NAICS _Industry _Description] = 'Sector 31 – 33 – Manufacturing'



-- Select all data from a complete table have just been created
SELECT *
FROM sba_NAICS_codes_sectors
ORDER BY LookupCocdes
-- This is a complete goal table that we need to create, it contains 3 columns (NAICS_Industry_Description, LookupCodes, Sectors)
