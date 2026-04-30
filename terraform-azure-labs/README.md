# Terraform Azure Labs

## Descrizione
Repository didattica per esercitarsi con Terraform su Azure. Ogni cartella contiene la traccia del lab e file Terraform vuoti o con TODO, da completare durante l'esercitazione.

## Prerequisiti
- Terraform installato (>= 1.0)
- Azure CLI installato e autenticato
- Subscription Azure attiva
- Storage Account per il backend remoto

## Struttura
- Lab01_VNet_NSG: VNet, subnet, NSG, for_each e dynamic block.
- Lab02_StorageAccount_PrivateEndpoint: Storage Account privato, Private Endpoint e DNS privato.
- Lab03_KeyVault_ManagedIdentity: Key Vault, Private Endpoint, VM e Managed Identity.
- Lab04_VM_Bastion: VM privata accessibile tramite Azure Bastion.
- Lab05_Modules_VNet: modulo riutilizzabile per VNet e peering Hub-Spoke.
- Lab06_Modules_PrivateEndpoint: modulo riutilizzabile per Private Endpoint.
- Lab07_RemoteState: due stack separati collegati tramite remote state.
- Lab08_HubSpoke_Complete: architettura Hub & Spoke enterprise completa.
- Lab09_AKS_ACR: AKS privato con ACR, Private Endpoint e RBAC.

## Ordine consigliato
Segui i lab in ordine numerico, dal Lab01 al Lab09. I lab 05 e 06 introducono i moduli, il Lab07 introduce il remote state, il Lab08 integra più concetti e il Lab09 chiude con AKS e ACR.

## Convenzioni usate
- naming: environment-location-project
- tagging: environment, project, managed_by = "terraform"
- backend: Azure Blob Storage
- autenticazione: Managed Identity (use_msi = true)