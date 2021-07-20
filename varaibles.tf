
# Everything below is for the module

variable "aks_azure_firewall_resource_group_name"{
  type = string
}

variable "aks_azure_firewall_public_ip_name"{
  type=string
}


variable "aks_azure_firewall_name"{
  type=string
}

variable "aks_azure_firewall_ip_configuration_name" {
  type=string
}

variable "aks_azurerm_firewall_dnat_rule_collection_rules" {
  description = "List of nat rules to apply to firewall."
  type        = list(object({ name = string, action = string, source_addresses = list(string), destination_ports = list(string), destination_addresses = list(string), protocols = list(string), translated_address = string, translated_port = string }))
  default     = []
}

variable "aks_azurerm_firewall_snat_rule_collection_rules" {
  description = "List of network rules to apply to firewall."
  type        = list(object({ name = string, action = string, source_addresses = list(string), destination_ports = list(string), destination_addresses = list(string), protocols = list(string) }))
  default     = []
}

variable "aks_azure_firewall_public_ip_name_location" {
  type=string
}

variable "aks_azure_firewall_public_ip_resource_group_name" {
  type=string
}

variable "aks_azure_firewall_public_ip_allocation_method"{
  type=string
}


variable "aks_azure_firewall_public_ip_sku" {
  type=string
}

variable "aks_azure_firewall_public_ip_resource_tags" {
  type=map(any)
}

variable "aks_azure_firewall_location"  {
  type=string
}

variable "aks_azure_firewall_resource_tags" {
  type=map(any)
}

variable "fw_subnet_id" {
  type  = string
}