
# RDS instances
module "AllDBInstances" {
  source = "../../CommonModules/Databases"
  auth   = local.auth
  AllDBInstances = {
    rds-instnace = {
      "allocated_storage"      = 10,
      "db_name"                = "mydb",
      "engine"                 = "mysql",
      "engine_version"         = 5.7,
      "instance_class"         = "db.t2.micro",
      "username"               = var.dbusername,
      "password"               = var.dbpassword,
      "identifier"             = "moein-db",
      "db_subnet_group_name"   = module.DBSubnetGroup.DBSubnetGroup_names["db-subnetgroup-rds"],
      "vpc_security_group_ids" = [module.SecurityGroups.SecurityGroup_ids["sgprivaterds01"]]
      "skip_final_snapshot"    = true
    }
  }
}