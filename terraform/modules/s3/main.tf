#static website s3 bucket
data "aws_iam_policy_document" "iam_policy_document" {
  statement {
    actions = [
      "s3:GetObject",
    ]

    principals = {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      "${aws_s3_bucket.s3_bucket.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = "${aws_s3_bucket.s3_bucket.id}"
  policy = "${data.aws_iam_policy_document.iam_policy_document.json}"
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket        = "${var.project_name}-${var.environment}"
  acl           = "private"
  force_destroy = true
}
