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