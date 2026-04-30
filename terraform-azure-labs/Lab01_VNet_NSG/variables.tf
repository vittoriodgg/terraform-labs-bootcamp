# TODO: completa questo file durante il lab.
# Usa questo spazio per scrivere la configurazione Terraform richiesta dalla traccia.


variable "environment" {
    description = "Environment for the lab (e.g., dev, test, prod)"
    type = string
    validation {
        condition = contains(["dev", "staging", "prod"], var.environment)
        error_message = "Environment must be one of: dev, staging, prod"
    }
}

//resource group
variable "resource_group_name" {
    description = "Name of the resource group to use for the lab"
    type = string
}

variable "location" {
    description = "Azure region for the resources"
    type = string
    default = "northeurope"
}

variable "vnet_name" {
    description = "Name of the virtual network to create"
    type = string
}
variable "vnet_addr_space" {
    description = "Address space for the virtual network"
    type = list(string)
  
}




variable "subnets_names" {
    description = "Map of subnet names and their address spaces"
    type = map(list(string))
  
}