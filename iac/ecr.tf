resource "aws_ecr_repository" "devops-ecr-repo" {
  name                 = "devops-ecr-repo"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "devops-ecr-repo"
    Environment = "Dev"
  }
}

resource "aws_ecr_lifecycle_policy" "my_ecr_lifecycle_policy" {
  repository = aws_ecr_repository.devops-ecr-repo.name
  policy     = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection    = {
          tagStatus = "any",
          countType = "imageCountMoreThan",
          countNumber = 30,
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}