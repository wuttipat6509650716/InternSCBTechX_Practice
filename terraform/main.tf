terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    } 
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "exampleTerraform" {
  name     = "example-resources-ssh"
  location = "southeastasia"
}

resource "azurerm_virtual_network" "exampleTerraform" {
  name                = "exampleTerraform-network"
  resource_group_name = azurerm_resource_group.exampleTerraform.name
  location            = azurerm_resource_group.exampleTerraform.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "exampleTerraform" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.exampleTerraform.name
  virtual_network_name = azurerm_virtual_network.exampleTerraform.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "exampleTerraform" {
  name                = "exampleTerraform-public-ip"
  resource_group_name = azurerm_resource_group.exampleTerraform.name
  location            = azurerm_resource_group.exampleTerraform.location
  allocation_method   = "Static"
}

resource "azurerm_network_security_group" "exampleTerraform" {
  name                = "exampleTerraform-nsg"
  location            = azurerm_resource_group.exampleTerraform.location
  resource_group_name = azurerm_resource_group.exampleTerraform.name

  security_rule {
    name                       = "SSH"
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
    name                       = "Allow3000"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Kibana"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5601"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "exampleTerraform" {
  name                = "exampleTerraform-nic"
  location            = azurerm_resource_group.exampleTerraform.location
  resource_group_name = azurerm_resource_group.exampleTerraform.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.exampleTerraform.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.exampleTerraform.id
  }
}

resource "azurerm_network_interface_security_group_association" "exampleTerraform" {
  network_interface_id      = azurerm_network_interface.exampleTerraform.id
  network_security_group_id = azurerm_network_security_group.exampleTerraform.id
}

resource "azurerm_linux_virtual_machine" "exampleTerraform" {
  name                  = "exampleTerraform-vm"
  resource_group_name   = azurerm_resource_group.exampleTerraform.name
  location              = azurerm_resource_group.exampleTerraform.location
  size                  = "Standard_B2s"
  admin_username        = "azureuser"
  network_interface_ids = [azurerm_network_interface.exampleTerraform.id]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}

output "public_ip_address" {
  value = azurerm_linux_virtual_machine.exampleTerraform.public_ip_address
}