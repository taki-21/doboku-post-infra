variable "app_name" {}

variable "azs" {
  type    = list(string)
  default = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
}

variable "azs_name" {
  type    = list(string)
  default = ["1a", "1c", "1d"]
}
variable "vpc_cidr" {
  default = "100.0.0.0/16"
}
variable "public_subnet_cidrs" {
  default = ["100.0.0.0/24", "100.0.1.0/24", "100.0.2.0/24"]
}
variable "private_subnet_cidrs" {
  default = ["100.0.10.0/24", "100.0.11.0/24", "100.0.12.0/24"]
}
