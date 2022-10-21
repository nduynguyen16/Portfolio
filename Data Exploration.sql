
--Select all new COVID Data 
SELECT * 
FROM CovidData
ORDER BY date DESC

								---VIETNAM---
--Select all Covid Data in Vietnam that we going to be using in Vietnam
SELECT 
	Location, 
	date, 
	total_cases, 
	new_cases, 
	total_deaths, 
	new_deaths, 
	population
FROM CovidData
WHERE Location = 'Vietnam'
							
--Looking at  Total cases and Total deaths in Vietnam 
-- Show how many percentage of total cases are death   
SELECT 
	Location, 
	date, 
	total_cases, 
	total_deaths , 
	ROUND((total_deaths/total_cases)*100,2) AS Deaths_percentage
FROM CovidData
WHERE Location = 'Vietnam'
ORDER BY Deaths_percentage DESC


--Looking at total cases and total population in Vietnam
--show how many percentage of total population got covid 
SELECT 
	Location, 
	date, 
	total_cases, 
	population , 
	ROUND((total_cases/population)*100,2) AS Cases_percentage
FROM CovidData
WHERE Location = 'Vietnam'
ORDER BY Cases_percentage DESC

--looking at vaccination status in Vietnam
SELECT
	Location,
	Year(date) AS Year,
	MAX(total_vaccinations) AS total_Vaccinations,
	MAX(people_fully_vaccinated) AS total_peopleFullyVaccinated,
	ROUND(MAX((people_fully_vaccinated/population)),2) AS PeopleFullyVaccinated_Percentage
FROM CovidData
WHERE location ='Vietnam'
GROUP BY 
	Location,
	Year(date) 
ORDER BY 5 DESC





									--- SOUTHEAST ASIA ---
--Looking at countries with highest Infection Rate Compared to Population in Southeast Asia
SELECT 
	Location, 
	population,  
	MAX(total_cases) AS HighestInfection, 
	ROUND(MAX((total_cases/population)*100),2) AS populationInfection_percentage
FROM CovidData
WHERE location IN(  'Thailand','Vietnam', 
					'Cambodia','Myanmar',
					'Laos','singapore',
					'Brunei','timor',
					'philippines','Indonesia',
					'Malaysia')
GROUP BY Location, population
ORDER BY 4 DESC

--Showing countries with Highest Deaths Rate per per Population in Southeast Asia
SELECT 
	Location, 
	population,  
	MAX(Cast(total_deaths as int)) AS HighestDeaths, 
	ROUND(MAX(total_Deaths/population)*100,3) AS populationDeaths_percentage
FROM CovidData
WHERE location IN(  'Thailand','Vietnam', 
					'Cambodia','Myanmar',
					'Laos','singapore',
					'Brunei','timor',
					'philippines','Indonesia',
					'Malaysia')
GROUP BY Location, population
ORDER BY 4 DESC

--looking at vaccination status in Southeast Asia
SELECT
	Location,
	Year(date) AS Year,
	MAX(total_vaccinations) AS total_Vaccinations,
	MAX(people_fully_vaccinated) AS total_peopleFullyVaccinated,
	ROUND(MAX((people_fully_vaccinated/population)),2) AS PeopleFullyVaccinated_Percentage
FROM CovidData
WHERE location IN(  'Thailand','Vietnam', 
					'Cambodia','Myanmar',
					'Laos','singapore',
					'Brunei','timor',
					'philippines','Indonesia',
					'Malaysia')
GROUP BY 
	Location,
	Year(date) 
ORDER BY 1, 2 DESC





