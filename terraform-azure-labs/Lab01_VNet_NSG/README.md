# Lab 01 - VNet e NSG

## Obiettivo
Creare Resource Group, VNet, due subnet frontend e backend, e NSG per ogni subnet con regole diverse usando for_each e dynamic block.

## Architettura
Resource Group -> VNet -> subnet frontend/backend -> NSG dedicati -> associazioni subnet/NSG.

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
- locals per prefix e common_tags
- validazione variabili environment e location
- for_each su mappa di oggetti
- dynamic block per regole NSG condizionali
- output vnet_id, subnet_ids, nsg_ids

## Output attesi
Dopo il completamento dovrai ottenere ID della VNet, delle subnet e degli NSG.

## Traccia del lab
- Usa for_each su una mappa di oggetti per creare subnet e NSG.
- Usa dynamic block per creare regole NSG condizionali: solo frontend riceve traffico da internet su porta 443.
- Associa ogni NSG alla sua subnet.
- Usa naming convention tipo-prefix, esempio vnet-dev-italynorth-lab01.