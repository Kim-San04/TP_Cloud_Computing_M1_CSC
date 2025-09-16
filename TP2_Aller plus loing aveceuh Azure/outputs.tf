output "vm_public_ip" {
  value = azurerm_public_ip.main.ip_address
}

output "vm_dns_name" {
  value = azurerm_public_ip.main.fqdn
}

output "vault_secret_value" {
  value = azurerm_key_vault_secret.vault_secret.value
  sensitive = true
}