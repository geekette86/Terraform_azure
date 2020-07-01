
#refer to existing subnet
data "azurerm_subnet" "sub" {
  name                 = "main"
  virtual_network_name = "nova-test"
  resource_group_name  = "${var.rg_name}"
}
resource "azurerm_lb" "mylb" {
  name                = "${var.vm_name}.${count.index + 1}-lb"
  location            = "${var.location}"
  resource_group_name = "${var.rg_name}"

  frontend_ip_configuration {
    name                 = "${var.frontend_name}.${count.index + 1}"
    subnet_id                     = "${data.azurerm_subnet.sub.id}"
    private_ip_address            = "${var.private_ip_address}"
    private_ip_address_allocation = "${var.private_ip_address_allocation}"
  }

 tags = "${var.rg_tag}"
}

resource "azurerm_public_ip" "my_lb_public_ip" {
    name                         = "${var.rg_name}publicLBIP"
    location                     = "${var.location}"
    resource_group_name          = "${var.rg_name}"
    allocation_method = "Static"

   tags = "${var.rg_tag}"
}

resource "azurerm_lb_backend_address_pool" "mylb_backend_pool" {
  resource_group_name = "${var.rg_name}"
  loadbalancer_id     = "${azurerm_lb.mylb.id}"
  name                = "${var.vm_name}.${count.index + 1}-BackEndAddressPool"
}

resource "azurerm_lb_probe" "mylb_probe" {
  resource_group_name = "${var.rg_name}"
  loadbalancer_id     = "${azurerm_lb.mylb.id}"
  name                = "${var.probe_params[0]}"
  protocol            = "${var.probe_params[1]}"
  port                = "${var.probe_params[2]}"
  request_path        = "${var.probe_params[3]}"
  interval_in_seconds = "${var.probe_params[4]}"
  number_of_probes    = "${var.probe_params[5]}"
}

resource "azurerm_lb_rule" "mylb_rule" {
  resource_group_name            = "${var.rg_name}"
  loadbalancer_id                = "${azurerm_lb.mylb.id}"
  name                           = "${var.rule_params[0]}"
  protocol                       = "${var.rule_params[1]}"
  frontend_port                  = "${var.rule_params[2]}"
  backend_port                   = "${var.rule_params[3]}"
  enable_floating_ip             = "${var.rule_params[4]}"
  idle_timeout_in_minutes        = "${var.rule_params[5]}"
  frontend_ip_configuration_name = "${var.frontend_name}"
  backend_address_pool_id        = "${azurerm_lb_backend_address_pool.mylb_backend_pool.id}"
  probe_id                       = "${azurerm_lb_probe.mylb_probe.id}"
  depends_on                     = ["azurerm_lb_probe.mylb_probe"]
}

resource "azurerm_lb_nat_pool" "mylb_nat_pool" {
  count                          = "${var.nat_pool_params[0]}"
  name                           = "${var.nat_pool_params[1]}"
  protocol                       = "${var.nat_pool_params[2]}"
  frontend_port_start            = "${var.nat_pool_params[3]}"
  frontend_port_end              = "${var.nat_pool_params[4]}"
  backend_port                   = "${var.nat_pool_params[5]}"
  resource_group_name            = "${var.rg_name}"
  loadbalancer_id                = "${azurerm_lb.mylb.id}"
  frontend_ip_configuration_name = "${var.frontend_name}"
}