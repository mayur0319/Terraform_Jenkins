terraform {
  backend "s3" {
    bucket = "mayur-tfstate"
    key    = "path/tfstate"
    region = "us-east-1"
  }
}
