terraform {
  backend "s3" {
    bucket         = "dku-smr-candidate-assessment"
    key            = "terraform/state.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "dataiku-tf-lock"
    encrypt        = true
  }
}
