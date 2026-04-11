locals {

  sa_role_name = "Storage Blob Data Contributor"

  principal_id_sa = ["8dbd921a-8a98-4fb6-a60a-fbbe99b83069", "14e45fb2-4d43-4bc3-bbf5-3f1a72b3a263", "793ef143-4728-4575-80bb-9553bda140ab"]

  monitoring_principal_id = ["c2e0138f-422a-40e4-afb0-4f006d95afd7", "ac1cc92b-6308-4c43-a0f9-a02bb8504463", "457cd0db-a2a2-4a6c-889d-18c706cdc633", "eca9a34d-03dd-4a53-9d2f-d17b5f68d063", "687bb282-10b4-4c8d-9a40-fab8caab8b1f", "68f68099-7e3b-4cf1-b572-387ab4c1c5d6", "636cb04d-fcbd-4b24-87b2-3f27302dc43a"]
  monitoring_role_name    = "Monitoring Contributor"

  contributor_principal_id = ["636cb04d-fcbd-4b24-87b2-3f27302dc43a", "bd9ab3e0-8552-47c8-af9b-7b5aab03c7a6"]
  contributor_role_name    = "Contributor"

  owner_role_name    = "Owner"
  owner_principal_id = "bd9ab3e0-8552-47c8-af9b-7b5aab03c7a6"

}
