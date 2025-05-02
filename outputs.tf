# output "resource_group_id" {
#   value = module.resource_group.id
# }

# output "resource_group_name" {
#   value = module.resource_group.name
# }




output "vault_ids" {
  description = "IDs of all Recovery Services Vaults"
  value       = { for k, v in module.azure_recovery_services_vault : k => v.resource_id }
}


output "vault_names" {
  description = "IDs of the VM Backup Policies"
  value       = { for k, v in module.azure_recovery_services_vault : k => v.resource.name }
  
}
# output "vault_locations" {
#   description = "Locations of the Vaults"
#   value       = [for k, v in module.azure_recovery_services_vault : v.resource.location]
# }

# output "vault_rg_names" {
#   description = "Resource Groups for each vault"
#   value       = [for k, v in module.azure_recovery_services_vault : v.resource.resource_group_name]
# }

# output "vm_backup_policies" {
#   description = "VM Backup Policies"
#   value       = { for k, v in azurerm_backup_policy_vm.vmpolicy : k => v.id }
  
# }