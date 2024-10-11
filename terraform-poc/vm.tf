
# data "azurerm_subscription" "current" {
# }

# output "current_subscription_display_name" {
#   value = data.azurerm_subscription.current.display_name
# }

provider "azurerm" {
  features { }
  subscription_id = "1901eaa9-e98f-49b6-ac39-b1cd55defe19"
  client_id = "8ffb45ea-f66a-4e7d-883e-42e9544e0206"
  tenant_id = "72f988bf-86f1-41af-91ab-2d7cd011db47"
  use_oidc =true 
}


data "azurerm_resource_group" "example" {
  name = "Test_VM"
}

data "azurerm_virtual_network" "example-vnet" {
  name                = "v-network"
  resource_group_name = data.azurerm_resource_group.example.name

}

data "azurerm_subnet" "example" {
  name                 = "subnet1"
  virtual_network_name = data.azurerm_virtual_network.example-vnet.name
  resource_group_name  = data.azurerm_resource_group.example.name
}


data "azurerm_shared_image" "example-sig" {
  name                = "windDc2022"
  gallery_name        = "AzurepackerImages"
  resource_group_name = "rg-packer-acg"
  #version             = "1.0.0"
}

resource "azurerm_network_interface" "example-nic" {
  name                = "packervmtest-nic"
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "example-vm" {
  name                = "packervmtest"
  resource_group_name = data.azurerm_resource_group.example.name
  location            = data.azurerm_resource_group.example.location
  size                = "Standard_D2s_v3"
  admin_username      = "adminuser"
  admin_password      = "Welcome#2024"
  network_interface_ids = [
    azurerm_network_interface.example-nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

    source_image_id = data.azurerm_shared_image.example-sig.id

     
}
