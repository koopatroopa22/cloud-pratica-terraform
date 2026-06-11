terraform {
  backend "s3" {
    bucket = "cp-terraform-muncha-stg"
    key    = "main.tfstate"
    region = "ap-northeast-1"
  }
}
