#refer to existing subnet
#refer to a subnet
data "azurerm_subnet" "sub" {
  name                 = "main"
  virtual_network_name = "nova-test"
  resource_group_name  = "${var.rg_name}"
}

resource "azurerm_network_interface" "nic" {
  name                                  = "${var.vm_name}.${count.index + 1}-nic"
  count                                 = "${var.vm_count}"
  location                              = "${var.location}"
  resource_group_name                   = "${var.rg_name}"

  ip_configuration {
    name                            = "${var.vm_name}.${count.index + 1}-ip"
    subnet_id                       = "${data.azurerm_subnet.sub.id}"
    private_ip_address_allocation   = "static"
    private_ip_address = "100.69.12.93" #example
  }

  tags = "${var.rg_tag}"
}