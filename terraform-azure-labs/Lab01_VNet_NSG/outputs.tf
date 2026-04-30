# TODO: completa questo file durante il lab.
# Usa questo spazio per scrivere la configurazione Terraform richiesta dalla traccia.


output "nsg_ids" {
    description = "Ids of the NSGs"
    value={
for k,v in azurerm_network_security_group.nsg :
k => v.id

    }
}

    output subnet_ids {
    description = "Ids of the subnets"
    value = {
        for k,v in azurerm_subnet.subnets :
        k => v.id
    }

  
}