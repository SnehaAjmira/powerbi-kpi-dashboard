# Lab Operations KPI Model: SQL and DAX

The data model behind a Power BI dashboard for laboratory release and quality KPIs: SQL Server source schema, the base query that builds the fact table, a DAX measure library, and KPI definitions.

| | |
|---|---|
| **Domain** | Laboratory operations, quality assurance, release management |
| **Tools** | T-SQL (SQL Server), DAX, Power BI |
| **Techniques** | Dimensional modeling, CTE-based fact query, DAX time intelligence, KPI definition and targets |
| **Contents** | 2 SQL files, 1 DAX measure library, KPI definitions |

---

## 1. Contents

| File | Purpose |
|---|---|
| `sql/schema.sql` | Source tables (departments, analysts, releases, quality events) with keys, constraints, and indexes |
| `sql/kpi_base_query.sql` | Builds the release-grain fact table: cycle time, on-time status, deviation and CAPA counts |
| `dax/measures.dax` | 13 measures: on-time %, cycle time, right first time, deviation rate, CAPA closure, prior-year and rolling 3-month comparisons, status flag |
| `docs/kpi_definitions.md` | Business definition, formula, grain, and example target for each KPI, plus model relationships |

## 2. KPIs

| Area | KPI |
|---|---|
| Delivery | On Time Release %, Avg and Median Cycle Time, Rolling 3-month Cycle Time |
| Quality | Right First Time %, Deviations per 100 Releases, Major Deviations, CAPA Closure % |
| Trend | On Time Release % vs Prior Year (percentage points) |
| Status | On target / Watch / Below target flag for conditional formatting |

## 3. Model

```
dbo.departments ─┐
dbo.analysts ────┼─> sql/kpi_base_query.sql ─> KPI_Base (fact, 1 row per release)
dbo.releases ────┤                                  │
dbo.quality_events┘                           'Date' dimension
```

## 4. How to Use

1. Create the source tables with `sql/schema.sql` (or map the query to existing tables).
2. In Power BI, load `sql/kpi_base_query.sql` as a native query named `KPI_Base`.
3. Add a date table, mark it as the date table, and relate it to `KPI_Base[release_date]`.
4. Create the measures from `dax/measures.dax`.

## 5. Scope

This repository contains the model and measure logic only. The report file and data are not included because they contain organization-specific information. For complete data analysis projects with outputs, see the data analyst projects on my profile.

Author: [Sneha Ajmira](https://linkedin.com/in/contactsnehaajmira)
