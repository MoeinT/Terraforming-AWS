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
      "vpc_id"                  = module.VPCs.vpc-ids[0].vpc-01.id,
      "cidr_block"              = "10.123.2.0/24",
      "map_public_ip_on_launch" = true,
      "availability_zone"       = "eu-west-3a"
    },

    "subnet-public-02" = {
      "vpc_id"                  = module.VPCs.vpc-ids[0].vpc-01.id,
      "cidr_block"              = "10.123.4.0/24",
      "map_public_ip_on_launch" = true,
      "availability_zone"       = "eu-west-3b"
    },

    /* Private Subnets*/
    "subnet-private-01" = {
      "vpc_id"                  = module.VPCs.vpc-ids[0].vpc-01.id,
      "cidr_block"              = "10.123.1.0/24",
      "map_public_ip_on_launch" = false,
      "availability_zone"       = "eu-west-3a"
    },

    "subnet-private-02" = {
      "vpc_id"                  = module.VPCs.vpc-ids[0].vpc-01.id,
      "cidr_block"              = "10.123.3.0/24",
      "map_public_ip_on_launch" = false,
      "availability_zone"       = "eu-west-3b"
    },

    "subnet-private-03" = {
      "vpc_id"                  = module.VPCs.vpc-ids[0].vpc-01.id,
      "cidr_block"              = "10.123.5.0/24",
      "map_public_ip_on_launch" = false,
      "availability_zone"       = "eu-west-3c"
    }
  }
}