module "allLoadBalancers" {
  source = "../../CommonModules/LoadBalancer"
  auth   = local.auth
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