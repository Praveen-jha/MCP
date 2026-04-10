# Azure SQL Server on VM Terraform Module

This Terraform module deploys an Azure Windows Virtual Machine (VM) with SQL Server, configured with custom data/log/tempdb disks, Entra (Azure AD) authentication, and domain joining to "products.cdk.com". It supports optional DBA admin access by adding an Entra group with the `sysadmin` role, as required by Jira PCI-7487. The module is designed for use in a Harness Pipeline or local Terraform execution.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| azurerm | ~> 4.0 |
| azuread | ~> 3.0 |
| azapi | ~> 2.0 |
| random | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | ~> 4.0 |
| azuread | ~> 3.0 |
| azapi | ~> 2.0 |
| random | ~> 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| subscription_id | Azure subscription ID | string | | yes |
| resource_group_name | Resource group name | string | | yes |
| prefix | Naming prefix for resources | string | | yes |
| name | VM name | string | | yes |
| location | Azure region | string | "centralus" | no |
| size | VM size (e.g., Standard_D2s_v5) | string | | yes |
| subnet_id | Subnet ID for the VM | string | | yes |
| db_data_size_gb | Data disk size in GB | number | | yes |
| db_log_size_gb | Log disk size in GB | number | | yes |
| db_tempdb_size_gb | Tempdb disk size in GB | number | | yes |
| sql_sysadmin_group_name | Entra group name for sysadmin role (null/empty skips) | string | null | no |
| disk_sku | Disk SKU (e.g., Standard_LRS) | string | "Standard_LRS" | no |
| db_data_path | Data files path | string | "M:\\Data" | no |
| db_log_path | Log files path | string | "L:\\Logs" | no |
| db_tempdb_path | Tempdb path | string | "T:\\tempdb" | no |
| collation | SQL collation | string | "Latin1_General_CI_AI" | no |
| sql_license_type | SQL license type (AHUB, DR, PAYG) | string | "AHUB" | no |
| timezone_id | VM timezone | string | "Central Standard Time" | no |
| private_ip_address_allocation | IP allocation (Dynamic/Static) | string | "Dynamic" | no |
| caching | OS disk caching | string | "ReadWrite" | no |
| storage_account_type | OS disk storage type | string | "Standard_LRS" | no |
| disk_size_gb | OS disk size in GB | number | 128 | no |
| vm_tags | Tags for the VM | map(string) | {} | no |
| nic_tags | Tags for the NIC | map(string) | {} | no |
| availability_zone | Enable availability zone | bool | false | no |
| vm_zone | Availability zone number | string | null | no |
| tags | General tags (requires CDK keys) | map(string) | {} | no |
| gallery_name | Shared image gallery name | string | "cdk_published_images" | no |
| gallery_resource_group_name | Gallery resource group | string | "rg-ghs-image-gallery-cus-01" | no |
| image_version | Image version | string | "2025.0701.101" | no |
| image_name | Image name | string | | yes |

## Outputs

| Name | Description |
|------|-------------|
| virtual_machine | Full VM resource (sensitive) |
| virtual_machine_id | VM resource ID |
| mssql_virtual_machine_id | SQL VM configuration ID |
| sql_admin_username | SQL admin username ("sqladmin") |
| sql_admin_password | SQL admin password (sensitive) |
| sql_entra_logins_error_log | Path to Entra logins error log on VM |

## Verification

- **Access VM**: RDP with `adminuser` and `terraform output -raw password`.
- **Access SQL**: Connect via SSMS with `sqladmin` and `terraform output -raw sql_admin_password`.
- **Entra Login**: If `sql_sysadmin_group_name` is set, verify:
  ```sql
  SELECT * FROM sys.server_principals WHERE name = 'YourDBAAdminGroup';
  SELECT * FROM sys.server_role_members WHERE role_principal_id = (SELECT principal_id FROM sys.server_principals WHERE name = 'sysadmin');
  ```
- **Logs**: Check `C:\Temp\sql_entra_logins_error.log` on VM for Entra setup details.

## Notes

- If `sql_sysadmin_group_name` is null/empty, Entra setup is skipped.
- Ensure Azure service principal has "Contributor" and "Directory.ReadWrite.All" permissions.