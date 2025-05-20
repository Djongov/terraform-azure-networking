resource "azurerm_virtual_network" "this" {
  for_each = var.vnets

    name                = "${var.project_name}-${each.key}-${var.environment}-vnet"
    resource_group_name = var.resource_group_name
    location            = var.location
    address_space       = each.value.address_space
    tags                = merge(
      local.common_tags,
      each.value.tags != null ? each.value.tags : {}
    )
}

# Now the subnets
resource "azurerm_subnet" "this" {
  for_each = merge([
    for vnet_key, vnet in var.vnets : {
      for subnet in vnet.subnets : 
      "${vnet_key}-${subnet.name}" => {
        name              = subnet.name
        address_prefix    = subnet.address_prefix
        service_endpoints = try(subnet.service_endpoints, [])
        vnet_key          = vnet_key
      }
    }
  ]...)

  name                 = "${var.project_name}-${each.value.vnet_key}-${var.environment}-${each.value.name}-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this[each.value.vnet_key].name
  address_prefixes     = [each.value.address_prefix]
  service_endpoints    = each.value.service_endpoints
}
