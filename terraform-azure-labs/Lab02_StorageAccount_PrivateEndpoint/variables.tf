# TODO: completa questo file durante il lab.
# Usa questo spazio per scrivere la configurazione Terraform richiesta dalla traccia.



variable "environment" {
    description = "Environment name (e.g. dev, test, prod)"
    type        = string
    default     = "dev"
    validation {
        condition = contains(["dev", "staging", "prod"], var.environment)
        error_message  = "Environment must be one of: dev, staging, prod."
    }
}


variable "resource_group_name" {
    description = "Name of the resource group to create"
    type        = string
  
}


variable "vnet_name" {
    description = "Name of the virtual network to create"
    type        = string
  
}
variable "vnet_addr_space" {
    description = "Address space for the virtual network"
    type        = list(string)
  
}

variable "private_endpoints_subnet_name" {
    description = "Name of the subnet for private endpoints"
    type        = string
  
}
variable "private_endpoints_subnet_prefix" {
    description = "Address prefix for the subnet used by private endpoints"
    type        = list(string)
  

}

variable private_dns_zone_name {
    description = "Name of the private DNS zone to create"
    type        = string
    default     = "privatelink.blob.core.windows.net"
}


variable "storage_account_name" {
    description = "Name of the storage account to create"
    type        = string
    default     = "storageaccount01"
}