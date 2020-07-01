

  variable "subscription_id" {
    type = "string"
  }

  variable "client_id" {
    type = "string"
  }

  variable "client_secret" {
    type = "string"
  }

  variable "tenant_id" {
    type = "string"
  }


  variable "location" {
    type     = "string"
  }

  variable "rg_tag" {
    type    = "string"
    default = "dev"
  }
variable "subnet" {
  type    = "string"
  default = "main"
}
  variable "rg_name" {
    type    = "string"
  }

  variable "vm_count" {
    default  = 1
  }

  variable "vm_image_string" {
    type    = "string"
  }

  variable "vm_size" {
    type    = "string"
    default = "Standard_DS2_v2"
  }

  variable "vm_name" {
    type = "string"
    default = "Nova-dev-Dk-BA"
  }
 variable "username" {
      type = "string"
      default = "novadock"
  }
   variable sshkey {
  default = ""
  description = "Public key used"
}