
variable "subscription_id" {
  type = string
}
variable "tenant_id" {
  type = string
}
variable "name" {
  type        = list(string)
  description = "Name: specify a name for the Azure Recovery Services Vault. Upper/Lower case letters, numbers and hyphens. number of characters 2-50"
  default     = ["recovery-vault-prod"]
}

variable "recovery_vault_config" {
  type = object({
    # name                                           = string
    #location                                       = string
    #resource_group_name                            = string
    cross_region_restore_enabled                   = bool
    alerts_for_all_job_failures_enabled            = bool
    alerts_for_critical_operation_failures_enabled = bool
    classic_vmware_replication_enabled             = bool
    public_network_access_enabled                  = bool
    storage_mode_type                              = string
    sku                                            = string
    managed_identities = object({
      system_assigned            = bool
      user_assigned_resource_ids = list(string)
    })
    tags                     = map(string)
    workload_backup_policy   = any
    vm_backup_policy         = any
    file_share_backup_policy = any
  })
}
# variable "vm_backup_policies" {
#   type = map(object({
#     name                = string
#     timezone            = string
#     frequency           = string
#     time                = string
#     retention_daily     = object({
#       count = number
#     })
#     retention_weekly    = object({
#       count = number
#       weekdays = list(string)
#     })
#     retention_monthly   = object({
#       count = number,
#       weekdays = list(string)
#       weeks    = list(string)
#     })
#     retention_yearly    = object({
#       count = number
#       weekdays = list(string)
#       weeks    = list(string)
#       months   = list(string)
#     })
#   }))
# }
