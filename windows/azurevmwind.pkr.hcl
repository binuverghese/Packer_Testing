source "azure-arm"  "windowsimage" {

    # Service Principal Authentication
    # client_id        = var.client_id
    # client_secret    = var.client_secret
    # subscription_id  = var.subscription_id
    # tenant_id        = var.tenant_id

    #Tags
    azure_tags = {
         environment = "dev"
         owner       =  "Phaneendra_r"
         email       =  "v-pratnakara@microsoft.com"
         purpose     =  "Infra Deployment"
         task        = "packerimages"
    }

    ##Source Images details###
    os_type         = "Windows"
    image_offer     = "WindowsServer"
    image_publisher = "MicrosoftWindowsServer"
    image_sku       =  "2019-Datacenter"
    vm_size         =  "Standard_D2_v2"
    communicator    = "winrm"
    winrm_use_ssl   = true
    winrm_timeout   = "5m"
    winrm_insecure  = true
    winrm_username  = "packer"

    ##Sourece Image Output details##
    location = "West US 2"
    managed_image_name = "azurewindata2019"
    managed_image_resource_group_name = "rg-packerimages-01"


    ### Build Image publish to Target Azure compute galleries###

    # shared_image_gallery_destination {
    #     subscription_id = var.subscription_id
    #     gallery_name    = var.acgallery_name
    #     image_name      = var.acimage_name_definition 
    #     image_version   = var.acimage_version_destination ##${formatdate("YYYY.MMDD.hhmm", timestamp())}"
    #     resource_group  = var.acresource_group_destination
    # }  

}