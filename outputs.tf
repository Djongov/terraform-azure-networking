output "vnet_ids" {
  description = "Map of VNet names to their IDs"
  value = {
    for k, v in var.vnets :
    k => azurerm_virtual_network.this[k].id
  }
}

output "subnet_ids" {
  description = "Map of Subnet names to their IDs"
  value = {
    for vnet_key, vnet in var.vnets : vnet_key => {
      for subnet in vnet.subnets :
      subnet.name => azurerm_subnet.this["${vnet_key}-${subnet.name}"].id
    }
  }
}