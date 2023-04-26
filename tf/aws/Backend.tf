/* Backend Configuration */

resource "aws_s3_bucket" "s3-tfstate" {
  bucket = "tfstate"

  tags = {
    Name        = "Terraform Backend"
  }
}