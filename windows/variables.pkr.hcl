variable "client_id" {
  type        = string
  description = "Azure Service Principal App ID."
  sensitive   = true
}

variable "client_secret" {
  type        = string
  description = "Azure Service Principal Secret."
  sensitive   = true
}

variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID."
  sensitive   = true
}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID."
  sensitive   = true
}


variable "image_offer" {
  type    = string
  default = "WindowsServer"
}

variable "image_publisher" {
  type    = string
  default = "MicrosoftWindowsServer"
}

variable "image_sku" {
  type    = string
  #default = " "
}

variable "vm_size" {
  type    = string
  #default = "Standard_D2_v2"
}

variable "winrm_username" {
 type = string
 default = "packer"
 }

 variable "acgallery_name" {
  type    = string
  default = " "
}

variable "acimage_name_definition" {
  type    = string
  default = "WindowsImage"
}

variable "acimage_version_destination" {
  type    = string
  #default = "1.0.0"
}

variable "acresource_group_destination" {
 type = string
}

variable "location" {
 type = string

}

variable "managed_image_name" {

 type = string

}

variable "manged_image_resource_group_name" {
 type = string
}