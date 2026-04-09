# Configuration for Azure resources
resource_config = {

  # .............................................................................
  #                        Data Resources (Manually Created resources)
  # .............................................................................
  # General Resource Group and Location
  resource_group_name = "kyc-idpp-ocr-tst-rg" # Name of the resource group where resources will be deployed
  location            = "UAE North"           # Azure region for resource deployment

  # Networking Configuration
  virtual_network_name          = "kyc-idpp-vnet-tst"             # Virtual Network name
  network_resource_group_name   = "kyc-idpp-vnet-tst-rg"          # Resource group for the Virtual Network
  private_subnet_name           = "sub-kyc-idpp-tst-app-pe-01"    # Subnet name within the Virtual Network
  integration_subnet_name       = "sub-kyc-idpp-tst-fapp-outb-01" # Subnet name specifically for integrating services (e.g., Function Apps)
  aks_subnet_name               = "sub-kyc-idpp-tst-aks-01"
  public_network_access_enabled = false

  #cmk key vault configurations
  key_vault_rg_name        = "kyc-idpp-shared-rg"       # Resource group for the Key Vault
  kv_name                  = "rakkycidppsharedkv01"     # Key Vault name
  key_vault_key_name       = "rak-idpp-tst-encryption1" # Key Vault key name
  sql_password_secret_name = "sqlpassword"

  # .............................................................................
  #                       Key Vault configurations
  # .............................................................................
  key_vault_name = "rakkycidpptstkv"
  kv_sku_name    = "standard"

  # .............................................................................
  #                        Storage account
  # .............................................................................
  shared_adls_name            = "rakbankkycidpptststg01"
  function_adls_name          = "rakbankkycidpptststg02"
  storage_account_replication = "LRS"

  # .............................................................................
  #                        SQL Server
  # .............................................................................

  # SQL Server and DB config
  sql_server_name = "aztstkycsqlserver"

  sql_db_name = "aztstkycsqldb" # Database name
  sql_db_sku  = "S1"            # SKU tier for SQL database

  long_term_weekly_retention = "P0W" //"P6W"
  secondary_type             = "Geo"

  # .............................................................................
  #                        Cosmos DB Configuration
  # .............................................................................

  cosmos_db_name       = "aztstkycidppcosdb01"
  cosmos_backup_type   = "Periodic"
  cosmos_backup_tier   = null //Continuous30Days
  cosmos_identity_name = "rakbank-tst-kycidpp-cosdb-umi-01"
  cosmos_kind          = "GlobalDocumentDB" # Type of Cosmos DB

  # .............................................................................
  #                        Function app Plan
  # .............................................................................

  app_service_plan_name        = "rakbank-tst-kycidpp-asp-01"
  asp_sku_name                 = "EP2"
  maximum_elastic_worker_count = 3
  zone_balancing_enabled       = true

  # .............................................................................
  #                        Function app
  # .............................................................................

  # function app config
  function_app_name      = "rakbank-tst-kycidpp-fap-01" # Function App name
  function_identity_name = "rakbank-tst-kycidpp-fap-umi-01"

  # .............................................................................
  #                        AKS
  # .............................................................................
  aks_name             = "kycidpp-tst-aks-01"
  acr_name             = "kycidpptstacr01"
  acr_sku              = "Premium" # ACR SKU (Basic, Standard, Premium)
  user_node_pool_zones = ["1"]




  # .............................................................................
  #                        AI Services
  # .............................................................................

  ai_search_name           = "rakbank-tst-kycidpp-aisearch-01"            # Name of the Azure AI Search service
  di_name                  = "rakbank-tst-kycidpp-docint-01"              # Name of the Document Intelligence (DI) service
  tr_name                  = "rakbank-tst-kycidpp-aitransl-01"            # Name of the AI Translator service
  di_custom_subdomain_name = "rakbank-tst-kycidpp-docint-ctm-subdmn-01"   # Custom subdomain for Document Intelligence
  tr_custom_subdomain_name = "rakbank-tst-kycidpp-aitransl-ctm-subdmn-01" # Custom subdomain for AI Translator
  ai_search_sku            = "standard3"                                  # SKU tier for Azure AI Search (e.g., Free, Basic, Standard)
  tr_sku_name              = "S1"                                         # SKU for AI Translator
  di_sku_name              = "S0"                                         # SKU for Document Intelligence



  # Resource Tags for Organization and Management
  tag_details = {
    rakbank_application_name    = "KYC IDPP(Intelligent Decument Processing Platform)"
    rakbank_application_id      = "20210341"
    rakbank_crown_jewel_tier    = "TIER 3"
    rakbank_compliance          = "PCI-DSS"
    rakbank_shared_service      = "NO"
    rakbank_business_unit       = "Compliance"
    rakbank_environment         = "TST"
    rakbank_backup              = "No"
    rakbank_data_classification = "RAKBANK-Highly Confidential"
    rakbank_par_number          = "PAR-064-2024"
    rakbank_pii_classification  = "PII"
    rakbank_data_access         = "RakBankEnterprise"
    rakbank_function            = "ApplicationServer"
    rakbank_resource_lifecycle  = "Permanent"
  }
}
