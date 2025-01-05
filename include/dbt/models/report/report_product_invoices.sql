SELECT
    p.product_id,
    p.stock_code,
    p.description,
    SUM(fi.quantity) AS total_quantity_sold
FROM
    {{ ref('fct_invoices') }} AS fi
JOIN
    {{ ref('dim_product') }} AS p 
    ON fi.product_id = p.product_id
GROUP BY
    p.product_id, 
    p.stock_code, 
    p.description
ORDER BY
    total_quantity_sold DESC
LIMIT 10;
