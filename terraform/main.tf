# Declarar la versión del Azure Resource Manager APIs.
# Tomarla del link: https://registry.terraform.io/providers/hashicorp/azurerm/latest

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.1"
    }
  }
}

# Creación del grupo de recursos.

resource "azurerm_resource_group" "rg" {
    name     =  "${var.prefix}-gruporecursostp-${var.resource_grp}"
    location = var.location

    tags = {
        environment = var.environment
    }

}

# Creacion de la cuenta
resource "azurerm_storage_account" "storage_account" {
    name                     = var.storage_account
    resource_group_name      = azurerm_resource_group.rg.name
    location                 = azurerm_resource_group.rg.location
    account_tier             = "Standard"
    account_replication_type = "LRS"

    tags = {
        environment = var.environment
    }

}