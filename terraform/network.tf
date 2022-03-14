# Creación de red
resource "azurerm_virtual_network" "vnJMG" {
    name                = "${var.prefix}-netkubernetes"
    address_space       = ["192.168.0.0/16"]
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    tags = {
        environment = var.environment
    }
}

# Creación de subnet
resource "azurerm_subnet" "subNetJMG" {
    name                   = "${var.prefix}-subnetterraform"
    resource_group_name    = azurerm_resource_group.rg.name
    virtual_network_name   = azurerm_virtual_network.vnJMG.name
    address_prefixes       = ["192.168.1.0/24"]

}

# Create NIC - Master
resource "azurerm_network_interface" "nic-master" {
  name                = "${var.prefix}-vmnicmaster"  
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "ipvmmaster"
    subnet_id                      = azurerm_subnet.subNetJMG.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = "192.168.1.110"
    public_ip_address_id           = azurerm_public_ip.publicIpMasterJMG.id
  }

    tags = {
        environment = var.environment
    }

}

# IP pública - Master
resource "azurerm_public_ip" "publicIpMasterJMG" {
  name                = "${var.prefix}-vmpublicipmaster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

    tags = {
        environment = var.environment
    }

}

# Create NIC - NFS
resource "azurerm_network_interface" "nic-nfs" {
  name                = "${var.prefix}-vmnicnfs"  
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "ipvmnfs"
    subnet_id                      = azurerm_subnet.subNetJMG.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = "192.168.1.115"
    public_ip_address_id           = azurerm_public_ip.publicIpNfsJMG.id
  }

    tags = {
        environment = var.environment
    }

}

# IP pública - NFS
resource "azurerm_public_ip" "publicIpNfsJMG" {
  name                = "${var.prefix}-vmpublicipnfs"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

    tags = {
        environment = var.environment
    }

}


# Create NIC - Worker1
resource "azurerm_network_interface" "nic-worker-1" {
  name                = "${var.prefix}-vmnicworker1"  
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "ipvmworker1"
    subnet_id                      = azurerm_subnet.subNetJMG.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = "192.168.1.111"
    public_ip_address_id           = azurerm_public_ip.publicIpWorker1JMG.id
  }

    tags = {
        environment = var.environment
    }

}

# IP pública - Worker1
resource "azurerm_public_ip" "publicIpWorker1JMG" {
  name                = "${var.prefix}-vmpublicipworker1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

    tags = {
        environment = var.environment
    }

}

# Create NIC - Worker2
resource "azurerm_network_interface" "nic-worker-2" {
  name                = "${var.prefix}-vmnicworker2"  
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "ipvmworker2"
    subnet_id                      = azurerm_subnet.subNetJMG.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = "192.168.1.112"
    public_ip_address_id           = azurerm_public_ip.publicIpWorker2JMG.id
  }

    tags = {
        environment = var.environment
    }

}

# IP pública - Worker2
resource "azurerm_public_ip" "publicIpWorker2JMG" {
  name                = "${var.prefix}-vmpublicipworker2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

    tags = {
        environment = var.environment
    }

}