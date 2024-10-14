
# data "azurerm_subscription" "current" {
# }

# output "current_subscription_display_name" {
#   value = data.azurerm_subscription.current.display_name
# }


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
  name                = "packerimagevm-nic"
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "example-vm" {
  name                = "packerimagevm"
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

# resource "null_resource" "check_file" {
#   provisioner "remote-exec" {
#     inline = [
#       "powershell -Command \"if (Test-Path 'D:\\DATALOSS_WARNING_README.txt') { Write-Output 'File exists.' } else { Write-Output 'File does not exist.' }\""
#     ]
 
#     connection {
#       type        = "winrm"
#       host        = azurerm_windows_virtual_machine.example-vm.private_ip_address
#       user        = "adminuser"  # Replace with your VM's admin username
#       password    = "Welcome#2024"   # Replace with your VM's admin password
#       https       = false
#       port        = 5985  # Use 5986 if WinRM is configured for HTTPS
#     }
#   }
# }
 
# output "file_check_result" {
#   value = null_resource.check_file.*.id
# }
