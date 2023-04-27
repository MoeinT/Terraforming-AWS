/*Creating a user*/
resource "aws_iam_user" "TestUser" {
  name = "TestUser"
}

/*Creating a Group*/
resource "aws_iam_group" "TestGroup" {
  name = "TestGroup"
}

/* Assigning the User to the group */
resource "aws_iam_user_group_membership" "example1" {
  user = aws_iam_user.TestUser.name

  groups = [
    aws_iam_group.TestGroup.name
  ]
}

resource "aws_iam_group_policy_attachment" "policy_attachment" {
  group      = aws_iam_group.TestGroup.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

module "Users" {
  source    = "../../CommonModules/User"
  usernames = ["MoeinTerraform"]
  auth      = local.auth
}

module "Groups" {
  source = "../../CommonModules/Group"
  groups = ["admins"]
  auth   = local.auth
}

/* module.Users.usernames["MoeinTerraform"] */