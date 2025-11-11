output "vpc_id" { value = module.vpc.vpc_id }
output "ecr_urls" { value = module.ecr.ecr_urls }
output "github_actions_role_arn" { value = module.iam.role_arn }
output "eks_endpoint" { value = module.eks.cluster_endpoint }
