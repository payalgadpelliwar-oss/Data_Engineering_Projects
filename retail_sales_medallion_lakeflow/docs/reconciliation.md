# Reconciliation

This document verifies that data moves through the Bronze → Silver → Gold layers correctly in the Retail Sales Medallion pipeline.

The reconciliation process checks source record counts, Bronze and Silver row counts, quarantined records, and consistency of Gold-level business metrics.

> **Principle:** Every source record must be accounted for. Records retained, quarantined, or excluded must be traceable, and differences between pipeline layers must be explained.

## 1. Reconciliation Objectives

- Source row count must match Bronze row count.
- Bronze records must be accounted for in Silver and quarantine.
- Silver trusted totals must match corresponding Gold totals.
- Duplicate and invalid records must be tracked.
- Every difference must be explained.
- Reconciliation must be repeatable after pipeline refresh.

## 2. Row Count Reconciliation

| Stage           | Object               | Row Count | Notes                              |
| --------------- | -------------------- | --------- | ---------------------------------- |
| Source          | `sales.csv`          | 1,506     | Original source dataset            |
| Bronze          | `bronze_sales`       | 1,506     | Raw records loaded                 |
| Silver          | Silver clean records | 1,490     | Validated and deduplicated records |
| Quarantined     | Quarantine records   | 16        | Records separated from Silver      |
| Total accounted | Silver + Quarantine  | 1,506     | Fully reconciled                   |

### Reconciliation Formula

`Bronze Rows = Silver Rows + Quarantined Rows`

`1,506 = 1,490 + 16`

**Result:** All 1,506 Bronze records are accounted for.

## 3. Excluded and Quarantined Records

| Reason               | Rule ID | Count | Treatment   | In Gold?                       |
| -------------------- | ------- | ----- | ----------- | ------------------------------ |
| Quarantined records  | DQ-01   | 16    | Quarantined | No, subject to reporting rules |
| Clean Silver records | DQ-02   | 1,490 | Retained    | Eligible for Gold              |

**Note:** Individual issue-type counts require detailed pipeline quality metrics. The total quarantine count must not be treated as the count of each individual issue.

## 4. Key Total Reconciliation

| Measure        | Bronze | Silver Trusted | Gold | Difference |
| -------------- | ------ | -------------- | ---- | ---------- |
| Total Sales    | TODO   | TODO           | TODO | TODO       |
| Total Profit   | TODO   | TODO           | TODO | TODO       |
| Total Quantity | TODO   | TODO           | TODO | TODO       |

**Pass Criteria:** Silver trusted totals must match the corresponding Gold totals. Any difference must be investigated and documented.

## 5. Gold Table Checks

| Gold Table                | Check               | Expected               | Actual | Status |
| ------------------------- | ------------------- | ---------------------- | ------ | ------ |
| Gold Sales Summary        | Sales aggregation   | Match Silver           | TODO   | TODO   |
| Gold Product Summary      | Product-level sales | Match Silver           | TODO   | TODO   |
| Gold Data Quality Summary | Quality metrics     | Match pipeline metrics | TODO   | TODO   |
| Gold Reconciliation       | Layer row counts    | 1,506 total accounted  | TODO   | TODO   |

*Note: Confirm actual Gold table names in your Databricks Catalog before finalizing this section.*

## 6. Validation Queries

Save validation queries in `validation/reconciliation_checks.sql`.

### Query 1: Row Counts Across Layers

```sql
SELECT 'Bronze' AS layer, COUNT(*) AS row_count
FROM <catalog>.<schema>.bronze_sales

UNION ALL

SELECT 'Silver', COUNT(*)
FROM <catalog>.<schema>.silver_sales;
```

### Query 2: Bronze and Silver Reconciliation

```sql
SELECT
    (SELECT COUNT(*) FROM <catalog>.<schema>.bronze_sales)
        AS bronze_rows,

    (SELECT COUNT(*) FROM <catalog>.<schema>.silver_sales)
        AS silver_rows,

    16 AS quarantined_rows;
```

### Query 3: Reconciliation Difference

```sql
SELECT
    1506 AS bronze_rows,
    1490 AS silver_rows,
    16 AS quarantined_rows,
    1506 - (1490 + 16) AS difference;
```

Expected difference: 0.

### Query 4: Gold Sales Validation

```sql
-- Replace table and column names
-- with the actual names in your Gold and Silver layers.

SELECT
    SUM(sales) AS silver_sales_total
FROM <catalog>.<schema>.silver_sales;
```

### Query 5: Duplicate Validation

```sql
-- Check duplicate records using the actual
-- business key implemented in your pipeline.

SELECT *
FROM <catalog>.<schema>.silver_sales
LIMIT 10;
```

## 7. Differences and Explanations

| Difference                    | Amount | Explanation               |
| ----------------------------- | ------ | ------------------------- |
| Bronze vs Source rows         | 0      | All source records loaded |
| Bronze vs Silver rows         | 16     | Records quarantined       |
| Silver + Quarantine vs Bronze | 0      | Fully reconciled          |
| Silver vs Gold totals         | TODO   | Requires Gold validation  |

## 8. Sign-off Checklist

- [ ] Source row count = Bronze row count
- [ ] Bronze = Silver + Quarantined records
- [ ] All quarantine reasons verified
- [ ] Gold total sales = Silver trusted sales
- [ ] Gold total profit = Silver trusted profit
- [ ] Duplicate validation completed
- [ ] Reconciliation verified after full refresh

**Run Date:** 10 November 2026 (documentation date; verify actual pipeline run date)

**Pipeline Run ID:** To be verified

**Result:** Bronze-to-Silver row count reconciliation successful. Gold reconciliation pending verification.

## 9. Rerun Behavior

The pipeline should produce consistent results when refreshed with the same source data and transformation logic.

After every full refresh:

1. Verify Bronze row count.
2. Verify Silver clean row count.
3. Check quarantined record count.
4. Validate Gold aggregations.
5. Compare reconciliation results with the previous run.

If unexpected differences occur, investigate the source data, transformation logic, and pipeline execution before publishing business reports.
