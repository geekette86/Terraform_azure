provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
   version = "~>2.0"
   features {}
}

module "network_interface" {
  source = "modules/nic"
  location = "${var.location}"
  rg_name = "${var.rg_name}"
}
module "virtual_machine" {
  source = "modules/vm"
  location = "${var.location}"
  network_interface_id = "${module.network_interface.nic}"
  rg_name = "${var.rg_name}"
  sshkey = "${var.sshkey}"
  username = "${var.username}"

  }

module "load_balancer" {
  source = "modules/lb"
  location = "${var.location}"
  rg_name = "${var.rg_name}"
  subnet_id = "${var.subnet}"
  sshkey = "${var.sshkey}"
}