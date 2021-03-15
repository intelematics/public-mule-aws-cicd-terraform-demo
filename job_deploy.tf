module "deploy_mule" {
  for_each = toset(["sandbox","prod"])

  source = "git@github.com:intelematics/tf-modules-common.git//codebuild?ref=v4.2.2"
  
  bucket_prefix = "${data.aws_caller_identity.current.account_id}-demo"
  codebuild_project_name = "deploy-test-api"

  buildspec = file("buildspecs/mule-deploy.yml")
  github_auth_token = local.github_auth_token
  project = {
    owner: "intelematics",
    branch: "master",
    repo: "mule-demo-test-api"
  }
  environment = each.key
  environment_variables = {
    ANYPOINT_ENV: {sandbox: "Sandbox", prod: "Prod"}[each.key],
    ANYPOINT_ORG: var.business_group,
  }

  policy = data.aws_iam_policy_document.deploy_policy.json

  tags = local.tags
}


data "aws_iam_policy_document" "deploy_policy" {
  statement {
    effect = "Allow"

    actions = [
      "secretsmanager:GetSecretValue",
    ]

    resources = [
      aws_secretsmanager_secret.anypoint_build.arn
    ]
  }
}
