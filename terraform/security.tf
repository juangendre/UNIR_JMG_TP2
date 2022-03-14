# Security group
resource "azurerm_network_security_group" "securityGroupjmg" {
    name                = "${var.prefix}-sshtraffic"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    security_rule {
        name                       = "${var.prefix}-SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
    
    security_rule {
        name                       = "${var.prefix}-1"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "6443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
    
    security_rule {
        name                       = "${var.prefix}-2"
        priority                   = 1003
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "2379-2380"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "${var.prefix}-3"
        priority                   = 1004
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "10245-10255"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "${var.prefix}-4"
        priority                   = 1005
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "30000-32767"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "${var.prefix}-5"
        priority                   = 1006
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "8080-8085"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "${var.prefix}-6"
        priority                   = 1007
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "25000-65000"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

        security_rule {
        name                       = "${var.prefix}-7"
        priority                   = 1008
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "5556-5558"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = var.environment
    }
}

# Vinculamos el security group al interface de red - Master
resource "azurerm_network_interface_security_group_association" "securityGroupAsocMasterjmg" {
    network_interface_id      = azurerm_network_interface.nic-master.id
    network_security_group_id = azurerm_network_security_group.securityGroupjmg.id

}

# Vinculamos el security group al interface de red - Nfs
resource "azurerm_network_interface_security_group_association" "securityGroupAsocNfsjmg" {
    network_interface_id      = azurerm_network_interface.nic-nfs.id
    network_security_group_id = azurerm_network_security_group.securityGroupjmg.id

}

# Vinculamos el security group al interface de red - Worker1
resource "azurerm_network_interface_security_group_association" "securityGroupAsocWorker1jmg" {
    network_interface_id      = azurerm_network_interface.nic-worker-1.id
    network_security_group_id = azurerm_network_security_group.securityGroupjmg.id

}

# Vinculamos el security group al interface de red - Worker2
resource "azurerm_network_interface_security_group_association" "securityGroupAsocWorker2jmg" {
    network_interface_id      = azurerm_network_interface.nic-worker-2.id
    network_security_group_id = azurerm_network_security_group.securityGroupjmg.id

}