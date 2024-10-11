terraform {
  required_version = ">= 0.13.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.30.0"
    }
  }


  backend "azurerm" {
     key = "terraform.tfstate"
     use_oidc = true
     use_azuread_auth = true
  }
}