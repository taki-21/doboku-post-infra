variable "app_name" {}

variable "db_name" {}

variable "db_username" {}

variable "db_password" {}

variable "db_host" {}

variable "master_key" {}

variable "apps_name" {
  default = ["nginx", "django"]
}

variable "vpc_id" {}

variable "http_listener_arn" {}

variable "https_listener_arn" {}

variable "alb_security_group" {}

variable "cluster_name" {}

variable "public_subnet_ids" {}
