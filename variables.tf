locals {
  github_auth_token = jsondecode(data.aws_secretsmanager_secret_version.github_auth_token.secret_string)["value"]
  tags = {environment: "demo"}
}