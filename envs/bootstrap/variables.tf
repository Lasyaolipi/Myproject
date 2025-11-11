variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "bucket_name" {
  type    = string
  default = "terraform-backend-391313099163"
}

variable "dynamodb_table" {
  type    = string
  default = "terraform-locks"
}
