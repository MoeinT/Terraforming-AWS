
# RDS instances
module "AllDBInstances" {
  source = "../../CommonModules/Databases"
  auth   = local.auth
  AllDBInstances = {
    rancher-dbinstnace = {
      "allocated_storage"      = 10,
      "db_name"                = var.rancher_dbname,
      "engine"                 = "mysql",
      "engine_version"         = 5.7,
      "instance_class"         = "db.t2.micro",
      "username"               = var.rancher_dbusername,
      "password"               = var.rancher_dbpassword,
      "identifier"             = "moein-db",
      "db_subnet_group_name"   = module.DBSubnetGroup.DBSubnetGroup_names["db-subnetgroup-rds"],
      "vpc_security_group_ids" = [module.SecurityGroups.SecurityGroup_ids["sgprivaterds01"]]
      "skip_final_snapshot"    = true
    }
  }
}