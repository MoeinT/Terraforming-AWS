locals {
  auth = {
    "access_key" : var.access_key
    "secret_key" : var.secret_key
  }

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

  security_groups = {

    sgpublic01 = {
      "description" : "Security group for public access",
      "vpc_id" : module.VPCs.vpc-ids["vpc-01"],
      "ingress" = {
        ssh = {
          "from_port" : 22,
          "to_port" : 22,
          "protocol" : "tcp",
          "cidr_blocks" : [var.ingress_access_ip]
        },

        http = {
          "from_port" : 80,
          "to_port" : 80,
          "protocol" : "tcp",
          "cidr_blocks" : [var.ingress_access_ip]
        }
      },
      "egress" = {
        "from_port" : 0,
        "to_port" : 0,
        "protocol" : -1,
        "cidr_blocks" : [var.egress_access_ip]
      }
    },

    sgprivaterds01 = {
      "description" : "A private security group for RDS",
      "vpc_id" : module.VPCs.vpc-ids["vpc-01"],
      "ingress" = {
        mysql = {
          "from_port" : 3306,
          "to_port" : 3306,
          "protocol" : "tcp",
          "cidr_blocks" : [var.cidr_block]
        }
      },
      "egress" = {
        "from_port" : 0,
        "to_port" : 0,
        "protocol" : -1,
        "cidr_blocks" : [var.egress_access_ip]
      }
    }

  }

  AllTargetGroups = {
    lb-tg-01 = {
      "port"     = 80
      "protocol" = "HTTP"
      "vpc_id"   = module.VPCs.vpc-ids["vpc-01"]
      "health_check" = {
        health_check_01 = {
          "healthy_threshold"   = 2,
          "unhealthy_threshold" = 2,
          "timeout"             = 3,
          "interval"            = 30
        }
      }
    }
  }

  allLoadBalancers = {
    "alb-01" = {
      "load_balancer_type" = "application",
      "security_groups" = [
        module.SecurityGroups.SecurityGroup_ids["sgpublic01"]
      ],
      "subnets" = [
        module.Subnets.subnet-ids["subnet-public-01"],
        module.Subnets.subnet-ids["subnet-public-02"]
      ]
    }
  }
}