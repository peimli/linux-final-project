variable "aws_region" {
  description = "The AWS region to deploy resources in"
  default     = "eu-central-1"
}

variable "db_password" {
  description = "Password for the MySQL admin user"
  default     = "adminpassword"
}
