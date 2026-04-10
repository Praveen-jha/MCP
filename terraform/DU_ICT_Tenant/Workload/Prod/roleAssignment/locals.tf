locals {

  kv_secret_user_principal_id  = ["687bb282-10b4-4c8d-9a40-fab8caab8b1f", "97e1c23a-ebf0-4df0-ac05-f2b0b8b1cdf4", "9bc25696-e99e-468f-aa3b-4eb8c4ab8e63", "ac1cc92b-6308-4c43-a0f9-a02bb8504463", "eca9a34d-03dd-4a53-9d2f-d17b5f68d063", "68f68099-7e3b-4cf1-b572-387ab4c1c5d6", "636cb04d-fcbd-4b24-87b2-3f27302dc43a", "457cd0db-a2a2-4a6c-889d-18c706cdc633", "faff98e0-fa79-4dc7-97c3-941df0c8ebbc", "bd9ab3e0-8552-47c8-af9b-7b5aab03c7a6", "9d73ed20-ff24-4dd9-9b5a-e8afe2a582d4", "c2e0138f-422a-40e4-afb0-4f006d95afd7", "65f07f59-a83e-4732-b5da-d1cded1b5b09", "351b9b4c-a365-435e-9b93-d8a723ca8c7b", "b32d68df-36bc-4f8b-ab69-16f31bb87ad9"]
  kv_secrets_officer_role_name = "Key Vault Secrets Officer"
  kv_access_admin_role_name    = "Key Vault Data Access Administrator"
  kv_secret_user_role_name     = "Key Vault Secrets User"

  sa_role_name             = "Storage Blob Data Contributor"
  contributor_principal_id = ["636cb04d-fcbd-4b24-87b2-3f27302dc43a"]
  contributor_role_name    = "Contributor"

  owner_role_name    = "Owner"
  owner_principal_id = "bd9ab3e0-8552-47c8-af9b-7b5aab03c7a6"

}
