locals {
  tag_dev        = "cbeltran-dev"
  tag_staging    = "cbeltran-staging"
  tag_production = "cbeltran-production"

  codedeploy_instance_role         = aws_iam_role.CodeDeployInstanceRole
  codedeploy_service_role          = aws_iam_role.CodeDeployServiceRole
  codedeploy_instance_role_profile = aws_iam_instance_profile.CodeDeployInstanceProfile
}

module "dev-environment" {
  source         = "./modules/environment"
  AWS_REGION     = var.AWS_REGION
  AWS_ACCESS_KEY = var.AWS_ACCESS_KEY
  AWS_SECRET_KEY = var.AWS_SECRET_KEY

  BUCKET_NAME                      = "${local.tag_dev}-bucket"
  AMI_ID                           = var.DEV_AMI_ID
  TAG_PREFIX                       = local.tag_dev
  PATH_TO_WEBSERVER_PUBLIC_KEY     = "webserver-dev.pub"
  PATH_TO_BASTION_PUBLIC_KEY       = "bastion-dev.pub"
  VPC_PREFIX                       = "10.0"
  APP_PORT                         = var.APP_PORT
  CD_DEPLOYMENT_GROUP              = "${local.tag_dev}-dg"
  APP_NAME                         = "${local.tag_dev}-app"
  CODEDEPLOY_SERVICE_ROLE          = local.codedeploy_service_role
  CODEDEPLOY_INSTANCE_ROLE_PROFILE = local.codedeploy_instance_role_profile
  DATABASE_PORT                    = var.DATABASE_PORT
  DATABASE_IDENTIFIER              = "${local.tag_dev}-rds"
  SNAPSHOT_IDENTIFIER              = var.SNAPSHOT_IDENTIFIER
}

module "staging-environment" {
  source         = "./modules/environment"
  AWS_REGION     = var.AWS_REGION
  AWS_ACCESS_KEY = var.AWS_ACCESS_KEY
  AWS_SECRET_KEY = var.AWS_SECRET_KEY

  BUCKET_NAME                      = "${local.tag_staging}-bucket"
  AMI_ID                           = var.STAGING_AMI_ID
  TAG_PREFIX                       = local.tag_staging
  PATH_TO_WEBSERVER_PUBLIC_KEY     = "webserver-staging.pub"
  PATH_TO_BASTION_PUBLIC_KEY       = "bastion-staging.pub"
  VPC_PREFIX                       = "10.1"
  APP_PORT                         = var.APP_PORT
  CD_DEPLOYMENT_GROUP              = "${local.tag_staging}-dg"
  APP_NAME                         = "${local.tag_staging}-app"
  CODEDEPLOY_SERVICE_ROLE          = local.codedeploy_service_role
  CODEDEPLOY_INSTANCE_ROLE_PROFILE = local.codedeploy_instance_role_profile
  DATABASE_PORT                    = var.DATABASE_PORT
  DATABASE_IDENTIFIER              = "${local.tag_staging}-rds"
  SNAPSHOT_IDENTIFIER              = var.SNAPSHOT_IDENTIFIER
}

module "production-environment" {
  source         = "./modules/environment"
  AWS_REGION     = var.AWS_REGION
  AWS_ACCESS_KEY = var.AWS_ACCESS_KEY
  AWS_SECRET_KEY = var.AWS_SECRET_KEY

  BUCKET_NAME                      = "${local.tag_production}-bucket"
  AMI_ID                           = var.PRODUCTION_AMI_ID
  TAG_PREFIX                       = local.tag_production
  PATH_TO_WEBSERVER_PUBLIC_KEY     = "webserver-prod.pub"
  PATH_TO_BASTION_PUBLIC_KEY       = "bastion-prod.pub"
  VPC_PREFIX                       = "10.2"
  APP_PORT                         = var.APP_PORT
  CD_DEPLOYMENT_GROUP              = "${local.tag_production}-dg"
  APP_NAME                         = "${local.tag_production}-app"
  CODEDEPLOY_SERVICE_ROLE          = local.codedeploy_service_role
  CODEDEPLOY_INSTANCE_ROLE_PROFILE = local.codedeploy_instance_role_profile
  DATABASE_PORT                    = var.DATABASE_PORT
  DATABASE_IDENTIFIER              = "${local.tag_production}-rds"
  SNAPSHOT_IDENTIFIER              = var.SNAPSHOT_IDENTIFIER
}
