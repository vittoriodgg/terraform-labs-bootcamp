# Lab 08 - Hub & Spoke completo

## Obiettivo
Costruire un architettura Hub & Spoke enterprise usando moduli riutilizzabili.

## Architettura
Hub VNet con Bastion e subnet endpoints -> Spoke1 frontend/backend -> Spoke2 aks -> peering Hub-Spoke -> Key Vault privato nel Hub.

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
- riuso modulo vnet
- riuso modulo private_endpoint
- Hub & Spoke
- Azure Bastion
- Key Vault con prevent_destroy
- output sensibili

## Output attesi
Dopo il completamento dovrai ottenere tutti i vnet_id, subnet_ids e key_vault_uri.

## Traccia del lab
- Riusa concettualmente modules/vnet dal Lab05 e modules/private_endpoint dal Lab06.
- Crea Hub con AzureBastionSubnet e subnet-endpoints.
- Crea Spoke1 con frontend/backend e Spoke2 con aks /22.
- Crea peering Hub-Spoke1 e Hub-Spoke2.
- Crea Key Vault nell Hub con Private Endpoint tramite modulo.