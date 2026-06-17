module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  count                           = length(var.repository_name)
  repository_name                 = var.repository_name[count.index]
  repository_image_tag_mutability = "MUTABLE"
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Expire untagged images after 30 days",
        selection = {
          tagStatus   = "untagged",
          countType   = "sinceImagePushed",
          countUnit   = "days"
          countNumber = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
  tags = var.tags
}