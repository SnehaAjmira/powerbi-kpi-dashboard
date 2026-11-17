-- ============================================================
-- schema.sql
-- Source tables for the Lab Operations KPI model (T-SQL / SQL Server)
-- Author: Sneha Ajmira
-- ============================================================

CREATE TABLE dbo.departments (
    dept_id          INT           NOT NULL PRIMARY KEY,
    department_name  NVARCHAR(100) NOT NULL
);

CREATE TABLE dbo.analysts (
    analyst_id       INT           NOT NULL PRIMARY KEY,
    analyst_name     NVARCHAR(100) NOT NULL,
    dept_id          INT           NOT NULL REFERENCES dbo.departments (dept_id),
    is_active        BIT           NOT NULL DEFAULT 1
);

CREATE TABLE dbo.releases (
    release_id       INT           NOT NULL PRIMARY KEY,
    product_name     NVARCHAR(150) NOT NULL,
    batch_number     NVARCHAR(50)  NOT NULL,
    start_date       DATE          NOT NULL,
    target_date      DATE          NOT NULL,
    release_date     DATE          NULL,          -- NULL until released
    dept_id          INT           NOT NULL REFERENCES dbo.departments (dept_id),
    analyst_id       INT           NOT NULL REFERENCES dbo.analysts (analyst_id),
    is_active        BIT           NOT NULL DEFAULT 1,
    CONSTRAINT ck_release_dates CHECK (release_date IS NULL OR release_date >= start_date)
);

CREATE TABLE dbo.quality_events (
    event_id         INT           NOT NULL PRIMARY KEY,
    release_id       INT           NOT NULL REFERENCES dbo.releases (release_id),
    event_date       DATE          NOT NULL,
    deviation_type   NVARCHAR(10)  NULL CHECK (deviation_type IN ('Minor', 'Major', 'Critical')),
    capa_status      NVARCHAR(10)  NULL CHECK (capa_status IN ('Open', 'Closed')),
    capa_due_date    DATE          NULL,
    capa_closed_date DATE          NULL
);

CREATE INDEX ix_releases_release_date ON dbo.releases (release_date) INCLUDE (start_date, target_date);
CREATE INDEX ix_quality_events_release ON dbo.quality_events (release_id);
