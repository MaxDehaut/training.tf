terraform {

  required_version = ">= 0.15"

  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }

  }

  # Service Principal
  backend "azurerm" {
    resource_group_name  = "rgTfTraining"
    storage_account_name = "satftraining1127123022"
    container_name       = "sctftraining"
    key                  = "terraform.tfstate"
    #    access_key           = "$(StorageAccountAccessKey)"
  }

}

variable "location" {
  type    = string
  default = "WestEurope"
}
variable "costalloc" {
  type = string
}
variable "resource_group_name" {
  type    = string
  default = "rgTfTraining"
}

provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "rgtf" {
  name     = "${var.resource_group_name}-${terraform.workspace}"
  location = var.location

  tags = {
    "environment" = terraform.workspace
    "costalloc"   = (terraform.workspace == "dev") ? "it-dev" : "it-op"
  }
}
