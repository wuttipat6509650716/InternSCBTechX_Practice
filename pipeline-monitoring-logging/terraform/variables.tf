variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" { sensitive = true }
variable "tenant_id" {}

variable "admin_public_key" {
  description = "Public SSH key for the admin user."
  default     = file("~/.ssh/id_rsa.pub")
}

variable "location" {
  description = "The Azure region to deploy resources."
  default     = "southeastasia"
}