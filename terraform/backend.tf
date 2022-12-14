terraform {
  required_version = "0.14.7"
  backend "s3" {
    bucket = "doboku-post-remote-state"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}
