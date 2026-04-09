# Variable definition for private endpoint configuration
variable "resource_config" {
  description = "Configuration for private endpoints, including resource group, network, and private endpoint details."

  type = object({

    # .............................................................................
    #                        Data Resources (Manually Created resources)
    # .............................................................................

    # General Resource Group and Location
    resource_group_name = string # Name of the resource group where resources will be deployed
    location            = string # Azure region for resource deployment

    # Networking Configuration
    network_resource_group_name   = string # Name of the resource group containing the virtual network
    virtual_network_name          = string # Name of the virtual network (VNet) for private endpoints
    private_subnet_name           = string # Name of the subnet where private endpoints will be created
    integration_subnet_name       = string # Subnet name used for service integrations (e.g., Function Apps)
    aks_subnet_name               = string
    public_network_access_enabled = bool

    # Key Vault Configuration
    kv_name                  = string # Name of the Azure Key Vault
    key_vault_rg_name        = string # Name of the resource group where the Key Vault is deployed
    key_vault_key_name       = string # Name of the Key Vault key used for encryption (Customer-Managed Key - CMK)
    sql_password_secret_name = string


    # .............................................................................
    #                       Key Vault configurations
    # .............................................................................
    # Key Vault Configuration
    key_vault_name = string # Name of the Azure Key Vault
    kv_sku_name    = string # SKU tier for the Key Vault (e.g., Standard, Premium)


    # .............................................................................
    #                        Storage account
    # .............................................................................

    # Azure Data Lake Storage Configuration
    function_adls_name          = string # Name of the Azure Data Lake Storage (ADLS) account
    shared_adls_name            = string # Name of the Azure Data Lake Storage (ADLS) account
    storage_account_replication = string




    # .............................................................................
    #                        SQL Server
    # .............................................................................
    # SQL Server and Database Configuration
    sql_server_name            = string # Name of the Azure SQL Server instance
    sql_db_name                = string # Name of the SQL Database
    sql_db_sku                 = string # SKU tier for SQL database (e.g., Basic, Standard, Premium)
    long_term_weekly_retention = string
    secondary_type             = string




    # .............................................................................
    #                        Cosmos DB Configuration
    # .............................................................................
    # Cosmos DB Configuration
    cosmos_db_name       = string # Name of the Cosmos DB instance
    cosmos_backup_type   = string
    cosmos_backup_tier   = string
    cosmos_identity_name = string
    cosmos_kind          = string # Type of Cosmos DB





    # .............................................................................
    #                        Function app Plan
    # .............................................................................
    # App Service Plan Configuration
    app_service_plan_name        = string # Name of the App Service Plan
    asp_sku_name                 = string # SKU tier for the App Service Plan (e.g., EP1, P1V2)
    maximum_elastic_worker_count = number
    zone_balancing_enabled       = bool


    # .............................................................................
    #                        Function app
    # .............................................................................
    # Function App Configuration
    function_app_name      = string # Name of the Azure Function App
    function_identity_name = string




    # .............................................................................
    #                        AKS
    # .............................................................................

    aks_name = string # Name of the Azure Kubernetes Service (AKS) cluster

    # Azure Container Registry (ACR) Configuration
    acr_name             = string # Name of the Azure Container Registry (ACR)
    user_node_pool_zones = list(string)




    # .............................................................................
    #                        AI Services
    # .............................................................................

    ai_search_name           = string # Name of the Azure AI Search service
    di_name                  = string # Name of the Document Intelligence (DI) service
    tr_name                  = string # Name of the AI Translator service
    di_custom_subdomain_name = string # Custom subdomain for Document Intelligence
    tr_custom_subdomain_name = string # Custom subdomain for AI Translator
    ai_search_sku            = string # SKU tier for Azure AI Search (e.g., Free, Basic, Standard)
    tr_sku_name              = string # SKU for AI Translator
    di_sku_name              = string # SKU for Document Intelligence
    acr_sku                  = string # ACR SKU (Basic, Standard, Premium)

    # tag required for deployment
    tag_details = object({
      rakbank_application_name    = string
      rakbank_application_id      = string
      rakbank_crown_jewel_tier    = string
      rakbank_compliance          = string
      rakbank_shared_service      = string
      rakbank_business_unit       = string
      rakbank_environment         = string
      rakbank_backup              = string
      rakbank_data_classification = string
      rakbank_par_number          = string
      rakbank_pii_classification  = string
      rakbank_data_access         = string
      rakbank_function            = string
      rakbank_resource_lifecycle  = string
    })
  })
}
