# Lab 04 - VM e Azure Bastion

## Obiettivo
Creare VM Linux senza IP pubblico, accessibile solo tramite Azure Bastion.

## Architettura
Resource Group -> VNet -> AzureBastionSubnet -> Public IP Standard -> Bastion -> VM privata.

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
- AzureBastionSubnet con nome fisso
- Public IP Standard Static
- Azure Bastion
- NIC con IP privato Dynamic
- admin_ssh_key con file("~/.ssh/id_rsa.pub")

## Output attesi
Dopo il completamento dovrai ottenere vm_private_ip e bastion_dns_name.

## Traccia del lab
- Crea AzureBastionSubnet con il nome esatto richiesto.
- Crea Bastion collegato al Public IP.
- Crea VM senza Public IP.
- Usa chiave SSH, non password.