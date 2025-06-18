# main.tf

variable "admin_public_key" {
  description = "Public SSH key for the admin user."
  type        = string
  # sensitive   = true # Optional: uncomment if you want to hide it in logs
}

variable "location" {
  description = "The Azure region to deploy resources."
  default     = "southeastasia"
}