--Using Dataset about World Covid from https://ourworldindata.org/covid-deaths to Explore Covid Data in Vietnam And Southeast Asia Area


--Select all new COVID Data
SELECT * 
FROM CovidData
ORDER BY date DESC


								---VIETNAM AREA---
--Select all Covid Data in Vietnam that we going to be using
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


--Looking at The total cases and Total Deaths in Vietnam
--Show how many percent of total cases are death in Vietnam  
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
--Show how many percent of total population got covid
SELECT 
	Location, 
	date, 
	total_cases, 
	population , 
	ROUND((total_cases/population)*100,2) AS Cases_percentage
FROM CovidData
WHERE Location = 'Vietnam'
ORDER BY Cases_percentage DESC

--Looking at Vaccination Status in Vietnam
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

--Looking at countries with the highest infection rate compared to the population per country in Southeast Asia area
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



--Showing Countries with the highest deaths rate per population in Southeast Asia area
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

--Looking at Vaccination Status in Southeast Asia area
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





