#apigw role
data "aws_iam_policy_document" "api_assume_role_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "apigw_role" {
  name = "cloudwatch-role-${var.project_name}-${var.environment}"
  path = "/"
  assume_role_policy = "${data.aws_iam_policy_document.api_assume_role_policy_document.json}"
}

data "aws_iam_policy_document" "logger_policy_document" {
  statement {
      effect = "Allow"
      actions = [
        "logs:*",
      ]
      resources = [
          "arn:aws:logs:*:*:*"
      ] 
  }
}

resource "aws_iam_policy" "logger_policy" {
  name = "apigw-logger-${var.project_name}-${var.environment}"
  path = "/"
  policy = "${data.aws_iam_policy_document.logger_policy_document.json}"
}

resource "aws_iam_policy_attachment" "logger_role_attachment" {
  name = "apigw-logger-attachment-${var.project_name}-${var.environment}"
  roles = ["${aws_iam_role.apigw_role.name}"]
  policy_arn = "${aws_iam_policy.logger_policy.arn}"
}

resource "aws_api_gateway_account" "cloudwatch_apigw_logs" {
  cloudwatch_role_arn = "${aws_iam_role.apigw_role.arn}"
}

#lambda role
data "aws_iam_policy_document" "lambda_assume_role_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_iam_policy_document" {
  statement {
      effect = "Allow"
      actions = [
        "s3:*",
        "logs:*",
        "rds:*",
        "ec2:*"
      ]
      resources = [
          "*"
      ] 
  }
}

resource "aws_iam_policy" "lambda_iam_policy" {
  name = "lambda-policy-${var.project_name}-${var.environment}"
  path = "/"
  policy = "${data.aws_iam_policy_document.lambda_iam_policy_document.json}"
}

resource "aws_iam_role" "lambda_role" {
  name               = "lambda-role-${var.project_name}-${var.environment}"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_assume_role_policy_document.json}"
}

resource "aws_iam_policy_attachment" "lambda_iam_policy_role_attachment" {
  name = "lambda-policy-attachment-${var.project_name}-${var.environment}"
  roles = ["${aws_iam_role.lambda_role.name}"]
  policy_arn = "${aws_iam_policy.lambda_iam_policy.arn}"
}
