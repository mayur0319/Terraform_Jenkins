resource "aws_s3_bucket" "example" {
  bucket = "mayur-jenkins-project"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
