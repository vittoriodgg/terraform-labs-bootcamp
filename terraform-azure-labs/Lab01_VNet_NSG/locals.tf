
locals {
  # Lab Tag - Cambia questo in ogni lab (Lab02, Lab03, ecc.)
  lab_tag = "Lab01"

  # Prefix basato su variabili
  prefix = "${var.environment}-${local.lab_tag}"

  # Common tags da applicare a tutte le risorse
  common_tags = {
    Lab         = local.lab_tag
    Environment = var.environment
    ManagedBy   = "Terraform"
  }

  
  
  
  vnet_name = "${var.vnet_name}-${local.prefix}"
  subnet_names = {
    for subnet, addr in var.subnets_names :
            "${subnet}-${local.prefix}" => addr
  }


  nsg_rules = {
    "frontend" = [
        {
            name = "Allow-HTTPS"
            priority = 100
            direction = "Inbound"
            access = "Allow"
            protocol = "Tcp"
            destination_port_range = "443"
            source_address_prefix = "*"
            source_address_prefixes = []
            destination_address_prefix = "*"
            source_port_range = "*"
        }

    ]
    "backend" = [
        {
            name = "Allow-Frontend-HTTPS"
            priority = 100
            direction = "Inbound"
            access = "Allow"
            protocol = "Tcp"
            destination_port_range = "8080"
            source_address_prefix = null
            source_address_prefixes = var.subnets_names["frontend-rg-digiorgio"]
            source_port_range = "*"
            destination_address_prefix = "*"


        },

        {
            name = "Deny-Internet"
            priority = 200
            direction = "Inbound"
            access = "Deny"
            protocol = "*"
            source_address_prefix = "*"
            source_address_prefixes = []
            source_port_range = "*"
            destination_address_prefix = "*"
            destination_port_range = "*"
        }

    ]
  }

}