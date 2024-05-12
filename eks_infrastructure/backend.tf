terraform {
  backend "s3" {
    region  = "us-east-1"
    bucket  = "devops-test-12312413"
    key     = "test-eks/infra"
    profile = "default"
  }
}
