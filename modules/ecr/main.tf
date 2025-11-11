resource "aws_ecr_repository" "repos" {
  for_each = toset(var.repositories)
  name = each.value
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration { scan_on_push = true }
  tags = { Name = each.value }
}
output "ecr_urls" {
  value = { for k, r in aws_ecr_repository.repos : k => r.repository_url }
}
