locals {
  tags = {
    Owner       = "Sophnel Merzier"
    Company     = "Dataiku"
    Project     = var.project_name
    Terraform   = "true"
    Environment = "prod"
  }
}
