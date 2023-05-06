module "VPCs" {
  source = "../../CommonModules/Networking"
  auth   = local.auth
  allVPCs = {
    "vpc-01" = {
      "cidr_block"           = "10.123.0.0/16",
      "enable_dns_hostnames" = true,
      "enable_dns_support"   = true
    }
  }
}

/* All Subnets within the above VPCs */
module "Subnets" {
  source = "../../CommonModules/Subnets"
  auth   = local.auth
  allSubnets = {

    /* Public Subnets*/
    "subnet-public-01" = {
      "vpc_id"                  = module.VPCs.vpc-ids["vpc-01"],
      "cidr_block"              = cidrsubnet("10.123.0.0/16", 8, 2)
      "map_public_ip_on_launch" = true,
      "availability_zone"       = data.aws_availability_zones.availableRegions.names[0]
    },

    "subnet-public-02" = {
      "vpc_id"                  = module.VPCs.vpc-ids["vpc-01"],
      "cidr_block"              = cidrsubnet("10.123.0.0/16", 8, 4)
      "map_public_ip_on_launch" = true,
      "availability_zone"       = data.aws_availability_zones.availableRegions.names[1]
    },

    /* Private Subnets*/
    "subnet-private-01" = {
      "vpc_id"                  = module.VPCs.vpc-ids["vpc-01"],
      "cidr_block"              = cidrsubnet("10.123.0.0/16", 8, 1)
      "map_public_ip_on_launch" = false,
      "availability_zone"       = data.aws_availability_zones.availableRegions.names[0]
    },

    "subnet-private-02" = {
      "vpc_id"                  = module.VPCs.vpc-ids["vpc-01"],
      "cidr_block"              = cidrsubnet("10.123.0.0/16", 8, 3)
      "map_public_ip_on_launch" = false,
      "availability_zone"       = data.aws_availability_zones.availableRegions.names[1]
    },

    "subnet-private-03" = {
      "vpc_id"                  = module.VPCs.vpc-ids["vpc-01"],
      "cidr_block"              = cidrsubnet("10.123.0.0/16", 8, 5)
      "map_public_ip_on_launch" = false,
      "availability_zone"       = data.aws_availability_zones.availableRegions.names[2]
    }
  }
}