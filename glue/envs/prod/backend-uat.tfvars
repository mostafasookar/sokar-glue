bucket         = "pgadmin-terraform-state-test"
key            = "sokar-glue/prod/terraform.tfstate"
region         = "us-east-1"
encrypt        = true
dynamodb_table = "pgadmin-terraform-locks"
