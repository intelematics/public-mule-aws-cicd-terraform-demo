module "build_mule" {
  source = "git@github.com:intelematics/public-tf-modules-common.git//codebuild"
  
  bucket_prefix = "${data.aws_caller_identity.current.account_id}-demo"
  codebuild_project_name = "test-api"

  buildspec = file("buildspecs/mule-build.yml")
  github_auth_token = local.github_auth_token
  project = {
    owner: "intelematics",
    branch: "master",
    repo: "public-mule-demo-test-api"
  }
  environment = "build"

  policy = data.aws_iam_policy_document.build_policy.json

  tags = local.tags
}


data "aws_iam_policy_document" "build_policy" {
  statement {
    effect = "Allow"

    actions = [
      "secretsmanager:GetSecretValue",
    ]

    resources = [
      aws_secretsmanager_secret.maven_settings_key.arn
    ]
  }
}
