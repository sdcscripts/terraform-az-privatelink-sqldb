terraform {
  required_version = "~> 0.12.0"
}

provider "azurerm" {
  version = "~> 1.39.0"
}

resource "azurerm_resource_group" "rgmain" {
  name     = "${var.rg_prefix}-main"
  location = "${var.rg_location}"
}