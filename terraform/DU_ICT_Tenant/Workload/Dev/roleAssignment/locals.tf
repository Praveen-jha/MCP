locals {

  kv_secret_user_principal_id  = ["67bf38c2-b78e-45da-be77-de075e07ddd5", "687bb282-10b4-4c8d-9a40-fab8caab8b1f", "97e1c23a-ebf0-4df0-ac05-f2b0b8b1cdf4", "c2e0138f-422a-40e4-afb0-4f006d95afd7", "9bc25696-e99e-468f-aa3b-4eb8c4ab8e63", "ac1cc92b-6308-4c43-a0f9-a02bb8504463", "eca9a34d-03dd-4a53-9d2f-d17b5f68d063", "68f68099-7e3b-4cf1-b572-387ab4c1c5d6", "636cb04d-fcbd-4b24-87b2-3f27302dc43a", "457cd0db-a2a2-4a6c-889d-18c706cdc633", "65f07f59-a83e-4732-b5da-d1cded1b5b09", "4833d89f-8434-43b2-b9e2-9f5bb6362380", "faff98e0-fa79-4dc7-97c3-941df0c8ebbc", "b32d68df-36bc-4f8b-ab69-16f31bb87ad9"]
  kv_secrets_officer_role_name = "Key Vault Secrets Officer"
  kv_access_admin_role_name    = "Key Vault Data Access Administrator"
  kv_secret_user_role_name     = "Key Vault Secrets User"

  monitoring_principal_id = ["7fc4b4bf-3217-4597-98d3-ef0abfceeaf5", "dc3c09da-44da-4a10-a977-f812690b304e", "8aafcc4c-067e-443f-a2db-481e9d159d14", "2c7522d7-a8c1-4810-b580-08ed64f15bb2", "9a0cf0be-1b2b-4d1c-a8f7-c5eaf46f0498", "8abeb617-d54d-4e06-b202-0112548423a5", "d819ecbf-b3ee-42c5-a046-419975211016"]
  monitoring_role_name    = "Monitoring Contributor"

  contributor_principal_id = ["636cb04d-fcbd-4b24-87b2-3f27302dc43a", "bd9ab3e0-8552-47c8-af9b-7b5aab03c7a6"]
  contributor_role_name    = "Contributor"

  owner_role_name    = "Owner"
  owner_principal_id = "bd9ab3e0-8552-47c8-af9b-7b5aab03c7a6"

  sa_role_name = "Storage Blob Data Contributor"

}
