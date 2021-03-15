module "cicd_pipeline" {
  source = "git@github.com:intelematics/public-tf-modules-common.git//codepipeline"
  
  github_auth_token = local.github_auth_token

  bucket_prefix = "${data.aws_caller_identity.current.account_id}-demo"
  build_library = { owner: "intelematics",
                    repo = "public-mule-aws-cicd-terraform-demo",
                    branch: "master"
                    }

  pipeline_name = "mulesoft-demo"
  
  environments = [{ name: "sandbox",
                    after_deploy: [ 
                                  ]
                    },
                  { name: "prod",
                    gate: {type: "manual"},
                    after_deploy: [ 
                                  ]
                    },
                 ]
  projects = {
               test-api:  { build: true, 
                            deploy: true, 
                            owner: "intelematics", 
                            repo: "public-mule-demo-test-api", 
                            branch: "master"}
             }

  tags = local.tags
}
