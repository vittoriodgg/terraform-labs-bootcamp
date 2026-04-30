# TODO: completa questo file durante il lab.
# Usa questo spazio per scrivere la configurazione Terraform richiesta dalla traccia.

output "storage_account_id" {
    description = "ID of the storage account"
    value       = azurerm_storage_account.storage_account.id
  
}
output "private_endpoint_id" {
    description = "ID of the private endpoint"
    value       = azurerm_private_endpoint.storage_pe.id
  
}