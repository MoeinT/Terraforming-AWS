/* Creating an S3 bucket for the backend .tfstate file */
resource "aws_s3_bucket" "s3_test" {
  bucket = "test-moein"
}