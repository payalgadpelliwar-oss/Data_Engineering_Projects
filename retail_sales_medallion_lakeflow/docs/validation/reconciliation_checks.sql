
-- ============================================================
-- RETAIL SALES MEDALLION PIPELINE
-- BRONZE -> SILVER -> GOLD
-- RECONCILIATION AND VALIDATION CHECKS
-- ============================================================

-- 1. ROW COUNT RECONCILIATION

SELECT 'Bronze' AS layer, COUNT(*) AS row_count
FROM retail_sales_sdp.default.bronze_sales

UNION ALL

SELECT 'Silver', COUNT(*)
FROM retail_sales_sdp.default.silver_sales

UNION ALL

SELECT 'Gold Monthly', COUNT(*)
FROM retail_sales_sdp.default.gold_monthly_sales_trends

UNION ALL

SELECT 'Gold Product', COUNT(*)
FROM retail_sales_sdp.default.gold_product_performance;


-- 2. BRONZE VS SILVER RECONCILIATION

SELECT
    (SELECT COUNT(*)
     FROM retail_sales_sdp.default.bronze_sales) AS bronze_rows,

    (SELECT COUNT(*)
     FROM retail_sales_sdp.default.silver_sales) AS silver_rows,

    (SELECT COUNT(*)
     FROM retail_sales_sdp.default.bronze_sales)
    -
    (SELECT COUNT(*)
     FROM retail_sales_sdp.default.silver_sales)
     AS row_difference;


-- 3. SILVER DATA VALIDATION

SELECT
    COUNT(*) AS total_rows,
    COUNT_IF(order_id IS NULL) AS null_order_ids,
    COUNT_IF(order_date IS NULL) AS null_order_dates,
    COUNT_IF(sales <= 0 OR sales IS NULL) AS invalid_sales,
    COUNT_IF(quantity <= 0 OR quantity IS NULL) AS invalid_quantity,
    COUNT_IF(profit IS NULL) AS null_profit
FROM retail_sales_sdp.default.silver_sales;


-- 4. SILVER DUPLICATE CHECK

SELECT
    order_id,
    product_id,
    COUNT(*) AS duplicate_count
FROM retail_sales_sdp.default.silver_sales
GROUP BY order_id, product_id
HAVING COUNT(*) > 1;


-- 5. BRONZE DATA VALIDATION

SELECT *
FROM retail_sales_sdp.default.bronze_sales
LIMIT 10;


-- 6. GOLD MONTHLY SALES VALIDATION

SELECT
    SUM(total_sales) AS gold_total_sales,
    SUM(total_profit) AS gold_total_profit,
    SUM(total_quantity) AS gold_total_quantity,
    SUM(order_count) AS gold_order_line_count
FROM retail_sales_sdp.default.gold_monthly_sales_trends;


-- 7. GOLD PRODUCT PERFORMANCE VALIDATION

SELECT
    SUM(total_sales) AS product_total_sales,
    SUM(total_profit) AS product_total_profit,
    SUM(total_quantity_sold) AS product_total_quantity
FROM retail_sales_sdp.default.gold_product_performance;


-- 8. SILVER VS GOLD KEY TOTAL RECONCILIATION

SELECT
    (SELECT SUM(sales)
     FROM retail_sales_sdp.default.silver_sales)
     AS silver_sales,

    (SELECT SUM(total_sales)
     FROM retail_sales_sdp.default.gold_monthly_sales_trends)
     AS gold_monthly_sales,

    (SELECT SUM(total_sales)
     FROM retail_sales_sdp.default.gold_product_performance)
     AS gold_product_sales;


-- 9. GOLD DATA QUALITY SUMMARY

SELECT *
FROM retail_sales_sdp.default.gold_data_quality_summary;


-- 10. GOLD TABLE DUPLICATE CHECK

SELECT
    order_year,
    order_month,
    COUNT(*) AS duplicate_count
FROM retail_sales_sdp.default.gold_monthly_sales_trends
GROUP BY order_year, order_month
HAVING COUNT(*) > 1;


-- ============================================================
-- END OF RECONCILIATION VALIDATION QUERIES
-- ============================================================
