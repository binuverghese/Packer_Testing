# terraform {
#   required_version = ">= 0.13.0"
#   required_providers {
#     azurerm = {
#       source = "hashicorp/azurerm"
#       version = "3.30.0"
#     }
#   }


#   backend "azurerm" {
#      key = "terraform.tfstate"
#      resource_group_name  = "Test_VM"
#      storage_account_name = "tfstatewells"
#      container_name       = "terraform"
#      use_oidc = true    
#      #use_azuread_auth = true
#   }
# }
