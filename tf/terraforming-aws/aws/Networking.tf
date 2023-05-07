module "VPCs" {
  source = "../../CommonModules/Networking"
  auth   = local.auth
  allVPCs = {
    "vpc-01" = {
      "cidr_block"           = var.cidr_block,
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
      "cidr_block"              = cidrsubnet(var.cidr_block, 8, 2)
      "map_public_ip_on_launch" = true,
      "availability_zone"       = data.aws_availability_zones.availableRegions.names[0]
    },

    "subnet-public-02" = {
      "vpc_id"                  = module.VPCs.vpc-ids["vpc-01"],
      "cidr_block"              = cidrsubnet(var.cidr_block, 8, 4)
      "map_public_ip_on_launch" = true,
      "availability_zone"       = data.aws_availability_zones.availableRegions.names[1]
    },

    /* Private Subnets*/
    "subnet-private-01" = {
      "vpc_id"                  = module.VPCs.vpc-ids["vpc-01"],
      "cidr_block"              = cidrsubnet(var.cidr_block, 8, 1)
      "map_public_ip_on_launch" = false,
      "availability_zone"       = data.aws_availability_zones.availableRegions.names[0]
    },

    "subnet-private-02" = {
      "vpc_id"                  = module.VPCs.vpc-ids["vpc-01"],
      "cidr_block"              = cidrsubnet(var.cidr_block, 8, 3)
      "map_public_ip_on_launch" = false,
      "availability_zone"       = data.aws_availability_zones.availableRegions.names[1]
    },

    "subnet-private-03" = {
      "vpc_id"                  = module.VPCs.vpc-ids["vpc-01"],
      "cidr_block"              = cidrsubnet(var.cidr_block, 8, 5)
      "map_public_ip_on_launch" = false,
      "availability_zone"       = data.aws_availability_zones.availableRegions.names[2]
    }
  }
}


module "InternetGateway" {
  source = "../../CommonModules/InternetGateway"
  auth   = local.auth
  internetGateways = {
    "gateway-01" = {
      "vpc_id" : module.VPCs.vpc-ids["vpc-01"]
    }
  }
}

# Routing tables with an internet gateway as a default route
module "RoutingTables" {
  source             = "../../CommonModules/RoutingTables"
  auth               = local.auth
  default_gateway_id = module.InternetGateway.internetGateway-ids["gateway-01"]
  routingTables = {
    "routingTable-01" = {
      "vpc_id" : module.VPCs.vpc-ids["vpc-01"]
    }
  }
}

module "RTAssociations" {
  source = "../../CommonModules/RouteTableAssociation"
  auth   = local.auth
  RouteTableAssociations = {
    subnet-rt-01 = {
      "subnet_id"      = module.Subnets.subnet-ids["subnet-public-01"],
      "route_table_id" = module.RoutingTables.routingTable-ids["routingTable-01"]
    },

    subnet-rt-02 = {
      "subnet_id"      = module.Subnets.subnet-ids["subnet-public-02"],
      "route_table_id" = module.RoutingTables.routingTable-ids["routingTable-01"]
    }
  }
}