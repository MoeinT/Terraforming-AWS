/* Creating Users */
module "Users" {
  source    = "../../CommonModules/User"
  usernames = ["MoeinTerraform"]
  auth      = local.auth
}

/* Creating groups */
module "Groups" {
  source = "../../CommonModules/Group"
  groups = ["admins"]
  auth   = local.auth
}

/* Assiging users to groups */
module "Assignments" {
  source = "../../CommonModules/Assignments"
  userGroups = {
    (module.Users.usernames["MoeinTerraform"]) : [
      module.Groups.groupname["admins"]
    ]
  }
  auth = local.auth
}

/* Permissions to Groups */
module "GroupPermissions" {
  source = "../../CommonModules/Permission"
  groupPermissions = {
    (module.Groups.groupname["admins"]): "arn:aws:iam::aws:policy/AdministratorAccess"
  }
  auth = local.auth
}

