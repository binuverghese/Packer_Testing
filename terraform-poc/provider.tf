provider "azurerm" {
  features { }
#   subscription_id = "1901eaa9-e98f-49b6-ac39-b1cd55defe19"
#   client_id = "8ffb45ea-f66a-4e7d-883e-42e9544e0206"
#   tenant_id = "72f988bf-86f1-41af-91ab-2d7cd011db47"
  use_oidc =true 
  #use_azuread_auth = true
}

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
     resource_group_name  = "Test_VM"
     storage_account_name = "tfstatewells"
     container_name       = "terraform"
     use_oidc = true    
     #use_azuread_auth = true
  }
}