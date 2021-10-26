variable "AWS_REGION" {
  type = string
  default = "us-east-1"
}

variable "AWS_ACCESS_KEY" {
  type = string
}

variable "AWS_SECRET_KEY" {
  type = string
}

variable "BUCKET_NAME" {
  type = string
}

variable "AMI_ID" {
  type = string
}

variable "TAG_PREFIX" {
  type = string
}

variable "PATH_TO_WEBSERVER_PUBLIC_KEY" {
  type = string
}

variable "PATH_TO_BASTION_PUBLIC_KEY" {
  type = string
}

variable "VPC_PREFIX" {
  type = string
}

variable "APP_PORT" {
  type = number
}

variable "CD_DEPLOYMENT_GROUP" {
  type = string
}

variable "APP_NAME" {
  type = string
}

variable "CODEDEPLOY_INSTANCE_ROLE_PROFILE" {}

variable "CODEDEPLOY_SERVICE_ROLE" {}

variable "DATABASE_PORT" {
  type = number
}

variable "DATABASE_IDENTIFIER" {
  type = string
}

variable "SNAPSHOT_IDENTIFIER" {
  type = string
}
