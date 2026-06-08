# Power BI KPI Dashboard

> Executive-level KPI analytics dashboard replacing manual reporting processes — delivering a 95% improvement in leadership visibility using Power BI, DAX, and SQL.
>
> ![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?logo=powerbi&logoColor=black) ![DAX](https://img.shields.io/badge/DAX-measures-blue) ![SQL](https://img.shields.io/badge/SQL-Server-red) ![Status](https://img.shields.io/badge/status-active-green)
>
> ---
>
> ## 📌 Project Overview
>
> This project delivers a multi-page **Power BI dashboard** that consolidates operational KPIs across Quality, Lab Operations, and Compliance. It replaced spreadsheet-based manual reporting that was error-prone and time-consuming, giving leadership real-time, drill-through visibility into business performance.
>
> **Key outcomes:**
> - 95% improvement in leadership reporting visibility
> - - Reduced manual reporting time from 8 hours/week to under 30 minutes
>   - - Enabled data-driven sprint planning and resource allocation
>    
>     - ---
>
> ## 📊 Dashboard Pages
>
> | Page | Description |
> |---|---|
> | **Operations Overview** | On-time release rate, cycle time, backlog velocity |
> | **Quality Metrics** | CAPA status, deviation trends, inspection pass rates |
> | **Lab Performance** | Sample throughput, analyst productivity, turnaround time |
> | **Compliance Tracker** | Audit findings, corrective actions, regulatory deadlines |
> | **Financial Summary** | Cost savings, budget utilization, ROI from process changes |
>
> ---
>
> ## 📁 Project Structure
>
> ```
> powerbi-kpi-dashboard/
> ├── reports/
> │   ├── KPI_Dashboard_v2.pbix         # Main Power BI report file
> │   └── KPI_Dashboard_Screenshot.png  # Dashboard preview
> ├── sql/
> │   ├── kpi_base_query.sql            # Core data model query
> │   ├── lab_performance_metrics.sql   # Lab KPI calculations
> │   └── compliance_tracker.sql        # Compliance data prep
> ├── dax/
> │   ├── measures.md                   # All DAX measure definitions
> │   └── calculated_columns.md         # Calculated column formulas
> ├── docs/
> │   ├── data_model.md                 # Star schema documentation
> │   └── refresh_schedule.md           # Dataset refresh configuration
> └── README.md
> ```
>
> ---
>
> ## 🔧 Tech Stack
>
> | Component | Technology |
> |---|---|
> | Reporting Tool | Power BI Desktop / Service |
> | Query Language | DAX, Power Query (M) |
> | Data Source | SQL Server, Excel |
> | Data Model | Star Schema |
> | Refresh | Scheduled (daily) |
>
> ---
>
> ## 📐 Key DAX Measures
>
> ```dax
> -- On-Time Release Rate
> On Time Release % =
> DIVIDE(
>     CALCULATE(COUNTROWS(Releases), Releases[Status] = "On Time"),
>     COUNTROWS(Releases),
>     0
> )
>
> -- Cycle Time (Days)
> Avg Cycle Time =
> AVERAGEX(
>     Releases,
>     DATEDIFF(Releases[StartDate], Releases[ReleaseDate], DAY)
> )
>
> -- CAPA Closure Rate
> CAPA Closure Rate % =
> DIVIDE(
>     CALCULATE(COUNTROWS(CAPAs), CAPAs[Status] = "Closed"),
>     COUNTROWS(CAPAs),
>     0
> )
> ```
>
> ---
>
> ## 🗄️ SQL Data Model (Sample)
>
> ```sql
> -- Core KPI base query
> SELECT
>     r.release_id,
>     r.product_name,
>     r.start_date,
>     r.release_date,
>     DATEDIFF(day, r.start_date, r.release_date) AS cycle_time_days,
>     CASE WHEN r.release_date <= r.target_date THEN 'On Time' ELSE 'Late' END AS release_status,
>     a.analyst_name,
>     d.department
> FROM releases r
> JOIN analysts a ON r.analyst_id = a.analyst_id
> JOIN departments d ON r.dept_id = d.dept_id
> WHERE r.release_date >= DATEADD(month, -12, GETDATE())
> ```
>
> ---
>
> ## 📸 Dashboard Preview
>
> *Screenshot placeholder — connect to your Power BI Service workspace to view the live dashboard.*
>
> ---
>
> ## 🚀 Setup Instructions
>
> 1. Open `reports/KPI_Dashboard_v2.pbix` in Power BI Desktop
> 2. 2. Update data source credentials in **Transform Data > Data Source Settings**
>    3. 3. Run SQL scripts in `/sql/` folder to set up the data model
>       4. 4. Publish to Power BI Service and configure scheduled refresh
>         
>          5. ---
>         
>          6. *Built by [Sneha Ajmira](https://linkedin.com/in/contactsnehaajmira) | Product Owner & Business Systems Analyst*
