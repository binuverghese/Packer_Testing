source "azure-arm"  "windowsimage" {

    # Service Principal Authentication
    # client_id        = var.client_id
    # client_secret    = var.client_secret
    ##subscription_id  = "1901eaa9-e98f-49b6-ac39-b1cd55defe1"
    #tenant_id        = "72f988bf-86f1-41af-91ab-2d7cd011db47"

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
    image_sku       =  "2019-datacenter-gensecond"
    vm_size         =  "Standard_D2s_v3"
    communicator    = "winrm"
    winrm_use_ssl   = true
    winrm_timeout   = "10m"
    winrm_insecure  = true
    winrm_username  = "packer"

    #Define the network 
    virtual_network_resource_group_name = "Test_VM"
    virtual_network_name = "v-network"
    virtual_network_subnet_name = "subnet1"
    #private_virtual_network_with_public_ip= true

    ##Sourece Image Output details##
    location = "West US"
    # managed_image_name = "azurewindata2019"
    # managed_image_resource_group_name = "Test_VM"


    ### Build Image publish to Target Azure compute galleries###

    shared_image_gallery_destination {
        subscription = "1901eaa9-e98f-49b6-ac39-b1cd55defe19"
        gallery_name    = "AzurepackerImages"
        image_name      = "windDc2022" 
        image_version   = "1.1.0" ##${formatdate("YYYY.MMDD.hhmm", timestamp())}"
        resource_group  = "rg-packer-acg"
    }  

}