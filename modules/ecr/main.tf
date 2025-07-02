###############################################
# ECR Repository
###############################################

resource "aws_ecr_repository" "this" {
  name = "${var.project_name}-backend"
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "IMMUTABLE"
  force_delete         = true

  tags = merge(
    var.tags,
    { Name = "${var.project_name}-ecr" }
  )
}

###############################################
# Lifecycle policy is to keep the last 10 images
###############################################

resource "aws_ecr_lifecycle_policy" "retain_last_10" {
  repository = aws_ecr_repository.this.id

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Retain last 10 images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 10
        }
        action = { type = "expire" }
      }
    ]
  })
}
