resource "aws_secretsmanager_secret" "github_auth_token" {
  name = "Github_Auth_Token"

  tags = local.tags
}

data "aws_secretsmanager_secret_version" "github_auth_token" {
  secret_id = aws_secretsmanager_secret.github_auth_token.id
}

resource "aws_secretsmanager_secret" "maven_settings_key" {
  name = "Maven_Settings_Key"

  tags = local.tags
}
