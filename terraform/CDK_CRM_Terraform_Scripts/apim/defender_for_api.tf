# Enable Microsoft Defender for APIs at the subscription level
#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_subscription_pricing
resource "azurerm_security_center_subscription_pricing" "defender_for_apis" {
  count         = var.enable_defender_for_apis ? 1 : 0
  tier          = var.subscription_pricing.tier
  subplan       = var.subscription_pricing.subplan
  resource_type = var.subscription_pricing.resource_type
}
