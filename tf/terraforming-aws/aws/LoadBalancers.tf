# Application load balancer
module "allLoadBalancers" {
  source           = "../../CommonModules/LoadBalancer"
  auth             = local.auth
  allLoadBalancers = local.allLoadBalancers
}

# Target Groups
module "TargetGroup" {
  source = "../../CommonModules/TargetGroup"
  auth   = local.auth
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
}

# Listener 
module "Listeners" {
  source = "../../CommonModules/LBListener"
  auth   = local.auth
  AllListeners = {
    listener-01 = {
      "load_balancer_arn"   = module.allLoadBalancers.loadBalancer_arn["alb-01"],
      "port"                = 80,
      "protocol"            = "HTTP",
      "default_action_type" = "forward",
      "target_group_arn"    = module.TargetGroup.TargetGroup_arns["lb-tg-01"]
    }
  }
}

