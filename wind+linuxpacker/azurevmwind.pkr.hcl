source "azure-arm" "windowsimage-2019" {
  #Tags
  azure_tags = {
    environment = "dev"
    owner       = "Phaneendra_r"
    email       = "v-pratnakara@microsoft.com"
    purpose     = "Infra Deployment"
    task        = "packerimages"
  }

  ##Source Images details###
  os_type         = "Windows"
  image_offer     = "WindowsServer"
  image_publisher = "MicrosoftWindowsServer"
  image_sku       = "2019-datacenter-gensecond"
  vm_size         = "Standard_D2s_v3"
  communicator    = "winrm"
  winrm_use_ssl   = true
  winrm_timeout   = "10m"
  winrm_insecure  = true
  winrm_username  = "packer"
  temp_compute_name = "win2019-vm-poc"
  temp_nic_name     = "win2019-nic-poc"
  build_resource_group_name = "Test_VM"
  temp_os_disk_name  = "win2019-osdisk-poc"
  #skip_create_build_key_vault = true

  #Define the network 
  virtual_network_resource_group_name = "Test_VM"
  virtual_network_name                = "v-network"
  virtual_network_subnet_name         = "subnet1"


  ### Build Image publish to Target Azure compute galleries###
  shared_image_gallery_destination {
    subscription   = "1901eaa9-e98f-49b6-ac39-b1cd55defe19"
    gallery_name   = "AzurepackerImages"
    image_name     = "win2019dcx64"
    image_version  = "${formatdate("YYYY.MMDD.hhmm", timestamp())}"
    resource_group = "rg-packer-acg"
  }
}

source "azure-arm" "windowsimage-2022" {
  #Tags
  azure_tags = {
    environment = "dev"
    owner       = "Phaneendra_r"
    email       = "v-pratnakara@microsoft.com"
    purpose     = "Infra Deployment"
    task        = "packerimages"
  }

  ##Source Images details###
  os_type         = "Windows"
  image_offer     = "WindowsServer"
  image_publisher = "MicrosoftWindowsServer"
  image_sku       = "2022-datacenter-smalldisk-g2"
  vm_size         = "Standard_D2s_v3"
  communicator    = "winrm"
  winrm_use_ssl   = true
  winrm_timeout   = "10m"
  winrm_insecure  = true
  winrm_username  = "packer"

  #Define the network 
  virtual_network_resource_group_name = "Test_VM"
  virtual_network_name                = "v-network"
  virtual_network_subnet_name         = "subnet1"
  temp_compute_name = "win22-vm-poc"
  temp_nic_name     = "packerwin2022-nic-poc"
  build_resource_group_name = "Test_VM"
  temp_os_disk_name  = "packerwin2022-osdisk-poc"

  ### Build Image publish to Target Azure compute galleries###
  shared_image_gallery_destination {
    subscription   = "1901eaa9-e98f-49b6-ac39-b1cd55defe19"
    gallery_name   = "AzurepackerImages"
    image_name     = "win2022dcx64"
    image_version  = "${formatdate("YYYY.MMDD.hhmm", timestamp())}"
    resource_group = "rg-packer-acg"
  }
}

source "azure-arm" "rhel_image" {

  #   #Tags
  azure_tags = {
    environment = "dev"
    owner       = "Phaneendra_r"
    email       = "v-pratnakara@microsoft.com"
    purpose     = "Infra Deployment"
    task        = "packerimages"
    osverison   = "RedhatLinux"
  }

  # Specify the base image
  vm_size             = "Standard_B2s"
  os_type             = "Linux"
  image_publisher     = "RedHat"
  image_offer         = "RHEL"
  image_sku           = "8-lvm-gen2"
  image_version       =  "latest" # Adjust for the RHEL version and generation you need
  os_disk_size_gb     =  128
  managed_image_storage_account_type = "Premium_LRS"
  #os_disk_type = "Premium_LRS"
  communicator        = "ssh"
  ssh_username        = "packerlinux"
  ssh_clear_authorized_keys  = true
  ssh_port  =  22
  temp_compute_name = "packerlinux-vm-poc"
  temp_nic_name     = "packerlinux-nic-poc"
  build_resource_group_name = "Test_VM"
  temp_os_disk_name  = "packerlinux-osdisk-poc"

  #Define the network
  virtual_network_resource_group_name = "Test_VM"
  virtual_network_name                = "v-network"
  virtual_network_subnet_name         = "subnet1"

 ## Build Image publish to Target Azure compute galleries###

  shared_image_gallery_destination {
    subscription   = "1901eaa9-e98f-49b6-ac39-b1cd55defe19"
    gallery_name   = "AzurepackerImages"
    image_name     = "linux8x64"
    #image_version  = "4.0.0"
    image_version = formatdate("YYYY.MMDD.hhmm", timestamp())
    resource_group = "rg-packer-acg"
  }

}