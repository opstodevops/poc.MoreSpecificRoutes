provider "aws" {
  region = var.region

  assume_role {
    role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.iam_role}"
  }

  ignore_tags {
    key_prefixes = ["managed:"]
  }

}
