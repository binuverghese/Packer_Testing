terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.4.0"
    }
  }


  backend "azurerm" {
     #key = "terraform.tfstate"
     use_oidc = true
     use_azuread_auth = true
  }
}