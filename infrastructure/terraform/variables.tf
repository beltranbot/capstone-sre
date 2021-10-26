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

variable "APP_PORT" {
  type = number
}

variable "TAG_PREFIX" {
  type = string
}

variable "DATABASE_PORT" {
  type = number
}

variable "SNAPSHOT_IDENTIFIER" {
  type = string
}

variable "DEV_AMI_ID" {
  type = string
}

variable "STAGING_AMI_ID" {
  type = string
}

variable "PRODUCTION_AMI_ID" {
  type = string
}
