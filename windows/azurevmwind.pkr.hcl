source "azure-arm"  "windowsimage" {

    # Service Principal Authentication
    client_id        = var.client_id
    client_secret    = var.client_secret
    subscription_id  = var.subscription_id
    tenant_id        = var.tenant_id

    #Tags
    azure_tag = {
         environment = "dev"
         owner       =  "Phaneendra_r"
         email       =  "v-pratnakara@microsoft.com"
         purpose     =  "Infra Deployment"
         task        = "packerimages"
    }

    ##Source Image details###
     
    image_offer     = var.image_offer
    image_publisher = var.image_publisher
    image_sku       =  var.image_sku
    vm_size         = var.vm_size
    communicator    = "winrm"
    winrm_use_ssl   = true
    winrm_timeout   = "5m"
    winrm_insecure  = true
    winrm_username  = var.winrm_username

    ##Sourece Image Output details##
    location = var.location
    managed_image_name = var.managed_image_name
    manged_image_resource_group_name = var.manged_image_resource_group_name


    ### Build Image publish to Target Azure compute galleries###

    shared_image_gallery_destination {
        subscription_id = var.subscription_id
        gallery_name    = var.acgallery_name
        image_name      = var.acimage_name_definition 
        image_version   = var.acimage_version_destination ##${formatdate("YYYY.MMDD.hhmm", timestamp())}"
        resource_group  = var.acresource_group_destination
    }  

}