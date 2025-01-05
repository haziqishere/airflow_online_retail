SELECT
    dt.year,
    dt.month,
    COUNT(DISTINCT fi.invoice_id) AS num_invoices,
    SUM(fi.total) AS total_revenue
FROM
    {{ ref('fct_invoices') }} AS fi
JOIN
    {{ ref('dim_datetime') }} AS dt 
    ON fi.datetime_id = dt.datetime_id
GROUP BY
    dt.year, 
    dt.month
ORDER BY
    dt.year, 
    dt.month;
