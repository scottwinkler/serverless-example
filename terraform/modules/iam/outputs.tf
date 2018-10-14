output "apigw_role_arn" {
    value = "${aws_iam_role.apigw_role.arn}"
}

output "lambda_role_arn" {
    value = "${aws_iam_role.lambda_role.arn}"
}