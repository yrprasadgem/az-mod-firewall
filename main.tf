locals {

  aks_azurerm_firewall_dnat_rule_collection_rules = { for idx, rule in var.aks_azurerm_firewall_dnat_rule_collection_rules : rule.name => {
    idx : idx,
    rule : rule,
  }
  }

  aks_azurerm_firewall_snat_rule_collection_rules = { for idx, rule in var.aks_azurerm_firewall_snat_rule_collection_rules : rule.name => {
    idx : idx,
    rule : rule,
  }
  }

}

resource "azurerm_public_ip" "aks_azure_firewall_azurerm_public_ip" {
  name                = var.aks_azure_firewall_public_ip_name
  location            = var.aks_azure_firewall_public_ip_name_location
  resource_group_name = var.aks_azure_firewall_public_ip_resource_group_name
  allocation_method   = var.aks_azure_firewall_public_ip_allocation_method
  sku                 = var.aks_azure_firewall_public_ip_sku
  tags                = var.aks_azure_firewall_resource_tags
}

resource "azurerm_firewall" "aks_azure_azurerm_firewall" {
  name                = var.aks_azure_firewall_name
  location            = var.aks_azure_firewall_location
  resource_group_name = var.aks_azure_firewall_resource_group_name
  tags                = var.aks_azure_firewall_resource_tags

  ip_configuration {
    name                 = var.aks_azure_firewall_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.aks_azure_firewall_azurerm_public_ip.id
    subnet_id            = var.fw_subnet_id
  }
}

resource "azurerm_firewall_nat_rule_collection" "aks_azurerm_firewall_dnat_rule_collection" {
  for_each            = local.aks_azurerm_firewall_dnat_rule_collection_rules
  name                = lower(format("fw-nat-rule-%s-DNAT", each.key))
  azure_firewall_name = azurerm_firewall.aks_azure_azurerm_firewall.name
  resource_group_name = azurerm_firewall.aks_azure_azurerm_firewall.resource_group_name
  priority            = 100 * (each.value.idx + 1)
  action              = each.value.rule.action

    rule {
      name                  = each.key
      source_addresses      = each.value.rule.source_addresses
      destination_ports     = each.value.rule.destination_ports
      destination_addresses = each.value.rule.destination_addresses
      protocols             = each.value.rule.protocols
      translated_address    = each.value.rule.translated_address
      translated_port       = each.value.rule.translated_port
    }

}

resource "azurerm_firewall_network_rule_collection" "aks_azurerm_firewall_snat_rule_collection" {
  for_each            = local.aks_azurerm_firewall_snat_rule_collection_rules
  name  = lower(format("fw-nat-rule-%s-SNAT", each.key))
  azure_firewall_name = azurerm_firewall.aks_azure_azurerm_firewall.name
  resource_group_name = azurerm_firewall.aks_azure_azurerm_firewall.resource_group_name
  priority            = 100 * (each.value.idx + 1)
  action              = each.value.rule.action


  rule {
    name                  = each.key
    source_addresses      = each.value.rule.source_addresses
    destination_ports     = each.value.rule.destination_ports
    destination_addresses = each.value.rule.destination_addresses
    protocols             = each.value.rule.protocols
  }

}








