### Configure the Plugins for azure 
packer {
 required_version =  ">=1.7.0"
  required_plugins {
    azure = {
      version = ">= 2.1.8"
      source = "github.com/hashicorp/azure"
    }
  }
}
