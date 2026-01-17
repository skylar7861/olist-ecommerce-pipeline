############################################
# terraform/main.tf
# Purpose: Provision an Azure Resource Group + ADLS Gen2 Storage Account + private Container
############################################

terraform {
  # Declare which providers Terraform must download to manage infrastructure
  required_providers {
    azurerm = {
      # Provider source address in the Terraform Registry
      source = "hashicorp/azurerm"
      # Constrain to a stable major version range for reproducibility
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  # Required by the AzureRM provider; enables provider features with defaults
  features {}
}

resource "azurerm_resource_group" "rg" {
  # Name of the Resource Group (logical container for Azure resources)
  name = var.rg_name

  # Azure region where the Resource Group (and typically resources) will live
  location = var.location

  # Apply tags for cost tracking / ownership / governance (from variables)
  tags = var.tags
}

resource "azurerm_storage_account" "sa" {
  # Globally-unique storage account name (Azure requirement)
  name = var.storage_account_name

  # Link the storage account to the Resource Group created above
  resource_group_name = azurerm_resource_group.rg.name

  # Deploy storage account in the same region as the Resource Group
  location = azurerm_resource_group.rg.location

  # Use the Standard tier (cost-effective, sufficient for this project)
  account_tier = "Standard"

  # Use Locally Redundant Storage (lowest cost; fine for a capstone)
  account_replication_type = "LRS"

  # Enable Hierarchical Namespace (HNS) to make it ADLS Gen2 (required for lake patterns)
  is_hns_enabled = true

  # Require modern TLS for encryption-in-transit
  min_tls_version = "TLS1_2"

  # Prevent accidentally making blobs public through nested items
  allow_nested_items_to_be_public = false

  # Apply the same tagging strategy to the storage account for governance
  tags = var.tags
}

resource "azurerm_storage_container" "datalake" {
  # Container name (acts like the root folder of your lake)
  name = var.container_name

  # Attach this container to the storage account created above
  storage_account_name = azurerm_storage_account.sa.name

  # Keep container private; access is controlled by Azure RBAC (recommended)
  container_access_type = "private"
}
