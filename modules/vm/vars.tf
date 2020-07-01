variable "vm_name" {
    type = "string"
    default = "Nova-dev-Dk-BA"
  }
 variable "vm_count" {
    default  = 1
  }
variable "vm_size" {
    type    = "string"
    default = "Standard_DS2_v2"
  }
variable "vm_image_string" {
    type = "string"
    default = "OpenLogic/CentOS/7.5/latest"
}

 variable "username" {
      type = "string"
      default = "novadock"
  }
  variable "acc_storage_name" {
      type = "string"
      default = "testoyez"
  }
  variable "os_cont_storage_name" {
      type = "string"
      default = "vhds1"
  }
   variable "data_cont_storage_name" {
      type = "string"
      default = "vhds1"
  }
  
  variable sshkey {
  default = ""
  description = "Public SSH key's path for vm login"
}
 variable "location" {
    type     = "string"
  }
variable network_interface_id {
  default = ""
  description = "Virtual network interface ID"
}

  variable "rg_tag" {
    type    = "string"
    default = "dev"
  }

  variable "rg_name" {
    type    = "string"
  }