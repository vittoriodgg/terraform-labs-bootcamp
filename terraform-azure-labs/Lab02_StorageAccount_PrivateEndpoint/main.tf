# TODO: completa questo file durante il lab.
# Usa questo spazio per scrivere la configurazione Terraform richiesta dalla traccia.

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




//Vnet

resource "azurerm_virtual_network" "vnet"{
name = local.vnet_name
address_space = var.vnet_addr_space
location = data.azurerm_resource_group.rg.location
resource_group_name = data.azurerm_resource_group.rg.name
tags = local.common_tags

}

//subnet for private endpoint

resource "azurerm_subnet" "pe_subnet"{
    name = local.private_endpoints_subnet_name
    resource_group_name = data.azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = var.private_endpoints_subnet_prefix
}


// Creaiamo un account di storage e disabiliamo l'accesso pubblico
resource "azurerm_storage_account" "storage_account" {
    name = var.storage_account_name
    location = data.azurerm_resource_group.rg.location
    resource_group_name = data.azurerm_resource_group.rg.name
    account_tier = "Standard"
    account_replication_type = "LRS"
    tags = local.common_tags
    network_rules {
        default_action = "Deny"
        bypass = ["AzureServices"]
        virtual_network_subnet_ids = [azurerm_subnet.pe_subnet.id]

      
    }
    public_network_access_enabled = false
    

}





// Creazione della private DNS zone per lo storage account
resource "azurerm_private_dns_zone" "storage_dns_zone"{
    name = var.private_dns_zone_name
    resource_group_name = data.azurerm_resource_group.rg.name
    tags = local.common_tags

    
}

// Creazione del private endpoint per l'account di storage
resource "azurerm_private_endpoint" "storage_pe" {
 name = "${local.prefix}-storage-pe"
 location = data.azurerm_resource_group.rg.location
    resource_group_name = data.azurerm_resource_group.rg.name
    subnet_id = azurerm_subnet.pe_subnet.id
    private_service_connection {
      name = "psc-storage"
      is_manual_connection = false
      subresource_names = ["blob"]
      private_connection_resource_id = azurerm_storage_account.storage_account.id

    }
    private_dns_zone_group {
      name = "dns-zone-group-storage"
        private_dns_zone_ids = [azurerm_private_dns_zone.storage_dns_zone.id]
    }

  
}




// Collegamento della private DNS zone al virtual network
resource "azurerm_private_dns_zone_virtual_network_link" "blob_dns_link" {
    name = "${local.prefix}-blob-dns-link"
    resource_group_name = data.azurerm_resource_group.rg.name
    private_dns_zone_name = azurerm_private_dns_zone.storage_dns_zone.name
    virtual_network_id = azurerm_virtual_network.vnet.id
    tags = local.common_tags
    registration_enabled = false



    
}



/*
VM nella VNet
    ↓
risolve stdigiorgio.blob.core.windows.net
    ↓
Private DNS Zone (privatelink.blob.core.windows.net)
    ↓ (record A creato dal Zone Group)
10.0.3.4
    ↓
Private Endpoint (nella subnet-endpoints)
    ↓
Storage Account (privato, nessun accesso pubblico)
*/


  



