variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "github_org" {
  type = string
}

variable "repo" {
  type = string
}

variable "role_name" {
  type    = string
  default = "github-actions-role"
}

variable "cluster_name" {
  type    = string
  default = "prod-eks"
}
