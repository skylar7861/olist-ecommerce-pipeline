############################################
# terraform/variables.tf
# Purpose: Define input variables + defaults + validation (prevents bad names)
############################################

variable "location" {
  # Data type of the variable
  type = string

  # Human-readable description (helps documentation and prompts)
  description = "Azure region (e.g., eastus)"

  # Default region so Terraform won't prompt unless you override it
  default = "eastus"
}

variable "rg_name" {
  # Resource Group name is a string
  type = string

  # Description for clarity
  description = "Resource group name"

  # Default RG name for your project
  default = "rg-olist-dev"
}

variable "storage_account_name" {
  # Storage account name is a string
  type = string

  # Explain Azure constraints (globally unique, lowercase, 8-24 chars, letters/numbers only)
  description = "Globally unique storage account name (lowercase, 8-24 chars, letters/numbers only)"

  # Validate the string against Azure naming rules at plan/apply time
  validation {
    # Regex enforces: lowercase letters/numbers only, length between 8 and 24
    condition = can(regex("^[a-z0-9]{8,24}$", var.storage_account_name))
    # Error message shown if validation fails
    error_message = "storage_account_name must be 8-24 chars, lowercase letters/numbers only."
  }
}

variable "container_name" {
  # Container name is a string
  type = string

  # Describe purpose
  description = "Container name for the data lake"

  # Default container name we use throughout the project
  default = "datalake"
}

variable "tags" {
  # Tags are key/value pairs in Azure, represented as a map in Terraform
  type = map(string)

  # Describe why tags matter
  description = "Standard tags applied to all resources for cost tracking and ownership"

  # Default tags (customize owner/env if you want)
  default = {
    # Identifies the project for filtering in the Azure portal
    project = "olist-ecommerce"

    # Indicates the resource is managed by Terraform (good for governance)
    managed_by = "terraform"

    # Environment label (dev for this capstone)
    env = "dev"
  }
}
