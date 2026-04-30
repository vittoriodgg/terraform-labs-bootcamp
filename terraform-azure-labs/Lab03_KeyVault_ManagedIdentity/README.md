# Lab 03 - Key Vault e Managed Identity

## Obiettivo
Creare Key Vault con Private Endpoint, VM con Managed Identity e RBAC per leggere i segreti.

## Architettura
Resource Group -> VNet -> Key Vault privato -> Private Endpoint -> VM Linux con identity SystemAssigned -> role assignment.

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
- data azurerm_client_config
- Key Vault network_acls default_action Deny
- Private Endpoint vault
- Managed Identity SystemAssigned
- role_assignment Key Vault Secrets User
- output sensitive

## Output attesi
Dopo il completamento dovrai ottenere key_vault_uri e vm_principal_id, marcando sensibili gli output opportuni.

## Traccia del lab
- Usa tenant_id da data.azurerm_client_config.
- Crea VM Linux con identity { type = "SystemAssigned" }.
- Assegna Key Vault Secrets User alla Managed Identity della VM.
- Usa prevent_destroy sul Key Vault.