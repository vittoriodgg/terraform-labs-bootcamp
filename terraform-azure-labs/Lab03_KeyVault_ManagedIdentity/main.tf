# TODO: completa questo file durante il lab.
# Usa questo spazio per scrivere la configurazione Terraform richiesta dalla traccia.terraform {


terraform {
    required_version = ">=1.4"


    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~>3.0"
        }
      

    }
  
}

//resource group
data "azurerm_resource_group" "rg" {
    name = var.resource_group_name
}


// 


resource "azurerm_virtual_network" "vnet"{
name = local.vnet_name
address_space = var.vnet_addr_space
location = data.azurerm_resource_group.rg.location
resource_group_name = data.azurerm_resource_group.rg.name
tags = local.common_tags

}


resource "azurerm_subnet" "subnets" {
    for_each = var.vm_map.subnet_map
    name = each.value.name
    resource_group_name = data.azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = [each.value.address_prefix]
  
}



// VM e NIC

resource "azurerm_linux_virtual_machine" "vm" {
    for_each = var.vm_map
    name = each.value.name
    resource_group_name = data.azurerm_resource_group.rg.name
    location = data.azurerm_resource_group.rg.location
    size = each.value.size
    admin_username = each.value.admin_username
    admin_password = each.value.admin_password
    network_interface_ids = [azurerm_network_interface.vm_nic.id]
    disable_password_authentication = false
    
    os_disk {
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
        disk_size_gb = 1

    }
    source_image_reference {
        publisher = "Canonical"
        offer = "0001-com-ubuntu-server-jammy"
        version = "latest"
        sku = "22_04-lts-gen2"
    }
    tags = local.common_tags

    //Identity System assigned
    identity {
        type = "SystemAssigned"
      
    }

}


resource "azurerm_network_interface" "vm_nics" {
    for_each = var.vm_map
    name = "${each.value.name}-nic"
    resource_group_name = data.azurerm_resource_group.rg.name
    location = data.azurerm_resource_group.rg.location
    ip_configuration {
        name = "${each.value.name}-internal"
        subnet_id = azurerm_subnet.subnets[each.value.subnet_key].id
        private_ip_address_allocation = "Dynamic"

        
    }
    tags = local.common_tags
}

// Creazione Key Vault


resource "azurerm_key_vault" "kv" {
    name = var.keyvault_name
    resource_group_name = data.azurerm_resource_group.rg.name
    location = data.azurerm_resource_group.rg.location
    tenant_id = data.azurerm_client_config.current.tenant_id // serve per abilitare l'accesso al KV alla MI della VM
    sku_name = "standard"
    tags = local.common_tags
    enable_rbac_authorization = true
    public_network_access_enabled = false
    lifecycle {
      prevent_destroy = true
    }
    purge_protection_enabled      = true  # impedisce purge anche agli admin
    soft_delete_retention_days    = 10    # periodo di retention per il soft delete
}


// creazione PE e Private DNS Zone

// Creazione della private DNS zone per lo storage account
resource "azurerm_private_dns_zone" "dns_zones"{
    for_each = var.private_dns_zone_map
    name = each.value.name
    resource_group_name = data.azurerm_resource_group.rg.name
    tags = local.common_tags

    
}

// Collegamento della private DNS zone al virtual network

resource "azurerm_private_dns_zone_virtual_network_link" "dns_vnet_links" {
    for_each = var.private_dns_zone_map
    name = "${local.prefix}-${each.key}-link"
    resource_group_name = data.azurerm_resource_group.rg.name
    private_dns_zone_name = azurerm_private_dns_zone.dns_zones[each.key].name
    virtual_network_id = azurerm_virtual_network.vnet.id
    tags = local.common_tags

}


// Creazione del private endpoint per il Key Vault
resource "azurerm_private_endpoint" "kv_pe" {
    
 name = "${local.prefix}-kv-pe"
 location = data.azurerm_resource_group.rg.location
    resource_group_name = data.azurerm_resource_group.rg.name
    subnet_id = azurerm_subnet.pe_subnet.id
    private_service_connection {
      name = "psc-kv"
      is_manual_connection = false
      subresource_names = ["vault"]
      private_connection_resource_id = azurerm_key_vault.kv.id

    }
    private_dns_zone_group {
      name = "dns-zone-group-kv"
        private_dns_zone_ids = [azurerm_private_dns_zone.dns_zones["kv"].id]
    }

  
}





// creiamo Private Endpoint e Private DNS Zone per il Key Vault











