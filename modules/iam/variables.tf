variable "github_org" { type = string }
variable "repo" { type = string }
variable "role_name" {
  type    = string
  default = "github-actions-role"
}
variable "region" {
  type    = string
  default = "ap-south-1"
}

