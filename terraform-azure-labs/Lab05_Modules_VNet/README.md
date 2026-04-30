# Lab 05 - Moduli VNet

## Obiettivo
Creare un modulo riutilizzabile per VNet e usarlo due volte per Hub e Spoke.

## Architettura
Modulo modules/vnet -> Hub VNet -> Spoke VNet -> peering bidirezionale Hub-Spoke.

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
- module source locale
- input name, location, resource_group_name, address_space, subnets, tags
- for_each dentro il modulo
- output vnet_id, vnet_name, subnet_ids
- peering Hub-Spoke

## Output attesi
Dopo il completamento dovrai ottenere hub_vnet_id, spoke_vnet_id, hub_subnet_ids e spoke_subnet_ids.

## Traccia del lab
- Crea modules/vnet.
- Chiama il modulo due volte: Hub 10.0.0.0/16 e Spoke 10.1.0.0/16.
- Crea peering doppio Hub-Spoke con allow_gateway_transit su Hub e use_remote_gateways su Spoke.