variable "resource_group_name" {
  type = string
  description = "(Required) The Name which should be used for this Resource Group. Changing this forces a new Resource Group to be created"
}

variable "location" {
  type = string
  description = "(Required) The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created"
}

variable "virtual_network_name" {
  type = string
  description = " (Required) The name of the virtual network. Changing this forces a new resource to be created" 
}

variable "address_space" {
  type = list(string)
  description = " (Required) The address space that is used by the virtual network. You can supply more than one address space"
}

variable "subnet_name" {
  type = string
  description = "(Required) The name of the subnet. Changing this forces a new resource to be created"
}

variable "address_prefixes" {
  type = list(string)
  description = "(Required) The address prefixes to use for the subnet"
}

variable "public_ip" {
  type = string
  description = "(Required) Specifies the name of the Public IP. Changing this forces a new Public IP to be created"
}

variable "public_ip_sku" {
  type = string
  description = " (Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic. Changing this forces a new resource to be created" 
}

variable "allocation_method" {
  type = string
  description = " (Required) Defines the allocation method for this IP address. Possible values are Static or Dynamic"
}

variable "VNG_name" {
  type = string
  description = "(Required) The name of the Virtual Network Gateway. Changing this forces a new resource to be created"
}

variable "VGN_type" {
  type = string
  description = "(Required) The type of the Virtual Network Gateway. Valid options are Vpn or ExpressRoute. Changing the type forces a new resource to be created"
}

variable "VGN_vpn_type" {
  type = string
  description = "(Optional) The routing type of the Virtual Network Gateway. Valid options are RouteBased or PolicyBased. Defaults to RouteBased. Changing this forces a new resource to be created" 
}

variable "VNG_active_active" {
  type = bool
  description = " (Optional) If true, an active-active Virtual Network Gateway will be created. An active-active gateway requires a HighPerformance or an UltraPerformance SKU. If false, an active-standby gateway will be created. Defaults to false" 
}

variable "VGN_enable_bgp" {
  type = bool
  description = " (Optional) If true, BGP (Border Gateway Protocol) will be enabled for this Virtual Network Gateway. Defaults to false"
}

variable "VGN_sku" {
  type = string
  description = "(Required) Configuration of the size and capacity of the virtual network gateway"
}

variable "VGN_ip_config_name" {
  type = string
  description = "(Optional) A user-defined name of the IP configuration. Defaults to vnetGatewayConfig"
}

variable "VGN_ip_config_private_ip_addr_allo" {
  type = string
  description = "(Optional) Defines how the private IP address of the gateways virtual interface is assigned. The only valid value is Dynamic for Virtual Network Gateway (Static is not supported by the service yet). Defaults to Dynamic"
}

variable "local_NG_name" {
  type = string
  description = " (Required) The name of the local network gateway. Changing this forces a new resource to be created" 
}

variable "local_NG_addr_space" {
  type = list(string)
  description = " (Optional) The list of string CIDRs representing the address spaces the gateway exposes"
  
}

variable "VNGC_name" {
  type = string
  description = "(Required) The name of the connection. Changing the name forces a new resource to be created"
}

variable "VNGC_type" {
  type = string
  description = " (Required) The type of connection. Valid options are IPsec (Site-to-Site), ExpressRoute (ExpressRoute), and Vnet2Vnet (VNet-to-VNet). Each connection type requires different mandatory arguments (refer to the examples above). Changing this forces a new resource to be created"
}

variable "shared_secret" {
  description = "The shared secret for the VPN connection."
  type        = string
  sensitive   = true
}

variable "network" {
  type = string
  description = "(Required) The network this subnet belongs to. Only networks that are in the distributed mode can have subnetworks."
}

variable "subnetwork_name" {
  type = string
  description = " (Required) The name of the resource, provided by the client when initially creating the resource."
}

variable "ip_cidr_range" {
  type = string
  description = "(Required) The range of internal addresses that are owned by this subnetwork"
}

variable "region" {
  type = string
  description = "(Optional) The GCP region for this subnetwork."
}


variable "google_compute_address_name" {
  type = string
  description = "(Required) A unique name for the resource, required by GCE."
}

variable "google_compute_vpn_gateway_name" {
  type = string
  description = " (Required) Name of the vpn_gateway. Provided by the client when the resource is created"
}

variable "forwarding_rules" {
  type = map(object({
    name        = string
    ip_protocol = string
    port_range  = string
  }))
  }

variable "vpn_tunnel_name" {
  type = string
  description = "(required) Name of the vpn_tunnel"
}

variable "local_traffic_selector" {
  type = list(string)
  description = "(Optional) Local traffic selector to use when establishing the VPN tunnel with peer VPN gateway. The value should be a CIDR formatted string, for example 192.168.0.0/16. The ranges should be disjoint. Only IPv4 is supported."
}

variable "remote_traffic_selector" {
  type = list(string)
  description = "(Optional) Remote traffic selector to use when establishing the VPN tunnel with peer VPN gateway. The value should be a CIDR formatted string, for example 192.168.0.0/16. The ranges should be disjoint. Only IPv4 is supported."
}

variable "google_compute_external_vpn_gateway" {
  type = string
  description = "(required) Name of the external_vpn_gateway"
}


variable "redundancy_type" {
  type = string
  description = "(Optional) Indicates the redundancy type of this external VPN gateway Possible values are: FOUR_IPS_REDUNDANCY, SINGLE_IP_INTERNALLY_REDUNDANT, TWO_IPS_REDUNDANCY."
}

