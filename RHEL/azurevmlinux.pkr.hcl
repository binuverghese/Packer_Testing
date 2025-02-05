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
  os_type = "Linux"
  image_publisher = "RedHat"
  image_offer     = "RHEL"
  image_sku       = "8-lvm-gen2" # Adjust for the RHEL version and generation you need
  os_disk_size_gb           =  128
  managed_image_storage_account_type = "Premium_LRS"
  #os_disk_type = "Premium_LRS"
  communicator    = "ssh"
  ssh_username               = "packerlinux"

  ssh_clear_authorized_keys  = false
  ssh_port  =  22



   ##Sourece Image Output details##
 location = "West US"

  #Define the network
  virtual_network_resource_group_name = "Test_VM"
  virtual_network_name                = "v-network"
  virtual_network_subnet_name         = "subnet1"

### Build Image publish to Target Azure compute galleries###

  shared_image_gallery_destination {
    subscription   = "1901eaa9-e98f-49b6-ac39-b1cd55defe19"
    gallery_name   = "AzurepackerImages"
    image_name     = "redhatlinux-img-definition"
    #image_version  = "4.0.0"
    image_version = formatdate("YYYY.MMDD.hhmm", timestamp())
   
    resource_group = "rg-packer-acg"
  }

}