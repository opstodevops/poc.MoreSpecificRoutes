terraform {
  required_version = ">= 0.11.0"

  // Send the state to our S3 bucket. Only the key should be changed
  // All the other parameters are fixed regardless of the account/region
  // the template will use.
  backend "s3" {
    region         = "ap-southeast-2"
    bucket         = "my-networks-terraform"
    role_arn       = "arn:aws:iam::123456789012:role/IAMROLE"
    dynamodb_table = "my-terraform-statelock"

    key = "my-networks/us-west-2/more-specific-routing/terraform.tfstate"
  }
}
