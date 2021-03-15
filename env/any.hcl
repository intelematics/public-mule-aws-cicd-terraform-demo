
# Sandbox account

inputs = {
  environment     = "build"
  build_environments = {
                        sandbox: {mule_env: "Sandbox"}
                      }
  accounts = {
                sandbox: "143967644139",
             }
  account_info = {
                    sandbox:  {insight_aws_creds_arn: "arn:aws:secretsmanager:ap-southeast-2:143967644139:secret:Insight_AWS_user_sandbox-nKQo4G"},
                  }

  mulesoft_business_groups = { 
                                cloud_platform: {name = "Cloud Platform"}
                             }

  components = {
                  s-azure-api:            {build: true, deploy: true, mulesoft_business_group = "cloud_platform", repo: "mule-s-azure-api"}
                  p-housekeeping-api:     {build: true, deploy: true, mulesoft_business_group = "cloud_platform", repo: "mule-p-housekeeping-api"}
                }
}
