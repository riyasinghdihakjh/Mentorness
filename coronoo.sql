
/*Q1. Check for NULL values*/
SELECT 
    SUM(CASE WHEN Province IS NULL THEN 1 ELSE 0 END) AS Province_nulls,
    SUM(CASE WHEN CountryRegion IS NULL THEN 1 ELSE 0 END) AS CountryRegion_nulls,
    SUM(CASE WHEN Latitude IS NULL THEN 1 ELSE 0 END) AS Latitude_nulls,
    SUM(CASE WHEN Longitude IS NULL THEN 1 ELSE 0 END) AS Longitude_nulls,
    SUM(CASE WHEN Date IS NULL THEN 1 ELSE 0 END) AS Date_nulls,
    SUM(CASE WHEN Confirmed IS NULL THEN 1 ELSE 0 END) AS Confirmed_nulls,
    SUM(CASE WHEN Deaths IS NULL THEN 1 ELSE 0 END) AS Deaths_nulls,
    SUM(CASE WHEN Recovered IS NULL THEN 1 ELSE 0 END) AS Recovered_nulls
FROM CovidData;
/*Q2. Update NULL values with zeros for all columns*/
UPDATE CovidData
SET 
    Province = COALESCE(Province, ''),
    CountryRegion = COALESCE(CountryRegion, ''),
    Latitude = COALESCE(Latitude, 0),
    Longitude = COALESCE(Longitude, 0),
    Date = COALESCE(Date, '1970-01-01'),
    Confirmed = COALESCE(Confirmed, 0),
    Deaths = COALESCE(Deaths, 0),
    Recovered = COALESCE(Recovered, 0);
/*Q3. Check total number of rows*/
SELECT COUNT(*) AS total_rows
FROM CovidData;
/*Q4. Check start_date and end_date*/
SELECT MIN(Date) AS start_date, MAX(Date) AS end_date
FROM CovidData;
/*Q5. Number of months present in the dataset*/
SELECT COUNT(DISTINCT DATE_TRUNC('month', Date)) AS total_months
FROM CovidData;
/*Q6. Find monthly average for confirmed, deaths, recovered*/
SELECT
    DATE_TRUNC('month', Date) AS month,
    AVG(Confirmed) AS avg_confirmed,
    AVG(Deaths) AS avg_deaths,
    AVG(Recovered) AS avg_recovered
FROM CovidData
GROUP BY month
ORDER BY month;
/*Q7. Find most frequent value for confirmed, deaths, recovered each month*/
WITH MonthlyStats AS (
    SELECT
        DATE_TRUNC('month', Date) AS month,
        Confirmed,
        Deaths,
        Recovered,
        COUNT(*) AS freq
    FROM CovidData
    GROUP BY month, Confirmed, Deaths, Recovered
)
SELECT month, 
       Confirmed, 
       Deaths, 
       Recovered
FROM MonthlyStats
WHERE (month, freq) IN (
    SELECT month, MAX(freq) 
    FROM MonthlyStats 
    GROUP BY month
)
ORDER BY month;
/*Q8. Find minimum values for confirmed, deaths, recovered per year*/
SELECT
    DATE_TRUNC('year', Date) AS year,
    MIN(Confirmed) AS min_confirmed,
    MIN(Deaths) AS min_deaths,
    MIN(Recovered) AS min_recovered
FROM CovidData
GROUP BY year
ORDER BY year;
/*Q9. Find maximum values of confirmed, deaths, recovered per year*/
SELECT
    DATE_TRUNC('year', Date) AS year,
    MAX(Confirmed) AS max_confirmed,
    MAX(Deaths) AS max_deaths,
    MAX(Recovered) AS max_recovered
FROM CovidData
GROUP BY year
ORDER BY year;
/*Q10. Total number of confirmed, deaths, recovered cases each month*/
SELECT
    DATE_TRUNC('month', Date) AS month,
    SUM(Confirmed) AS total_confirmed,
    SUM(Deaths) AS total_deaths,
    SUM(Recovered) AS total_recovered
FROM CovidData
GROUP BY month
ORDER BY month;
/*Q11. Spread of coronavirus with respect to confirmed cases*/
SELECT
    SUM(Confirmed) AS total_confirmed,
    AVG(Confirmed) AS avg_confirmed,
    VARIANCE(Confirmed) AS variance_confirmed,
    STDDEV(Confirmed) AS stddev_confirmed
FROM CovidData;
/*Q12. Spread of coronavirus with respect to death cases per month*/
SELECT
    DATE_TRUNC('month', Date) AS month,
    SUM(Deaths) AS total_deaths,
    AVG(Deaths) AS avg_deaths,
    VARIANCE(Deaths) AS variance_deaths,
    STDDEV(Deaths) AS stddev_deaths
FROM CovidData
GROUP BY month
ORDER BY month;
/*Q13. Spread of coronavirus with respect to recovered cases*/
SELECT
    SUM(Recovered) AS total_recovered,
    AVG(Recovered) AS avg_recovered,
    VARIANCE(Recovered) AS variance_recovered,
    STDDEV(Recovered) AS stddev_recovered
FROM CovidData;
/*Q14. Country with the highest number of confirmed cases*/
SELECT
    CountryRegion,
    SUM(Confirmed) AS total_confirmed
FROM CovidData
GROUP BY CountryRegion
ORDER BY total_confirmed DESC
LIMIT 1;
/*Q15. Country with the lowest number of death cases*/
SELECT
    CountryRegion,
    SUM(Deaths) AS total_deaths
FROM CovidData
GROUP BY CountryRegion
ORDER BY total_deaths ASC
LIMIT 1;
/*16. Top 5 countries with the highest number of recovered cases*/
SELECT
    CountryRegion,
    SUM(Recovered) AS total_recovered
FROM CovidData
GROUP BY CountryRegion
ORDER BY total_recovered DESC
LIMIT 5;






