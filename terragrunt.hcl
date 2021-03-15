include {
  #path = "env/${get_aws_account_id()}.hcl"
  path = "env/any.hcl"
}

remote_state {
  backend = "s3"
  config = {
    bucket                          = "${get_aws_account_id()}-tfstate"
    dynamodb_table                  = "${get_aws_account_id()}-tfstate-locktable"
    region                          = "ap-southeast-2"
    key                             = "demo"
    skip_bucket_accesslogging       = true
    skip_bucket_root_access         = true
    encrypt                         = true
  }
}
