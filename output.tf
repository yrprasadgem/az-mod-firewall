output "publi_ip" {
  description = "The Name of Newly Created Resource Group"
  value       = "${azurerm_public_ip.aks_azure_firewall_azurerm_public_ip.id}"
}

