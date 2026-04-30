# Lab 07 - Remote State

## Obiettivo
Simulare due stack separati che si leggono tramite remote state.

## Architettura
stack-network crea VNet e subnet. stack-compute legge il tfstate di stack-network e crea una VM nella subnet backend.

## Prerequisiti
- Terraform >= 1.0
- Azure CLI installato e autenticato
- Subscription Azure attiva
- Backend remoto Azure Blob Storage disponibile

## Istruzioni
1. Inizializza Terraform in stack-network
2. Applica stack-network
3. Inizializza Terraform in stack-compute
4. Applica stack-compute
5. Distruggi prima stack-compute e poi stack-network

## Comandi
```bash
cd stack-network
terraform init
terraform validate
terraform plan
terraform apply

cd ../stack-compute
terraform init
terraform validate
terraform plan
terraform apply
terraform destroy

cd ../stack-network
terraform destroy
```

## Concetti chiave
- backend key = "lab07/network.tfstate"
- backend key = "lab07/compute.tfstate"
- terraform_remote_state
- output subnet_backend_id e vnet_id
- dipendenza tra stack separati

## Output attesi
stack-network espone subnet_backend_id e vnet_id. stack-compute usa subnet_backend_id dal remote state per creare la NIC.

## Traccia del lab
- In stack-network crea VNet e subnet, poi esponi subnet_backend_id e vnet_id.
- In stack-compute usa data "terraform_remote_state" per leggere lo stato network.
- Crea la NIC usando subnet_backend_id dal remote state.
- Rispetta l ordine: prima apply stack-network, poi apply stack-compute.