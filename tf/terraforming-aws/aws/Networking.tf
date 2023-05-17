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
  source     = "../../CommonModules/Subnets"
  auth       = local.auth
  allSubnets = local.allSubnets
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

module "SecurityGroups" {
  source          = "../../CommonModules/SecurityGroups"
  auth            = local.auth
  security_groups = local.security_groups
}

# To be further deployed
module "DBSubnetGroup" {
  source = "../../CommonModules/DBSubnetGroup"
  auth   = local.auth
  DBSubnetGroups = {
    db-subnetgroup-rds = {
      "subnet_ids" : [
        module.Subnets.subnet-ids["subnet-private-01"],
        module.Subnets.subnet-ids["subnet-private-02"],
        module.Subnets.subnet-ids["subnet-private-03"]
      ]
    }
  }
}