# Data Quality Rules

This document describes the data-quality rules applied in the Retail Sales Medallion pipeline, how each issue is treated, and where it is enforced.

> **Principle:** Raw data is preserved in the Bronze layer. Data quality issues are identified, standardized, validated, and monitored across the Silver and Gold layers. Records are excluded from trusted reporting only when a documented rule requires it.

## 1. Data Quality Objectives

The objective of data quality checks is to ensure that retail sales data is accurate, complete, consistent, and reliable for business reporting.

The pipeline follows the Medallion Architecture:

- **Bronze:** Preserve raw source data.
- **Silver:** Clean, standardize, and validate data.
- **Gold:** Prepare trusted business-level reporting tables.

## 2. Known Data Quality Issues

The source retail sales dataset may contain the following issues:

| # | Issue | Description |
|---|-------|-------------|
| 1 | Missing values | Null or blank values in important columns |
| 2 | Duplicate records | Repeated records in the source data |
| 3 | Invalid data types | Values stored in incorrect formats |
| 4 | Inconsistent text | Leading/trailing spaces or inconsistent casing |
| 5 | Invalid numeric values | Negative or zero values where not expected |
| 6 | Date inconsistencies | Invalid or inconsistent date values |
| 7 | Data integrity issues | Records that do not meet business requirements |

## 3. Rules by Layer

### Bronze Layer: Raw Data Preservation

| Rule ID | Rule | Treatment |
|---------|------|-----------|
| BRZ-01 | Preserve source data without business-level modifications | Preserve |
| BRZ-02 | Maintain source data traceability | Track |
| BRZ-03 | Verify source and Bronze record counts | Reconcile |

### Silver Layer: Data Cleaning and Validation

| Rule ID | Dimension | Rule | Treatment | Action |
|---------|-----------|------|-----------|--------|
| SLV-01 | Standardization | Standardize text values and remove unnecessary whitespace | Clean | Fix |
| SLV-02 | Type Validity | Convert columns to appropriate data types | Validate | Fix |
| SLV-03 | Completeness | Identify null or missing values in required fields | Flag | Flag |
| SLV-04 | Duplicates | Identify duplicate records | Validate | Investigate |
| SLV-05 | Business Validity | Validate numeric values against business rules | Flag | Flag |
| SLV-06 | Date Validity | Validate date fields and identify invalid dates | Flag | Flag |
| SLV-07 | Consistency | Ensure consistency across related columns | Validate | Fix |

### Gold Layer: Trusted Reporting

| Rule ID | Rule | Treatment |
|---------|------|-----------|
| GLD-01 | Use validated Silver data for business aggregations | Filter |
| GLD-02 | Maintain consistency in business metrics | Validate |
| GLD-03 | Reconcile Gold aggregates with Silver data | Reconcile |
| GLD-04 | Provide reliable business-ready reporting tables | Publish |

## 4. Flag vs. Reject

| | Flag | Reject / Exclude |
|---|-------|------------------|
| Meaning | Record is retained and marked for investigation | Record is excluded from trusted reporting |
| Usage | Suspicious but potentially valid values | Invalid or redundant records |
| Visibility | Quality metrics and validation results | Exclusion counts and reconciliation |
| Reversible | Yes | Yes, when raw data is preserved |

## 5. Data Quality Validation

The following checks are considered during data processing:

- Completeness checks for required columns.
- Duplicate record identification.
- Data type validation.
- Standardization of text fields.
- Business validation for numeric fields.
- Date format and validity checks.
- Reconciliation between pipeline layers.

## 6. Pipeline Expectations

Data quality expectations can be implemented using Lakeflow Declarative Pipelines.

-- Example validation rules
CONSTRAINT valid_quantity EXPECT (quantity > 0),
CONSTRAINT valid_price EXPECT (unit_price >= 0),
CONSTRAINT has_category EXPECT (category IS NOT NULL)


## 7. Issue Summary (After Pipeline Run)

The pipeline processed 1,506 source records through the Bronze and Silver layers.

| Layer / Issue | Rule ID | Count | Treatment |
|-------|---------|-------|-----------|
| Bronze source records | BRZ-03 | 1,506 | Preserved |
| Silver clean records | SLV-01 to SLV-09 | 1,490 | Validated |
| Quarantined records | SLV-DQ | 16 | Quarantined |


## 8. Assumptions and Decisions

- Raw data is preserved in the Bronze layer.
- Silver contains cleaned and validated records.
- Quarantined records are tracked separately.
- Missing values are not automatically imputed.
- Unusual values are investigated before exclusion.
- Bronze, Silver and Quarantine counts are monitored for reconciliation.
- Gold-level issue breakdown and PASS/FAIL validation require additional quality-summary metrics.

These are example expectations. Actual constraints should match the implemented pipeline logic.

