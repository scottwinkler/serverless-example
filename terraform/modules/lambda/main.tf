
resource "aws_lambda_function" "lambda_function" {
  filename = "${path.cwd}/../server/deployment.zip"
  function_name = "${var.project_name}-lambda"
  handler       = "main"
  role          = "${var.role_arn}"
  memory_size   = 256
  runtime       = "go1.x"
  timeout       = 60

  environment = {
    variables {
      rds_user = "${var.rds_user}"
      rds_password = "${var.rds_password}"
      rds_host = "${var.rds_host}"
      rds_port = "${var.rds_port}"
      rds_database = "${var.rds_database}"
    }
  }

  vpc_config {
    subnet_ids = ["subnet-d85b41bf","subnet-68da6633","subnet-c0cef389"]
    security_group_ids = ["sg-6c1bb816"]
  }
}		