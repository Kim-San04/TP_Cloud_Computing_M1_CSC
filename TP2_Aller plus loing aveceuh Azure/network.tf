data "http" "my_ip" {
  url = "https://api.ipify.org"
}

resource "azurerm_network_security_group" "main" {
  name                = "vm-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allow_ssh_from_my_ip"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "${data.http.my_ip.response_body}/32"
    destination_address_prefix = "*"
  }

  depends_on = [azurerm_resource_group.main]
}

resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.main.id

  depends_on = [azurerm_network_interface.main]
}