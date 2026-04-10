#The azurerm_network_interface resource is used to create and manage a network interface (NIC) in Azure.
#A NIC enables a virtual machine (VM) to communicate with the network. It can be associated with subnets, private IP addresses, public IPs, network security groups (NSGs), and application security groups (ASGs).
#Terraform register link: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface

resource "azurerm_network_interface" "this" {
  #reqiured
  name                = var.network_interface_card_name
  location            = var.network_interface_card_location
  resource_group_name = var.network_interface_card_rg_name
  tags                = var.network_interface_card_tags
  #Optional
  auxiliary_mode                 = try(var.network_interface_card_auxiliary_mode, null)
  auxiliary_sku                  = try(var.network_interface_card_auxiliary_sku, null)
  dns_servers                    = try(var.network_interface_card_dns_servers, null)
  edge_zone                      = try(var.network_interface_card_edge_zone, null)
  ip_forwarding_enabled          = var.network_interface_card_ip_forwarding_enabled
  accelerated_networking_enabled = var.network_interface_card_accelerated_networking_enabled
  internal_dns_name_label        = try(var.network_interface_card_internal_dns_name_label, null)

  ip_configuration {
    name                                               = var.network_interface_card_ip_configuration_name
    subnet_id                                          = var.network_interface_card_private_ip_address_version == "IPv4" ? var.network_interface_card_subnet_id : null
    private_ip_address_allocation                      = var.network_interface_card_private_ip_address_allocation
    private_ip_address_version                         = var.network_interface_card_private_ip_address_version
    gateway_load_balancer_frontend_ip_configuration_id = try(var.network_interface_card_gateway_load_balancer_frontend_ip_configuration_id, null)
    public_ip_address_id                               = try(var.network_interface_card_public_ip_address_id, null)
    primary                                            = try(var.network_interface_card_primary, null)
    private_ip_address                                 = var.network_interface_card_private_ip_address_allocation == "Static" ? var.network_interface_card_private_ip_address : null
  }
}


#Terraform block "azurerm_windows_virtual_machine" is used to provision and manage a Windows-based virtual_machine in Microsoft Azure.
#Terraform register link: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine

