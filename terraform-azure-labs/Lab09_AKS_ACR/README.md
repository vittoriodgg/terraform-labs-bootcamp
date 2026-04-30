# Lab 09 - AKS e ACR

## Obiettivo
Creare AKS cluster privato con ACR, due node pool, Managed Identity e RBAC.

## Architettura
Resource Group -> VNet/subnet AKS -> ACR Premium privato -> Private Endpoint ACR -> AKS privato -> node pool system/app -> AcrPull.

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
- ACR Premium con accesso pubblico disabilitato
- Private Endpoint registry
- AKS private_cluster_enabled
- SystemAssigned identity
- node pool system e app
- network_profile azure/calico
- role_assignment AcrPull
- kube_config sensitive

## Output attesi
Dopo il completamento dovrai ottenere cluster_id, kube_config sensitive e acr_login_server.

## Traccia del lab
- Crea ACR Premium con public_network_access_enabled = false.
- Crea Private Endpoint ACR con subresource registry e DNS privatelink.azurecr.io.
- Crea AKS privato con default_node_pool system e node pool aggiuntivo app.
- Assegna AcrPull alla kubelet_identity del cluster.