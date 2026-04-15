-- ============================================================
-- COVID-19 Data Exploration Project
-- Author   : Portfolio Project (inspired by Alex The Analyst)
-- Dataset  : Our World In Data – CovidDeaths & CovidVaccinations
-- Tool     : MySQL
-- Purpose  : Explore global COVID-19 trends including infections,
--            deaths, and vaccination rollouts using SQL techniques
--            such as Joins, CTEs, Temp Tables, Window Functions,
--            and Views.
-- ============================================================


-- ============================================================
-- QUERY 1: Total Deaths by Continent
-- Aggregates the maximum recorded total deaths for each
-- continent-level grouping (where continent IS NULL, the
-- location column holds the continent name).
-- ============================================================
SELECT
    coviddeaths.location,
    MAX(total_deaths) AS TotalDeathsInContinent
FROM coviddeaths
WHERE coviddeaths.continent IS NULL
GROUP BY coviddeaths.location
ORDER BY TotalDeathsInContinent;


-- ============================================================
-- QUERY 2: Temp Table – Percent Population Vaccinated
-- Creates a temporary table to store rolling vaccination totals
-- per country, then calculates the percentage of population
-- vaccinated over time.
-- ============================================================
DROP TABLE IF EXISTS PercentPopulationVaccinated;

CREATE TABLE PercentPopulationVaccinated (
    Location          NVARCHAR(255),
    Date              DATETIME,
    Population        NUMERIC,
    NewVaccination    NUMERIC,
    PeopleVaccinatedRolling NUMERIC
);

INSERT INTO PercentPopulationVaccinated
SELECT
    cde.location,
    cde.`date`,
    cde.population,
    cvc.new_vaccinations,
    -- Rolling sum of new vaccinations, restarting for each country
    SUM(cvc.new_vaccinations) OVER (
        PARTITION BY cde.location
        ORDER BY cde.`date`
    ) AS PeopleVaccinatedRolling
FROM coviddeaths AS cde
JOIN covidvaccinations AS cvc
    ON cde.location = cvc.location
    AND cde.`date`  = cvc.`date`
WHERE cde.continent IS NOT NULL;

-- View temp table results with vaccination percentage
SELECT
    *,
    (PeopleVaccinatedRolling / Population) * 100 AS VaccinationPercentage
FROM PercentPopulationVaccinated;


-- ============================================================
-- QUERY 3: View – Percent Population Vaccinated
-- Stores the rolling vaccination query as a reusable View
-- for future visualisations or reporting.
-- ============================================================
CREATE VIEW PercentPopulationVaccinatedView AS
SELECT
    cde.location,
    cde.`date`,
    cde.population,
    cvc.new_vaccinations,
    SUM(cvc.new_vaccinations) OVER (
        PARTITION BY cde.location
        ORDER BY cde.`date`
    ) AS PeopleVaccinatedRolling
FROM coviddeaths AS cde
JOIN covidvaccinations AS cvc
    ON cde.location = cvc.location
    AND cde.`date`  = cvc.`date`
WHERE cde.continent IS NOT NULL;


-- ============================================================
-- QUERY 4: Global Daily Death Percentage
-- Summarises global new cases, new deaths, and the resulting
-- death percentage for each date across all countries.
-- ============================================================
SELECT
    coviddeaths.`date`,
    SUM(new_cases)                              AS TotalNewCases,
    SUM(new_deaths)                             AS TotalNewDeaths,
    SUM(new_deaths) / SUM(new_cases) * 100      AS DeathPercentage
FROM coviddeaths
WHERE coviddeaths.continent IS NOT NULL
GROUP BY coviddeaths.`date`
ORDER BY coviddeaths.`date`;


-- ============================================================
-- QUERY 5: Highest Infection Rate vs Population by Country
-- Identifies which countries had the highest percentage of
-- their population infected at any point during the pandemic.
-- ============================================================
SELECT
    coviddeaths.location,
    population,
    MAX(total_cases)                            AS HighestInfectedCount,
    MAX((total_cases / population) * 100)       AS HighestInfectedPercentage
FROM coviddeaths
WHERE coviddeaths.continent IS NOT NULL
GROUP BY coviddeaths.location, population
ORDER BY HighestInfectedPercentage DESC;


