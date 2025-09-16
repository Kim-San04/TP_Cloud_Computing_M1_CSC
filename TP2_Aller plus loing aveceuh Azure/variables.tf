variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VM"
}

variable "public_key_path" {
  type        = string
  description = "Path to your SSH public key"
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
}

variable "storage_account_name" {
  type        = string
  description = "Name of the Storage Account"
}

variable "storage_container_name" {
  type        = string
  description = "Name of the Storage Container"
}

variable "alert_email_address" {
  type        = string
  description = "Email address to receive alerts"
}