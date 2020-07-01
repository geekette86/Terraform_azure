variable "vm_name" {
    type = "string"
    default = "Nova-dev-Dk-BA"
  }
 variable "vm_count" {
    default  = 1
  }
  variable "subnet_name" {
    type = "string"
    default = "main"
  }
   variable "location" {
    type     = "string"
  }

 variable "rg_tag" {
     type = "map" 
    default = {
        dev = "dev"
    }
  }

  variable "rg_name" {
    type    = "string"
  }