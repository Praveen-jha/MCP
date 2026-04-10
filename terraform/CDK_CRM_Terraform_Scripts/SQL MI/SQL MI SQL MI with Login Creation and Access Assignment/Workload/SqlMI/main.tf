# ......................................................
# Creating New Resource Group
# ......................................................

module "rg" {
  source                  = "../../Module/rg"
  count                   = var.rg_creation == "new" ? 1 : 0
  resource_group_name     = var.resource_group_name
  resource_group_location = var.location
  tags                    = var.tags
}

module "sql_managed_instance" {
  source                              = "../../Module/sqlManagedInstance"
  location                            = var.location
  resource_group_name                 = var.resource_group_name
  sql_instance_name                   = var.sql_instance_name
  sql_storage_size                    = var.sql_storage_size
  sql_vcores                          = var.sql_vcores
  sku_name                            = var.sql_mi_sku_name
  subnet_id_sqlmi                     = data.azurerm_subnet.subnet_sqlmi.id
  ad_group_display_name               = var.ad_group_display_name
  ad_group_object_id                  = data.azuread_group.mi_admin.object_id
  azuread_principal_type              = var.azuread_principal_type
  azuread_authentication_only_enabled = var.azuread_authentication_only_enabled
  administrator_login                 = var.sql_admin_user
  administrator_login_password        = var.sql_admin_password
  identity_type                       = var.identity_type
  identity_ids                        = var.identity_ids

  depends_on = [module.rg]
}

# SSMS User Login Creation and Roles-Permissions Assignment
resource "null_resource" "sql_permissions" {

  provisioner "local-exec" {
    command = <<-EOT
      $SqlAdminUser = "${var.sql_admin_user}"
      $SqlAdminPassword = "${var.sql_admin_password}"
      $SqlServer = "${module.sql_managed_instance.sql_mi_public_endpoint}"
      $GroupsJson = '${jsonencode(var.sql_groups)}'
      $Groups = $GroupsJson | ConvertFrom-Json

      foreach ($group in $Groups) {
          $groupName = $group.Name

          $loginCmd = "IF NOT EXISTS (SELECT name FROM sys.server_principals WHERE name = N'$groupName') BEGIN CREATE LOGIN [$groupName] FROM EXTERNAL PROVIDER; END"
          sqlcmd -U $SqlAdminUser -P $SqlAdminPassword -S $SqlServer -Q $loginCmd

          foreach ($srvRole in $group.server_roles) {
              $roleCmd = "ALTER SERVER ROLE [$srvRole] ADD MEMBER [$groupName];"
              sqlcmd -U $SqlAdminUser -P $SqlAdminPassword -S $SqlServer -Q $roleCmd
          }

          foreach ($db in $group.Databases) {
              $dbName = $db.Name
              $dbCmds = @()
              $dbCmds += "USE [$dbName];"
              $dbCmds += "IF NOT EXISTS (SELECT name FROM sys.database_principals WHERE name = N'$groupName') BEGIN CREATE USER [$groupName] FROM EXTERNAL PROVIDER; END"
              foreach ($dbRole in $db.Roles) {
                  $dbCmds += "ALTER ROLE [$dbRole] ADD MEMBER [$groupName];"
              }
              $fullCmd = $dbCmds -join "`n"
              sqlcmd -U $SqlAdminUser -P $SqlAdminPassword -S $SqlServer -Q $fullCmd
          }
      }
    EOT

    interpreter = ["PowerShell", "-Command"]
  }
  depends_on = [module.sql_managed_instance]
}
