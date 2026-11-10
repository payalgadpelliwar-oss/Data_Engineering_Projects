# Retail Sales Analytics Platform: Medallion Architecture with Azure Databricks

An end-to-end Retail Sales Data Engineering project built using **Azure Databricks, Lakeflow Spark Declarative Pipelines (SDP), SQL, and Medallion Architecture (Bronze → Silver → Gold)**.

This project transforms raw retail sales data into cleaned, validated, and business-ready datasets. It demonstrates data ingestion, transformation, data quality validation, pipeline lineage, and reconciliation across multiple layers.

<img width="2048" height="1152" alt="image" src="https://github.com/user-attachments/assets/8ba03018-9278-4e18-974e-039319054b80" />


## Table of Contents

- [Business Problem](#business-problem)
- [Architecture](#architecture)
- [Pipeline Lineage](#pipeline-lineage)
- [Tech Stack](#tech-stack)
- [Dataset](#dataset)
- [Repository Structure](#repository-structure)
- [Layer Details](#layer-details)
- [Data Quality Rules](#data-quality-rules)
- [Reconciliation](#reconciliation)
- [How to Run](#how-to-run)
- [Business Requirements Coverage](#business-requirements-coverage)
- [Key Learnings](#key-learnings)
- [Future Improvements](#future-improvements)

## Business Problem

Retail businesses generate sales data that requires proper cleaning, transformation, and validation before it can be used for reporting and analysis.

Raw datasets may contain missing values, duplicate records, inconsistent formats, and invalid values.

**Goal:** Build a reliable and repeatable data engineering pipeline that processes retail sales data through Bronze, Silver, and Gold layers and produces trusted data for business reporting.

## Architecture

The project follows the Medallion Architecture:

**Source Data → Bronze → Silver → Gold → Business Reporting**

| Layer | Purpose | Key Activities |
|---|---|---|
| Bronze | Raw data ingestion | Load and preserve source data |
| Silver | Data cleaning and validation | Clean, standardize, and validate records |
| Gold | Business-ready data | Create reporting and analytical datasets |

## Pipeline Lineage

The pipeline follows a structured transformation process in which data moves from the Bronze layer to Silver and then to Gold.

- Bronze: Raw source data.
- Silver: Cleaned and validated data.
- Gold: Business-ready reporting data.

Pipeline execution and dependencies are managed through Lakeflow Spark Declarative Pipelines.'


<img width="1240" height="741" alt="image" src="https://github.com/user-attachments/assets/65d40596-1b5c-441d-ae71-f09a5469b9e9" />


## Tech Stack

- Azure Databricks
- Lakeflow Spark Declarative Pipelines
- SQL
- Delta Lake
- Unity Catalog
- Medallion Architecture
- GitHub

## Dataset

The project uses a Retail Sales dataset as the source for data ingestion and transformation.

The dataset is processed through multiple layers to improve data quality, consistency, and reliability.

## Repository Structure

```text
retail_sales_medallion_lakeflow/
│
├── Data/
│
├── ETL_Pipeline/
│
├── Image/
│
├── Images/
│
├── docs/
│
└── README.md
```

## Layer Details

### Bronze Layer

- Ingests raw retail sales data.
- Preserves source records.
- Maintains the initial data structure.
- Acts as the foundation for downstream transformations.

### Silver Layer

- Cleans and standardizes the data.
- Handles missing and invalid values according to validation rules.
- Applies data quality checks.
- Prepares trusted records for further analysis.

### Gold Layer

- Contains business-ready transformed datasets.
- Supports analytical queries and reporting.
- Provides structured information for business insights.

## Data Quality Rules

Data quality is maintained through validation and transformation checks.

| Area | Purpose |
|---|---|
| Completeness | Identify missing values |
| Consistency | Standardize data formats |
| Validity | Validate business and data rules |
| Duplicates | Identify duplicate records |
| Reconciliation | Verify data across layers |

## Reconciliation

Reconciliation validates data movement and transformation across Bronze, Silver, and Gold layers.

The project includes reconciliation documentation and SQL validation checks.

Key validation areas:

- Source-to-Bronze record counts.
- Bronze-to-Silver record counts.
- Data quality and invalid records.
- Gold-level data validation.
- Record and business metric consistency.

## How to Run

1. Open Azure Databricks.
2. Access the project workspace.
3. Configure the source dataset.
4. Open the Lakeflow Spark Declarative Pipeline.
5. Verify the pipeline configuration.
6. Execute the pipeline.
7. Validate Bronze, Silver, and Gold tables.
8. Run reconciliation SQL queries.
9. Verify the final pipeline execution status.

## Business Requirements Coverage

| Area | Description |
|---|---|
| Data Ingestion | Load source retail sales data |
| Data Transformation | Clean and transform records |
| Data Quality | Validate data quality |
| Medallion Architecture | Bronze, Silver, Gold |
| Pipeline Management | Lakeflow Spark Declarative Pipelines |
| Reconciliation | Validate data across layers |

## Key Learnings

- Understanding Medallion Architecture.
- Building ETL pipelines using Databricks SQL.
- Data ingestion and transformation.
- Data quality validation.
- Pipeline execution and monitoring.
- Reconciliation across data layers.
- Organizing data engineering projects using GitHub.

## Future Improvements

- Automate data ingestion.
- Implement advanced data quality monitoring.
- Add pipeline failure alerts.
- Improve incremental data processing.
- Develop business intelligence dashboards.
- Enhance pipeline performance and scalability
GitHub: https://github.com/payalgadpelliwar-oss

