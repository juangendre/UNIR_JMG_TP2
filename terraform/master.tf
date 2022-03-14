# Creamos una máquina virtual - Master

resource "azurerm_linux_virtual_machine" "vmMaster" {
    name                = var.resource_prefix
    resource_group_name = azurerm_resource_group.rg.name
    location            = var.location
    size                = var.vm_size_master
    admin_username      = var.ssh_user
    network_interface_ids = [ azurerm_network_interface.nic-master.id ]
    disable_password_authentication = true

    admin_ssh_key {
        username   = var.ssh_user
        public_key = file(var.public_key_path)
    }
	
	os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    plan {
        name      = "centos-8-3-free"
        product   = "centos-8-3-free"
        publisher = "cognosys"
    }

    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-3-free"
        sku       = "centos-8-3-free"
        version   = "latest"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.storage_account.primary_blob_endpoint
    }

    #provisioner "local-exec" {command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u {var.ssh_user} -i '${self.ipv4_address},' --private-key file(var.public_key_path) playbook.yml"}

    tags = {
        environment = var.environment
    }
	
	
}