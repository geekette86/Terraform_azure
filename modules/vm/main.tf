resource "azurerm_virtual_machine" "vm" {
  count                 = "${var.vm_count}"
  name                  = "${var.vm_name}+${count.index + 1}"
  location              = "${var.location}"
  resource_group_name   = "${var.rg_name}"
  network_interface_ids = ["${var.network_interface_id}"]
  vm_size               = "${var.vm_size}"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "${element(split("/", var.vm_image_string), 0)}"
    offer     = "${element(split("/", var.vm_image_string), 1)}"
    sku       = "${element(split("/", var.vm_image_string), 2)}"
    version   = "${element(split("/", var.vm_image_string), 3)}"
  }

  storage_os_disk {
    name                = "vm-${count.index + 1}-OS-Disk"
    vhd_uri             = "http://${var.acc_storage_name}.blob.core.windows.net/${var.os_cont_storage_name}/${var.vm_name}.${count.index + 1}-osdisk.vhd"
    caching             = "ReadWrite"
    disk_size_gb        = "30"
    create_option       = "FromImage"
  }

 
  storage_data_disk {
    name                = "vm-${count.index + 1}-Data-Disk"
    vhd_uri             = "http://${var.acc_storage_name}.blob.core.windows.net/${var.data_cont_storage_name}/${var.vm_name}.${count.index + 1}-datadisk.vhd"
    disk_size_gb        = "40"
    create_option       = "Empty"
    lun                 = 0
  }

  os_profile {
    computer_name  = "host${count.index + 1}"
    admin_username = "${var.username}"
    
  }

   os_profile_linux_config {
        disable_password_authentication = true
        ssh_keys {
            path     = "/home/${var.username}/.ssh/authorized_keys"
            key_data = "${file(var.sshkey)}"
        }
    }
 
    tags {
         tags = "${var.rg_tag}"
    }
}