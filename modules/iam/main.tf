data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "github_oidc_assume" {
  statement {
    effect = "Allow"
    principals {
      type = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"]
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = ["repo:${var.github_org}/${var.repo}:ref:refs/heads/*", "repo:${var.github_org}/${var.repo}:ref:refs/tags/*"]
    }
  }
}

resource "aws_iam_role" "github_actions" {
  name = var.role_name
  assume_role_policy = data.aws_iam_policy_document.github_oidc_assume.json
}

resource "aws_iam_role_policy" "basic_policy" {
  name = "${var.role_name}-policy"
  role = aws_iam_role.github_actions.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "s3:*",
          "cloudtrail:LookupEvents",
          "sts:AssumeRole"
        ]
        Resource = "*"
      }
    ]
  })
}

output "role_arn" { value = aws_iam_role.github_actions.arn }
