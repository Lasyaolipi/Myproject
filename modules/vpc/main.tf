data "aws_availability_zones" "available" {}

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = { Name = "main-vpc" }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = { Name = "igw" }
}

resource "aws_subnet" "public" {
  for_each = { for idx, cidr in var.public_subnets : idx => cidr }
  vpc_id = aws_vpc.this.id
  cidr_block = each.value
  availability_zone = data.aws_availability_zones.available.names[floor(random_integer.public_index.result % length(data.aws_availability_zones.available.names))]
  map_public_ip_on_launch = true
  tags = { Name = "public-${each.key}" }
}

resource "random_integer" "public_index" {
  min = 0
  max = 99
}

resource "aws_subnet" "private" {
  for_each = { for idx, cidr in var.private_subnets : idx => cidr }
  vpc_id = aws_vpc.this.id
  cidr_block = each.value
  availability_zone = data.aws_availability_zones.available.names[floor(random_integer.public_index.result % length(data.aws_availability_zones.available.names))]
  tags = { Name = "private-${each.key}" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  tags = { Name = "public-rt" }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}