resource "azurerm_windows_virtual_machine" "this" {
  name                  = var.windows_vm_name
  resource_group_name   = var.windows_vm_rg_name
  location              = var.windows_vm_location
  size                  = var.windows_vm_size
  admin_username        = var.windows_vm_admin_username
  admin_password        = var.windows_vm_admin_password
  computer_name         = var.windows_vm_computer_name
  tags                  = var.windows_vm_tags
  network_interface_ids = [azurerm_network_interface.this.id]

  os_disk {
    name                             = var.windows_vm_os_disk_name
    caching                          = var.windows_vm_os_caching
    storage_account_type             = var.windows_vm_os_storage_account_type
    disk_size_gb                     = var.windows_vm_os_disk_size_gb
    disk_encryption_set_id           = var.windows_vm_secure_vm_disk_encryption_set_id == null ? try(var.windows_vm_disk_encryption_set_id, null) : null
    secure_vm_disk_encryption_set_id = var.windows_vm_security_encryption_type == "DiskWithVMGuestState" ? try(var.windows_vm_secure_vm_disk_encryption_set_id, null) : null
    security_encryption_type         = var.windows_vm_secure_vm_disk_encryption_set_id != null ? var.windows_vm_security_encryption_type : null

    # Conditional value for write_accelerator_enabled
    write_accelerator_enabled = (
      var.windows_vm_write_accelerator_enabled &&
      var.windows_vm_os_caching == "None" &&
      var.windows_vm_os_storage_account_type == "Premium_LRS"
    ) ? true : false

    # Optional block, only present when diff_disk_settings is set and caching is ReadOnly
    dynamic "diff_disk_settings" {
      for_each = (
        var.windows_vm_diff_disk_settings != null && var.windows_vm_os_caching == "ReadOnly"
      ) ? ["diff_disk_settings"] : []

      content {
        option    = var.windows_vm_diff_disk_settings.option
        placement = lookup(var.windows_vm_diff_disk_settings, "placement", null)
      }
    }
  }

  source_image_reference {
    publisher = var.windows_vm_publisher
    offer     = var.windows_vm_offer
    sku       = var.windows_vm_sku
    version   = var.windows_vm_image_version
  }

  zone                                                   = var.windows_vm_availability_zone ? var.windows_vm_vm_zone : null
  allow_extension_operations                             = var.windows_vm_provision_vm_agent ? try(var.windows_vm_allow_extension_operations, false) : false
  availability_set_id                                    = var.windows_vm_capacity_reservation_group_id == null ? try(var.windows_vm_availability_set_id, null) : null
  bypass_platform_safety_checks_on_user_schedule_enabled = var.windows_vm_patch_mode == "AutomaticByPlatform" ? try(var.windows_vm_bypass_platform_safety_checks_on_user_schedule_enabled, false) : false
  capacity_reservation_group_id                          = try(var.windows_vm_capacity_reservation_group_id, null)
  custom_data                                            = try(var.windows_vm_custom_data, null)
  dedicated_host_id                                      = var.windows_vm_dedicated_host_group_id == null ? try(var.windows_vm_dedicated_host_id, null) : null
  dedicated_host_group_id                                = var.windows_vm_dedicated_host_id == null ? try(var.windows_vm_dedicated_host_group_id, null) : null
  edge_zone                                              = try(var.windows_vm_edge_zone, null)
  disk_controller_type                                   = try(var.windows_vm_disk_controller_type, null)
  enable_automatic_updates                               = var.windows_vm_enable_automatic_updates
  encryption_at_host_enabled                             = var.windows_vm_security_encryption_type != "DiskWithVMGuestState" ? try(var.windows_vm_encryption_at_host_enabled, null) : false
  eviction_policy                                        = var.windows_vm_priority == "Spot" ? try(var.windows_vm_eviction_policy, null) : null
  extensions_time_budget                                 = var.windows_vm_extensions_time_budget

  hotpatching_enabled = (
    var.windows_vm_patch_mode == "AutomaticByPlatform" &&
    (var.windows_vm_provision_vm_agent == true || try(var.windows_vm_provision_vm_agent, false))
  ) ? try(var.windows_vm_hotpatching_enabled, false) : false

  license_type                 = try(var.windows_vm_license_type, null)
  max_bid_price                = var.windows_vm_priority == "Spot" ? try(var.windows_vm_max_bid_price, -1) : -1
  patch_assessment_mode        = var.windows_vm_patch_assessment_mode
  patch_mode                   = var.windows_vm_hotpatching_enabled ? "AutomaticByPlatform" : var.windows_vm_patch_mode
  platform_fault_domain        = var.windows_vm_platform_fault_domain
  priority                     = var.windows_vm_priority
  provision_vm_agent           = var.windows_vm_patch_assessment_mode == "AutomaticByPlatform" || var.windows_vm_patch_mode == "AutomaticByPlatform" ? true : var.windows_vm_provision_vm_agent
  proximity_placement_group_id = var.windows_vm_capacity_reservation_group_id == null ? try(var.windows_vm_proximity_placement_group_id, null) : null
  reboot_setting               = var.windows_vm_patch_mode == "AutomaticByPlatform" ? try(var.windows_vm_reboot_setting, null) : null
  secure_boot_enabled          = try(var.windows_vm_secure_boot_enabled, null)
  timezone                     = try(var.windows_vm_timezone, null)
  user_data                    = try(var.windows_vm_user_data, null)
  virtual_machine_scale_set_id = try(var.windows_vm_virtual_machine_scale_set_id, null)
  vtpm_enabled                 = var.windows_vm_security_encryption_type != null ? true : var.windows_vm_vtpm_enabled

  # Dynamic Blocks
  dynamic "additional_capabilities" {
    for_each = var.windows_vm_additional_capabilities == null ? [] : ["additional_capabilities"]
    content {
      ultra_ssd_enabled   = try(var.windows_vm_additional_capabilities.ultra_ssd_enabled, null)
      hibernation_enabled = try(var.windows_vm_additional_capabilities.hibernation_enabled, null)
    }
  }

  dynamic "additional_unattend_content" {
    for_each = var.windows_vm_additional_unattend_content == null ? [] : ["additional_unattend_content"]
    content {
      content = try(var.windows_vm_additional_unattend_content.content, null)
      setting = try(var.windows_vm_additional_unattend_content.setting, null)
    }
  }

  dynamic "boot_diagnostics" {
    for_each = var.windows_vm_boot_diagnostics == null ? [] : ["boot_diagnostics"]
    content {
      storage_account_uri = try(var.windows_vm_boot_diagnostics.storage_account_uri, null)
    }
  }

  dynamic "gallery_application" {
    for_each = var.windows_vm_gallery_application == null ? [] : ["gallery_application"]
    content {
      version_id                                  = try(var.windows_vm_gallery_application.version_id, null)
      automatic_upgrade_enabled                   = try(var.windows_vm_gallery_application.automatic_upgrade_enabled, null)
      configuration_blob_uri                      = try(var.windows_vm_gallery_application.configuration_blob_uri, null)
      order                                       = try(var.windows_vm_gallery_application.order, null)
      tag                                         = try(var.windows_vm_gallery_application.gallerytag, null)
      treat_failure_as_deployment_failure_enabled = try(var.windows_vm_gallery_application.treat_failure_as_deployment_failure_enabled, null)
    }
  }

  dynamic "identity" {
    for_each = var.windows_vm_identity_type == null ? [] : ["identity"]
    content {
      type         = var.windows_vm_identity_type
      identity_ids = var.windows_vm_identity_type == "SystemAssigned" ? null : var.windows_vm_identity_ids
    }
  }

  dynamic "plan" {
    for_each = var.windows_vm_plan == null ? [] : ["plan"]
    content {
      name      = try(var.windows_vm_plan.planame, null)
      product   = try(var.windows_vm_plan.product, null)
      publisher = try(var.windows_vm_plan.publisher, null)
    }
  }

  dynamic "secret" {
    for_each = var.windows_vm_secret == null ? [] : ["secret"]
    content {
      key_vault_id = try(var.windows_vm_secret.key_vault_id, null)

      dynamic "certificate" {
        for_each = var.windows_vm_secret.certificate == null ? [] : ["certificate"]
        content {
          store = try(var.windows_vm_secret.certificate.store, null)
          url   = try(var.windows_vm_secret.certificate.url, null)
        }
      }
    }
  }

  dynamic "os_image_notification" {
    for_each = var.windows_vm_os_image_notification == null ? [] : ["os_image_notification"]
    content {
      timeout = try(var.os_image_notification.timeout, null)
    }
  }

  dynamic "termination_notification" {
    for_each = var.windows_vm_termination_notification == null ? [] : ["termination_notification"]
    content {
      enabled = try(var.windows_vm_termination_notification.enabled, null)
      timeout = try(var.windows_vm_termination_notification.timeout, null)
    }
  }

  dynamic "winrm_listener" {
    for_each = var.windows_vm_winrm_listener == null ? [] : ["winrm_listener"]
    content {
      protocol        = try(var.windows_vm_winrm_listener.protocol, null)
      certificate_url = var.windows_vm_winrm_listener.protocol == "Https" ? var.windows_vm_winrm_listener.certificate_url : null
    }
  }
}