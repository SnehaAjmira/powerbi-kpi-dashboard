-- ============================================================
-- kpi_base_query.sql
-- KPI Dashboard Base Data Query
-- Author: Sneha Ajmira | Eagle Analytical Services
-- Description: Core query powering the Power BI KPI dashboard
--              Aggregates release, quality, and lab metrics
-- ============================================================

WITH release_metrics AS (
      SELECT
          r.release_id,
          r.product_name,
          r.batch_number,
          r.start_date,
          r.release_date,
          r.target_date,
          DATEDIFF(day, r.start_date, r.release_date)    AS cycle_time_days,
          CASE
              WHEN r.release_date <= r.target_date THEN 'On Time'
              ELSE 'Late'
          END                                             AS release_status,
          r.dept_id,
          r.analyst_id
      FROM dbo.releases r
      WHERE r.is_active = 1
        AND r.release_date >= DATEADD(month, -12, GETDATE())
  ),

quality_metrics AS (
      SELECT
          q.release_id,
          COUNT(CASE WHEN q.deviation_type = 'Minor' THEN 1 END)   AS minor_deviations,
          COUNT(CASE WHEN q.deviation_type = 'Major' THEN 1 END)   AS major_deviations,
          COUNT(CASE WHEN q.capa_status = 'Open' THEN 1 END)       AS open_capas,
          COUNT(CASE WHEN q.capa_status = 'Closed' THEN 1 END)     AS closed_capas
      FROM dbo.quality_events q
      GROUP BY q.release_id
  )

SELECT
    rm.release_id,
    rm.product_name,
    rm.batch_number,
    rm.start_date,
    rm.release_date,
    rm.cycle_time_days,
    rm.release_status,
    a.analyst_name,
    d.department_name,
    COALESCE(qm.minor_deviations, 0)  AS minor_deviations,
    COALESCE(qm.major_deviations, 0)  AS major_deviations,
    COALESCE(qm.open_capas, 0)        AS open_capas,
    COALESCE(qm.closed_capas, 0)      AS closed_capas,
    GETDATE()                          AS report_generated_at
FROM release_metrics rm
LEFT JOIN dbo.analysts a        ON rm.analyst_id  = a.analyst_id
LEFT JOIN dbo.departments d     ON rm.dept_id     = d.dept_id
LEFT JOIN quality_metrics qm    ON rm.release_id  = qm.release_id
ORDER BY rm.release_date DESC;
