locals {
  auth = {
    "access_key" : var.access_key
    "secret_key" : var.secret_key
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
}