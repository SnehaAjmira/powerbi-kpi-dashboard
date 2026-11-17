# KPI Definitions

| KPI | Definition | Formula | Grain | Target (example) |
|---|---|---|---|---|
| On Time Release % | Share of released batches released on or before target date | Releases On Time / Releases | Release | 95% |
| Avg Cycle Time | Average days from testing start to release | AVG(release_date - start_date) | Release | Set per product |
| Right First Time % | Share of releases with zero deviations | Releases with 0 deviations / Releases | Release | 90% |
| Deviations per 100 Releases | Normalized deviation rate | (Minor + Major) / Releases x 100 | Release | Trend down |
| CAPA Closure % | Share of CAPAs closed | Closed / (Open + Closed) | CAPA | 90% |
| On Time Release % vs PY | Change vs same period last year, in percentage points | Current - Prior year | Period | Positive |

## Model

| Table | Type | Source | Key |
|---|---|---|---|
| KPI_Base | Fact | `sql/kpi_base_query.sql` | release_id |
| Date | Dimension | DAX `CALENDAR` or date table | Date |

Relationship: `Date[Date]` (1) to `KPI_Base[release_date]` (many), single direction.

## Data Rules

- Only active releases (`is_active = 1`) with a release date in the last 12 months are included.
- Releases with no quality events count as zero deviations (`COALESCE` in the base query).
- Late = `release_date > target_date`. Same-day release counts as on time.
