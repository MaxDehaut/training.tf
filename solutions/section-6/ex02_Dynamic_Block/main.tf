terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}
}

variable "ngs_rules" {
  description = "List of NSG rules"
  type        = any
}

resource "azurerm_resource_group" "training" {
  name     = "rgSectionSix"
  location = "West Europe"
}

resource "azurerm_network_security_group" "training" {
  name                = "nsgSectionSix"
  location            = azurerm_resource_group.training.location
  resource_group_name = azurerm_resource_group.training.name

  dynamic "security_rule" {
    for_each = var.ngs_rules
    content {
      name                       = security_rule.value["name"]
      priority                   = security_rule.value["priority"]
      direction                  = security_rule.value["direction"]
      access                     = security_rule.value["access"]
      protocol                   = security_rule.value["protocol"]
      source_port_range          = security_rule.value["source_port_range"]
      destination_port_range     = security_rule.value["destination_port_range"]
      source_address_prefix      = security_rule.value["source_address_prefix"]
      destination_address_prefix = security_rule.value["destination_address_prefix"]
    }

  }

}
