output "LB_frontend" {
  value = "${azurerm_public_ip.my_lb_public_ip.ip_address}"
}

