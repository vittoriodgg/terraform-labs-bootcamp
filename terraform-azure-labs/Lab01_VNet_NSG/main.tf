# TODO: completa questo file durante il lab.
# Usa questo spazio per scrivere la configurazione Terraform richiesta dalla traccia.


terraform{
    required_version = ">=1.4"

    required_providers {
         azurerm = {
          source = "hashicorp/azurerm"
          version = "~>3.0"
         }
      
      
    }

}




data "azurerm_client_config" "current" {}
  



//resource group
data "azurerm_resource_group" "existing" {
    name = var.resource_group_name
    
  
}




//vnet

resource "azurerm_virtual_network" "vnet" {
    name                = local.vnet_name
    address_space       = var.vnet_addr_space
    location            = data.azurerm_resource_group.existing.location
    resource_group_name = data.azurerm_resource_group.existing.name
    tags = local.common_tags
}


resource "azurerm_subnet" "subnets"{
    for_each = local.subnet_names
    name = each.key
    resource_group_name = data.azurerm_resource_group.existing.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = each.value
    

}

//creiamo NSG una per frontend e una per backend
resource "azurerm_network_security_group" "nsg" {
    for_each = local.subnet_names
    name = "nsg-${each.key}"
    location = data.azurerm_resource_group.existing.location
    resource_group_name = data.azurerm_resource_group.existing.name
    tags = local.common_tags
     //regole di sicurezza per il frontend e bakend

     dynamic "security_rule"{
        for_each = strcontains(each.key, "frontend") ? tolist(local.nsg_rules["frontend"]) : tolist(local.nsg_rules["backend"])
        content{
            name  = security_rule.value.name
            priority = security_rule.value.priority
            direction = security_rule.value.direction
            access = security_rule.value.access
            protocol = security_rule.value.protocol
            source_address_prefix = lookup(security_rule.value, "source_address_prefix", null)
            source_address_prefixes = lookup(security_rule.value, "source_address_prefixes", null)
            source_port_range = security_rule.value.source_port_range
            destination_address_prefix = security_rule.value.destination_address_prefix
            destination_port_range = security_rule.value.destination_port_range





        }
     }



}


//ASSOCIAZIONE NSG-SUBNET
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_assoc" {
    for_each = local.subnet_names
    subnet_id = azurerm_subnet.subnets[each.key].id
    network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}
        

