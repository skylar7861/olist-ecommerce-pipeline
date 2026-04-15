# olist-ecommerce-pipeline
Business Question How is Olist’s e-commerce business performing over time, and how do customer payment behavior and order volume change across months?

# Azure + Terraform 
We provisioned an Azure ADLS Gen2 data lake using Terraform.
The storage account has Hierarchical Namespace enabled, which allows Databricks to interact with the lake using directory semantics and optimized Spark I/O.
Terraform ensures the infrastructure is reproducible, version-controlled, and cloud-native, satisfying the IaC requirement of the project.

## Infrastructure (Terraform)

Terraform provisions the following Azure resources:

- Resource Group: rg-olist-dev
- ADLS Gen2 Storage Account (Hierarchical Namespace enabled)
- Private Blob Container: datalake

The storage account is used as the Bronze/Silver/Gold data lake.

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
#Architecture
Azure Blob/ADLS Gen2 (container: datalake)
  raw/olist/*.csv
        |
        |  (Azure SDK over HTTPS)
        v
Databricks Unity Catalog Volume
  /Volumes/olist/stage/olist_stage/olist_raw/*.csv
        |
        v
Bronze (UC managed Delta, raw columns as STRING)
  olist.bronze.*_raw
        |
        v
Silver (typed/cleaned/deduped)
  olist.silver.*
        |
        v
Gold (aggregated marts)
  olist.gold.*
        |
        v
Databricks SQL Dashboard (multiple tiles)
#Repo setup (VS Code + GitHub)
Repo structure
olist-ecommerce-pipeline/
  notebooks/
    00_ingest_azure_to_volume.py
    01_bronze_ingest.py
    02_silver_transforms.py
    03_gold_marts.py
  sql/
    dashboard_queries.sql
  terraform/
    providers.tf
    variables.tf
    main.tf
    outputs.tf
  README.md
  .gitignore

  <img width="1845" height="941" alt="image" src="https://github.com/user-attachments/assets/0415e708-dfc7-4612-a48a-c848c0c82da4" />


