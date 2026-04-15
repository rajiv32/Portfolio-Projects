# 🦠 COVID-19 Data Exploration – SQL Portfolio Project

> **Inspired by Alex The Analyst's SQL Portfolio Project Series**

This project explores global COVID-19 data using SQL to uncover trends in infection rates, death counts, and vaccination rollouts across countries and continents.

---

## 📁 Project Structure

```
covid-sql-project/
│
└── covid_analysis.sql    # All 12 SQL queries with detailed comments
```

---

## 🗃️ Dataset

- **Source:** [Our World in Data – COVID-19 Dataset](https://ourworldindata.org/covid-deaths)
- **Tables Used:**
  - `coviddeaths` — Daily records of COVID cases, deaths, and population per country
  - `covidvaccinations` — Daily vaccination data per country

---

## 🛠️ Tools & Skills Used

| Tool | Usage |
|------|-------|
| **MySQL** | Writing and executing all queries |
| **Joins** | Combining deaths and vaccinations tables |
| **Window Functions** | Rolling vaccination totals using `SUM() OVER (PARTITION BY ...)` |
| **CTEs** | Readable multi-step logic with `WITH` clauses |
| **Temp Tables** | Intermediate storage for multi-query workflows |
| **Views** | Reusable query definitions for reporting |
| **Aggregate Functions** | `MAX()`, `SUM()` for country/continent-level summaries |

---

## 📊 Queries Overview

| # | Query | Description |
|---|-------|-------------|
| 1 | Total Deaths by Continent | Max deaths grouped at the continent level |
| 2 | Temp Table – % Population Vaccinated | Stores rolling vaccination data for reuse |
| 3 | View – % Population Vaccinated | Reusable view version of the vaccination rollup |
| 4 | Global Daily Death Percentage | Daily worldwide death rate from confirmed cases |
| 5 | Highest Infection Rate by Country | Countries ranked by peak infection % of population |
| 6 | CTE – Population vs Vaccinations | Rolling vaccination count using a CTE |
| 7 | Rolling Vaccinations Over Time | Cumulative vaccinations per country using window functions |
| 8 | India – Death Percentage Over Time | Case fatality rate trend filtered for India |
| 9 | Basic Data Overview | Raw snapshot of cases, deaths, and population |
| 10 | Population Affected % | What % of each country's population was infected |
| 11 | Highest Death Count by Country | Countries ranked by total deaths |
| 12 | Population vs People Vaccinated | Country-level comparison of population and vaccinations |

---

## 🔍 Key Insights

- **Infection rates** varied significantly by country — some nations saw over 50% of their population infected at peak.
- **Death percentages** were highest in the early waves before vaccines became widely available.
- **Rolling vaccination data** demonstrates the rapid scale-up in vaccine distribution through 2021–2022.
- **India-specific analysis** shows how the death-to-case ratio shifted across different pandemic waves.

---

## 🚀 How to Run

1. Download the COVID-19 dataset from [Our World in Data](https://ourworldindata.org/covid-deaths)
2. Import the data into your MySQL instance as two tables:
   - `coviddeaths`
   - `covidvaccinations`
3. Open `covid_analysis.sql` in MySQL Workbench (or any SQL client)
4. Run queries individually or all at once

---

## 🙏 Credits

- Dataset: [Our World in Data](https://ourworldindata.org/)
- Project concept: [Alex The Analyst](https://www.youtube.com/@AlexTheAnalyst) – SQL Portfolio Project tutorial series

---

## 📬 Connect

Feel free to reach out or fork this project if you found it useful!
