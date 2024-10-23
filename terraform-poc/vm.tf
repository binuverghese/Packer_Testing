
 data "azurerm_subscription" "current" {

  }

  data "azurerm_client_config" "current" {}

output "current_subscription_display_name" {
  value = data.azurerm_subscription.current.display_name
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
  name                = "packerimgdemo2-nic"
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "example-vm" {
  name                = "packerimgdemo1"
  resource_group_name = data.azurerm_resource_group.example.name
  location            = data.azurerm_resource_group.example.location
  size                = "Standard_D2s_v3"
  admin_username      =  data.azurerm_key_vault_secret.vm_username.value
  admin_password      =  data.azurerm_key_vault_secret.vm_password.value
  depends_on = [azurerm_key_vault_secret.vm_password, azurerm_key_vault_secret.vm_username]
  network_interface_ids = [
    azurerm_network_interface.example-nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

    source_image_id = data.azurerm_shared_image.example-sig.id
    #depends_on = [azurerm_key_vault_secret.vm_password, azurerm_key_vault_secret.vm_username]

   lifecycle {
    ignore_changes = [
      identity

    ]  
    
     
  }
  

}
# Fetch the existing Key Vault
data "azurerm_key_vault" "kv" {
  name                = "kvpacker01"
  resource_group_name = data.azurerm_resource_group.example.name
  #tenant_id = data.azurerm_client_config.current.tenant_id
  #depends_on = [azurerm_windows_virtual_machine.example-vm]
}

# Grant VM Managed Identity Access to Key Vault
resource "azurerm_key_vault_access_policy" "vm_access_policy" {
  key_vault_id = data.azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_windows_virtual_machine.example-vm.identity[0].principal_id

  secret_permissions = [
    "Get", "List",
  ]
  #depends_on = [azurerm_windows_virtual_machine.example-vm]
}

# Fetch the username and password secrets from Key Vault
data "azurerm_key_vault_secret" "vm_username" {
  name         = "vmUsername"               # Name of the username secret in the Key Vault
  key_vault_id = data.azurerm_key_vault.kv.id
  #depends_on = [azurerm_windows_virtual_machine.example-vm]
}

data "azurerm_key_vault_secret" "vm_password" {
  name         = "vmPassword"               # Name of the password secret in the Key Vault
  key_vault_id = data.azurerm_key_vault.kv.id
  #depends_on = [azurerm_windows_virtual_machine.example-vm]
}

  output "vm_private_ip" {
  description = "The private IP address of the Windows VM"
  value       = azurerm_network_interface.example-nic.private_ip_address
}
