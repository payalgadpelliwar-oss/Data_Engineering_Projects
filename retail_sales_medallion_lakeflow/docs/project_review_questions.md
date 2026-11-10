Project Review Questions and Answers

1. How do you maintain data traceability across Bronze, Silver and Gold layers?
Answer:

Data traceability is maintained by preserving raw records in Bronze and applying documented transformations in Silver and Gold.
- Bronze preserves the original source data.
- Silver contains cleaned and validated records.
- Gold contains aggregated business information.
By maintaining transformation logic and reconciliation queries, we can trace differences between layers and investigate data issues.
2. What is the difference between a streaming table and a materialized view in Databricks?
Answer:

A streaming table is designed for incremental data processing from streaming sources. It processes newly arriving data while maintaining pipeline state.

A materialized view stores the result of a query and refreshes it as its source data changes.

In this project, these objects help organize ingestion and business-level transformations.
3. How do you handle invalid records in the Silver layer?
Answer:

Invalid records are identified using data-quality validation rules.

Examples include:
- Missing Order ID.
- Invalid sales values.
- Missing order dates.
- Invalid quantity values.
- Duplicate records.
Depending on the business rule, records can be flagged for investigation or excluded from trusted reporting. The reason and counts should be documented.
4. Why is reconciliation important in a data engineering project?
Answer:

Reconciliation ensures that data is transferred and transformed correctly across different layers.

It helps identify:
- Missing records.
- Duplicate records.
- Incorrect aggregations.
- Unexpected differences in sales totals.
- Data-quality issues.
It improves confidence in the final Gold reporting tables.
5. What would happen if the source CSV schema changes?
Answer:

If the source CSV schema changes, the pipeline may encounter schema-related errors.

To handle this situation, I would:
1. Identify the new or modified columns.
2. Review the source schema.
3. Update transformation logic.
4. Handle new columns appropriately.
5. Validate the Silver and Gold outputs.
6. Perform reconciliation after the pipeline refresh.
6. How do you prevent incorrect business insights from reaching the reporting layer?
Answer:

I use data-quality checks and reconciliation before trusting Gold data.

I validate sales values, quantities, duplicate records and null values. I also compare Gold totals with trusted Silver totals.

Only after verifying the results should the Gold tables be used for business reporting.
7. What is the importance of idempotency in data pipelines?
Answer:

Idempotency means that processing the same input again should not create unintended duplicate results.

It is important because pipelines may need to be rerun after failures.

It can be supported through proper deduplication, source tracking and reliable incremental processing logic.
8. How would you monitor and maintain this pipeline in a production environment?
Answer:

I would monitor the pipeline using Databricks pipeline event logs and execution status.

I would also implement:
- Data-quality monitoring.
- Failure alerts.
- Row-count reconciliation.
- Schema-change detection.
- Scheduled pipeline execution.
- Logging and documentation.
These practices help maintain pipeline reliability and data accuracy.
