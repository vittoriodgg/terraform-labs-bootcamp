# Lab 02 - Storage Account e Private Endpoint

## Obiettivo
Creare Storage Account con accesso pubblico disabilitato e Private Endpoint nella subnet dedicata.

## Architettura
Resource Group -> VNet -> subnet-endpoints -> Storage Account privato -> Private Endpoint -> Private DNS Zone e record A.

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
- Storage Account privato
- Private Endpoint blob
- Private DNS Zone privatelink.blob.core.windows.net
- VNet Link
- lifecycle prevent_destroy

## Output attesi
Dopo il completamento dovrai ottenere storage_account_id e private_endpoint_ip.

## Traccia del lab
- Crea una subnet-endpoints separata nella VNet.
- Disabilita public_network_access_enabled nello Storage Account.
- Usa subresource_names = ["blob"].
- Crea DNS Zone, VNet Link e record A verso IP privato del Private Endpoint.