

locals{
    lab_tag = "lab02"

    prefix = "${var.environment}-${local.lab_tag}" 

    common_tags = {
        Lab         = local.lab_tag
        Environment = var.environment
        ManagedBy   = "Terraform"
    }

    vnet_name = "${var.vnet_name}-${local.prefix}"
    private_endpoints_subnet_name = "${local.prefix}-pe-subnet"



}