-- ============================================================
-- QUERY 6: CTE – Population vs Vaccinations Rolling Count
-- Uses a Common Table Expression (CTE) to calculate a rolling
-- vaccination count, then computes the vaccination percentage
-- relative to total population.
-- ============================================================
WITH PopvsVac (Location, Date, Population, NewVaccination, PeopleVaccinatedRolling) AS
(
    SELECT
        cde.location,
        cde.`date`,
        cde.population,
        cvc.new_vaccinations,
        SUM(cvc.new_vaccinations) OVER (
            PARTITION BY cde.location
            ORDER BY cde.`date`
        ) AS PeopleVaccinatedRolling
    FROM coviddeaths AS cde
    JOIN covidvaccinations AS cvc
        ON cde.location = cvc.location
        AND cde.`date`  = cvc.`date`
    WHERE cde.continent IS NOT NULL
)
SELECT
    *,
    (PeopleVaccinatedRolling / Population) * 100 AS VaccinationPercentage
FROM PopvsVac
ORDER BY PopvsVac.Location, PopvsVac.Date;


-- ============================================================
-- QUERY 7: Rolling People Vaccinated Per Country Over Time
-- Joins deaths and vaccinations tables to show each country's
-- cumulative vaccinations day by day using a window function.
-- ============================================================
SELECT
    cde.location,
    cde.`date`,
    cde.population,
    cvc.new_vaccinations,
    SUM(cvc.new_vaccinations) OVER (
        PARTITION BY cde.location
        ORDER BY cde.location, cde.`date`
    ) AS RollingPeopleVaccinated
FROM coviddeaths AS cde
JOIN covidvaccinations AS cvc
    ON cde.location = cvc.location
    AND cde.`date`  = cvc.`date`
WHERE cde.continent IS NOT NULL
ORDER BY cde.location, cde.`date`;


-- ============================================================
-- QUERY 8: Death Percentage in India Over Time
-- Filters records specifically for India and calculates the
-- percentage of confirmed cases that resulted in death.
-- ============================================================
SELECT
    coviddeaths.location,
    `date`,
    total_cases,
    total_deaths,
    (total_deaths / total_cases) * 100 AS DeathPercentage
FROM coviddeaths
WHERE coviddeaths.location LIKE '%India%'
ORDER BY 1, 2;


-- ============================================================
-- QUERY 9: Basic Overview – Cases, Deaths, and Population
-- A simple exploratory query to get an initial look at the
-- raw data: location, date, new cases, total deaths, population.
-- ============================================================
SELECT
    coviddeaths.location,
    `date`,
    new_cases,
    total_deaths,
    population
FROM coviddeaths
ORDER BY 1, 2;


-- ============================================================
-- QUERY 10: Population Affected Percentage Over Time
-- Shows what percentage of each country's population was
-- infected based on total cases vs population.
-- (India filter is commented out – remove comment to enable)
-- ============================================================
SELECT
    coviddeaths.location,
    `date`,
    total_cases,
    population,
    (total_cases / population) * 100 AS PopulationAffectedPercentage
FROM coviddeaths
-- WHERE coviddeaths.location LIKE '%India%'
ORDER BY 1, 2;


-- ============================================================
-- QUERY 11: Highest Death Count by Country
-- Ranks countries by their maximum recorded total death count.
-- The percentage calculation is available but commented out.
-- ============================================================
SELECT
    coviddeaths.location,
    MAX(total_deaths) AS HighestDeathCount
    -- , MAX((total_deaths / population) * 100) AS HighestDeathPercentage
FROM coviddeaths
WHERE coviddeaths.continent IS NOT NULL
GROUP BY coviddeaths.location
ORDER BY HighestDeathCount DESC;


-- ============================================================
-- QUERY 12: Total Population vs People Vaccinated by Country
-- Joins both tables to compare the total population of each
-- country against the maximum number of people vaccinated.
-- ============================================================
SELECT
    MAX(cde.population)          AS Population,
    MAX(cvc.people_vaccinated)   AS PeopleVaccinated,
    cde.location
FROM coviddeaths cde
JOIN covidvaccinations cvc
    ON cde.location = cvc.location
    AND cde.`date`  = cvc.`date`
WHERE cde.continent IS NOT NULL
GROUP BY cde.location
ORDER BY cde.location;
