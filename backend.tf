terraform {
  backend "s3" {
    bucket = "mayur-tfstate"
    key    = "path/"
    region = "us-east-2"
  }
}
