/* Test deployment permissions */
resource "aws_s3_bucket" "s3_tfstate_test" {
  bucket = "tfstate-backend-terraform111"
}