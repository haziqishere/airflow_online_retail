-- Create the fact table by joining the relevant keys from dimension tables
WITH fct_invoices_cte AS (
    SELECT
        InvoiceNo AS invoice_id,
        InvoiceDate AS datetime_id,
        {{ dbt_utils.generate_surrogate_key(['StockCode', 'Description', 'UnitPrice']) }} AS product_id,
        {{ dbt_utils.generate_surrogate_key(['CustomerID', 'Country']) }} AS customer_id,
        Quantity AS quantity,
        Quantity * UnitPrice AS total
    FROM 
        {{ source('retail', 'raw_invoices') }}
    WHERE 
        Quantity > 0
)
SELECT
    fi.invoice_id,
    dt.datetime_id,
    dp.product_id,
    dc.customer_id,
    fi.quantity,
    fi.total
FROM 
    fct_invoices_cte fi
INNER JOIN {{ ref('dim_datetime') }} dt ON fi.datetime_id = dt.datetime_id
INNER JOIN {{ ref('dim_product') }} dp ON fi.product_id = dp.product_id
INNER JOIN {{ ref('dim_customer') }} dc ON fi.customer_id = dc.customer_id;
