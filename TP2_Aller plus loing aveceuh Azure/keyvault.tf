data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "main" {
  name                       = "vault-name"
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    secret_permissions = ["Get", "List", "Set", "Delete", "Purge", "Recover"]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = azurerm_linux_virtual_machine.main.identity[0].principal_id
    secret_permissions = ["Get", "List"]
  }
}

resource "random_password" "vault_secret" {
  length           = 16
  special          = true
  override_special = "@#$%^&*()"
}

resource "azurerm_key_vault_secret" "vault_secret" {
  name         = "secret-name"
  value        = random_password.vault_secret.result
  key_vault_id = azurerm_key_vault.main.id

  depends_on = [azurerm_key_vault.main]
}