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
     resource_group_name  = "jp_actions_testing"
     storage_account_name = "jptestact"
     container_name       = "terraform"
  }
}
