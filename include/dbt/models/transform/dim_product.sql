-- Create the dimension table
SELECT
    {{ dbt_utils.generate_surrogate_key(['StockCode', 'Description', 'UnitPrice']) }} AS product_id,
    StockCode AS stock_code,
    Description AS description,
    UnitPrice AS price
FROM
    {{ source('retail', 'raw_invoices') }}
WHERE
    StockCode IS NOT NULL
    AND UnitPrice > 0;
