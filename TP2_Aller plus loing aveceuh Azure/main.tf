provider "azurerm" {
  features {}
  subscription_id = var.subscription_id 
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name    
  location = var.location               
}

resource "azurerm_virtual_network" "main" {
  name                = "vm-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
  depends_on          = [azurerm_resource_group.main]
}

resource "azurerm_subnet" "main" {
  name                 = "vm-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
  depends_on           = [azurerm_virtual_network.main]
}

resource "azurerm_public_ip" "main" {
  name                = "vm-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "vm-label" 
  depends_on          = [azurerm_resource_group.main]
}

resource "azurerm_network_interface" "main" {
  name                = "vm-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }

  depends_on = [azurerm_subnet.main, azurerm_public_ip.main]
}

resource "azurerm_linux_virtual_machine" "main" {
  name                  = "terraform-vm"
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = "Standard_B1s"
  admin_username        = var.admin_username          
  network_interface_ids = [azurerm_network_interface.main.id]

  admin_ssh_key {
    username   = var.admin_username                   
    public_key = file(var.public_key_path)          
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "vm-os-disk"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  identity {
    type = "SystemAssigned"
  }

  depends_on = [azurerm_network_interface_security_group_association.main]
}