
resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "this" {
  name                = var.virtual_network_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = var.address_space
}

resource "azurerm_subnet" "this" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = var.address_prefixes
}

resource "azurerm_public_ip" "this" {
  name                = var.public_ip
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = var.allocation_method
  sku                 = var.public_ip_sku
}

resource "azurerm_virtual_network_gateway" "this" {

  name                = var.VNG_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  type     = var.VGN_type
  vpn_type = var.VGN_vpn_type

  active_active = var.VNG_active_active
  enable_bgp    = var.VGN_enable_bgp
  sku           = var.VGN_sku

  ip_configuration {
    name                          = var.VGN_ip_config_name
    public_ip_address_id          = azurerm_public_ip.this.id
    private_ip_address_allocation = var.VGN_ip_config_private_ip_addr_allo
    subnet_id                     = azurerm_subnet.this.id
  }
}

resource "azurerm_local_network_gateway" "this" {
  name                = var.local_NG_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  address_space       = var.local_NG_addr_space
  gateway_address     = google_compute_address.gcp_vpn_gateway_ip.address
}

resource "azurerm_virtual_network_gateway_connection" "azure-to-gcp" {
  name                = var.VNGC_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  type                       = var.VNGC_type
  virtual_network_gateway_id = azurerm_virtual_network_gateway.this.id
  local_network_gateway_id   = azurerm_local_network_gateway.this.id

  shared_key = var.shared_secret
}

