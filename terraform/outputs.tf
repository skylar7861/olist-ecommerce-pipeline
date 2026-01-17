############################################
# terraform/outputs.tf
# Purpose: Print useful values after apply (copy/paste into scripts and Databricks)
############################################

output "resource_group_name" {
  # Expose the Resource Group name Terraform created/used
  value = azurerm_resource_group.rg.name

  # Description for readability in output
  description = "Resource group name"
}

output "storage_account_name" {
  # Expose the storage account name Terraform created
  value = azurerm_storage_account.sa.name

  # Description for readability in output
  description = "ADLS Gen2 storage account name"
}

output "container_name" {
  # Expose the container name Terraform created/used
  value = azurerm_storage_container.datalake.name

  # Description for readability in output
  description = "Data lake container name"
}

output "abfss_base_path" {
  # Construct the ABFSS base URI Databricks/Spark uses to access ADLS Gen2
  # Format: abfss://<container>@<storage>.dfs.core.windows.net
  value = "abfss://${azurerm_storage_container.datalake.name}@${azurerm_storage_account.sa.name}.dfs.core.windows.net"

  # Description for readability in output
  description = "Base ABFSS URI for the lake (use in Databricks notebooks)"
}
