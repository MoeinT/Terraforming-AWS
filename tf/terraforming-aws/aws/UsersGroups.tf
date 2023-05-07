# Creating users
module "Users" {
  source    = "../../CommonModules/User"
  usernames = ["MoeinTerraform"]
  auth      = local.auth
}

# Creating groups
module "Groups" {
  source = "../../CommonModules/Group"
  auth   = local.auth
  groups = ["admins"]
}

# Assigning users to groups
module "Assignments" {
  source = "../../CommonModules/Assignments"
  auth   = local.auth
  userGroups = {
    (module.Users.usernames["MoeinTerraform"]) : [
      module.Groups.groupname["admins"]
    ]
  }
}

# Adding permissions to the above groups
module "GroupPermissions" {
  source = "../../CommonModules/Permission"
  auth   = local.auth
  groupPermissions = {
    (module.Groups.groupname["admins"]) : "arn:aws:iam::aws:policy/AdministratorAccess"
  }
}