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


variable keyvault_name {
    description = "Name of the Key Vault to create"
    type        = string
  

}
variable keyvault_role {
    description = "Role to assign to the managed identity for Key Vault access"
    type        = string
    default     = "Key Vault Secrets User"

}

variable vm_map{

    description = "Map of Vms to instantiate"
    type = map(object({
        name           = string
        size           = string
        admin_username = string
        admin_password = string
        subnet_key      = string
    }))

}


variable "subnet_maps" {
    description = "Map of subnets to create"
    type = map(object({
        name           = string
        address_prefix  = string
        service_endpoints = optional(list(string) )
    }))
  
}

variable private_dns_zone_map {
    description = "Map of private DNS zones to create"
    type = map(object({
        name = string
    }))
}


