# module "resource_group" {
#   source   = "./modules/resource_group"
#   name     = "example-rg"
#   location = "East US"
#   tags = {
#     Environment = "Dev"
#     Team        = "DevOps"
#   }
# }

provider "azurerm" {
  features {}
  subscription_id = "c5dd9b7d-a3b4-4e19-8889-fbbc538569e7"
  
}

module "azure_recovery_services_vault" {
  source = "git::https://github.com/Azure/terraform-azurerm-avm-res-recoveryservices-vault.git?ref=2794a299f935ed4999685a92fae7523b91b72267"
  # version = "0.1.1"

  for_each = toset(var.name)
  
  name                                           = each.key
  location                                       = var.recovery_vault_config.location
  resource_group_name                            = var.recovery_vault_config.resource_group_name
  cross_region_restore_enabled                   = var.recovery_vault_config.cross_region_restore_enabled
  alerts_for_all_job_failures_enabled            = var.recovery_vault_config.alerts_for_all_job_failures_enabled
  alerts_for_critical_operation_failures_enabled = var.recovery_vault_config.alerts_for_critical_operation_failures_enabled
  classic_vmware_replication_enabled             = var.recovery_vault_config.classic_vmware_replication_enabled
  public_network_access_enabled                  = var.recovery_vault_config.public_network_access_enabled
  storage_mode_type                              = var.recovery_vault_config.storage_mode_type
  sku                                            = var.recovery_vault_config.sku
  # managed_identities = {
  #   system_assigned            = var.recovery_vault_config.managed_identities.system_assigned
  #   user_assigned_resource_ids = [azurerm_user_assigned_identity.vault_identity.id]
  # } # var.recovery_vault_config.managed_identities
  
  tags                     = var.recovery_vault_config.tags
  workload_backup_policy   = var.recovery_vault_config.workload_backup_policy
  vm_backup_policy         = var.recovery_vault_config.vm_backup_policy
  file_share_backup_policy = var.recovery_vault_config.file_share_backup_policy
}



# resource "azurerm_backup_policy_vm" "vmpolicy" {
#   for_each            = var.vm_backup_policies
#   name                = each.value.name
#   resource_group_name = module.resource_group.location
#   recovery_vault_name = module.azure_recovery_services_vault.vault_names
#    timezone = each.value.timezone

#   backup {
#     frequency = each.value.frequency
#     time      = each.value.time
#   }

#   retention_daily {
#     count = each.value.retention_daily.count
#   }

#   dynamic "retention_weekly" {
#     for_each = each.value.retention_weekly.count > 0 ? [1] : []
#     content {
#       count    = each.value.retention_weekly.count
#       weekdays = each.value.retention_weekly.weekdays
#     }
#   }

#   dynamic "retention_monthly" {
#     for_each = each.value.retention_monthly.count > 0 ? [1] : []
#     content {
#       count    = each.value.retention_monthly.count
#       weekdays = each.value.retention_monthly.weekdays
#       weeks    = each.value.retention_monthly.weeks
#     }
#   }

#   dynamic "retention_yearly" {
#     for_each = each.value.retention_yearly.count > 0 ? [1] : []
#     content {
#       count    = each.value.retention_yearly.count
#       weekdays = each.value.retention_yearly.weekdays
#       weeks    = each.value.retention_yearly.weeks
#       months   = each.value.retention_yearly.months
#     }
#   }
#   depends_on = [ module.azure_recovery_services_vault ]
# }


#   resource "azurerm_backup_protected_vm" "protected_vm" {
#   resource_group_name = module.resource_group.name
#   recovery_vault_name = module.azure_recovery_services_vault.vault_names[var.backup_policy_name]
#   source_vm_id        = var.source_vm_id
#   backup_policy_id    = module.azure_recovery_services_vault.vm_backup_policy_ids[var.backup_policy_name]
#   # backup_policy_id    = azurerm_backup_policy_vm.vmpolicy[var.backup_policy_name].id
# }