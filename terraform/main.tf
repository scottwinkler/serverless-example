module "apigw" {
    source = "./modules/apigw"
    project_name = "${var.project_name}"
    environment = "${var.environment}"
    lambda_arn = "${module.lambda.lambda_arn}"
}

module "rds" {
    source = "./modules/rds"
    project_name = "${var.project_name}"
    environment = "${var.environment}"
    region = "${var.region}"
    rds_user ="${var.rds_user}"
    rds_password ="${var.rds_password}"
}

module "lambda" {
    source = "./modules/lambda"
    project_name = "${var.project_name}"
    environment = "${var.environment}"
    role_arn = "${module.iam.lambda_role_arn}"
    rds_user ="${var.rds_user}"
    rds_password ="${var.rds_password}"
    rds_host = "${module.rds.rds_host}"
    rds_port = "${module.rds.rds_port}"
    rds_database = "${module.rds.rds_database}"
}

module "iam" {
    source = "./modules/iam"
    project_name = "${var.project_name}"
    environment = "${var.environment}"
}

module "s3" {
    source = "./modules/s3"
    project_name = "${var.project_name}"
    environment = "${var.environment}"
}