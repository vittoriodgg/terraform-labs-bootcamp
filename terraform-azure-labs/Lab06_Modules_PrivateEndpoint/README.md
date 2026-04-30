# Lab 06 - Moduli Private Endpoint

## Obiettivo
Creare un modulo riutilizzabile per Private Endpoint e usarlo per Key Vault e Storage Account.

## Architettura
Modulo modules/private_endpoint -> Private Endpoint -> Private DNS Zone -> VNet Link -> record A.

## Prerequisiti
- Terraform >= 1.0
- Azure CLI installato e autenticato
- Subscription Azure attiva
- Backend remoto Azure Blob Storage disponibile, se vuoi usare state remoto

## Istruzioni
1. Inizializza Terraform
2. Controlla il piano
3. Applica
4. Verifica nel portale Azure
5. Distruggi le risorse

## Comandi
``bash
terraform init
terraform validate
terraform plan
terraform apply
terraform destroy
``

## Concetti chiave
- modulo Private Endpoint
- input private_connection_resource_id, subresource_name, dns_zone_name
- DNS privato
- output private_endpoint_id e private_ip

## Output attesi
Dopo il completamento dovrai ottenere ID e IP privati dei Private Endpoint di Key Vault e Storage.

## Traccia del lab
- Crea modules/private_endpoint.
- Usa il modulo per Key Vault con subresource vault e zona privatelink.vaultcore.azure.net.
- Usa il modulo per Storage Account con subresource blob e zona privatelink.blob.core.windows.net.