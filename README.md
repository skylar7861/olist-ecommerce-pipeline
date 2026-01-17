# olist-ecommerce-pipeline
Business Question How is Olist’s e-commerce business performing over time, and how do customer payment behavior and order volume change across months?

# Azure + Terraform 
We provisioned an Azure ADLS Gen2 data lake using Terraform.
The storage account has Hierarchical Namespace enabled, which allows Databricks to interact with the lake using directory semantics and optimized Spark I/O.
Terraform ensures the infrastructure is reproducible, version-controlled, and cloud-native, satisfying the IaC requirement of the project.


# files loaded in the storage container
Name                                             Blob Type    Blob Tier    Length    Content Type    Last Modified              Snapshot
-----------------------------------------------  -----------  -----------  --------  --------------  -------------------------  ----------
raw/olist                                        BlockBlob    Hot                                    2026-01-17T20:48:33+00:00
raw/olist/olist_customers_dataset.csv            BlockBlob    Hot          9033957   text/csv        2026-01-17T20:48:45+00:00
raw/olist/olist_geolocation_dataset.csv          BlockBlob    Hot          61273883  text/csv        2026-01-17T20:49:00+00:00
raw/olist/olist_order_items_dataset.csv          BlockBlob    Hot          15438671  text/csv        2026-01-17T20:48:43+00:00
raw/olist/olist_order_payments_dataset.csv       BlockBlob    Hot          5777138   text/csv        2026-01-17T20:49:02+00:00
raw/olist/olist_order_reviews_dataset.csv        BlockBlob    Hot          14451670  text/csv        2026-01-17T20:49:05+00:00
raw/olist/olist_orders_dataset.csv               BlockBlob    Hot          17654914  text/csv        2026-01-17T20:48:39+00:00
raw/olist/olist_products_dataset.csv             BlockBlob    Hot          2379446   text/csv        2026-01-17T20:49:06+00:00
raw/olist/olist_sellers_dataset.csv              BlockBlob    Hot          174703    text/csv        2026-01-17T20:48:33+00:00
raw/olist/product_category_name_translation.csv  BlockBlob    Hot          2613      text/csv        2026-01-17T20:48:33+00:00
2 % 
