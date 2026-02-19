<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eventbridge"></a> [eventbridge](#module\_eventbridge) | git::https://git@github.com/ucopacme/terraform-aws-eventbridge// | v0.0.2 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.cross_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.cross_account_targets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_codebuild_project.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codepipeline.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |
| [aws_iam_policy.cross_account_put_events](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.cross_account_put_events](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_s3_bucket.pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_iam_policy_document.assume_by_codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_by_pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codebuild_base](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codebuild_kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cross_account_put_events](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.pipeline_base](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.pipeline_bucket_base](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.pipeline_bucket_cross_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.pipeline_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.pipeline_cross_account_role_assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.pipeline_kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_APP_ENVIRONMENT"></a> [APP\_ENVIRONMENT](#input\_APP\_ENVIRONMENT) | Environment variable for consumption in CodeBuild (usually set to ucop:environment tag) | `string` | `""` | no |
| <a name="input_APP_NAME"></a> [APP\_NAME](#input\_APP\_NAME) | Environment variable for consumption in CodeBuild (usually set to ucop:application tag) | `string` | `""` | no |
| <a name="input_allowed_s3_bucket_names"></a> [allowed\_s3\_bucket\_names](#input\_allowed\_s3\_bucket\_names) | S3 buckets for which access will be granted in IAM policies | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | n/a | `string` | `""` | no |
| <a name="input_branchname"></a> [branchname](#input\_branchname) | n/a | `string` | `null` | no |
| <a name="input_cloudwatch_event_rule_state"></a> [cloudwatch\_event\_rule\_state](#input\_cloudwatch\_event\_rule\_state) | State of event rules that trigger CodePipline. Set to DISABLED if commits should not trigger the pipeline. | `string` | `"ENABLED"` | no |
| <a name="input_codebuild_compute_type"></a> [codebuild\_compute\_type](#input\_codebuild\_compute\_type) | n/a | `string` | `"BUILD_GENERAL1_SMALL"` | no |
| <a name="input_codebuild_description"></a> [codebuild\_description](#input\_codebuild\_description) | (Optional) description for CodeBuild project | `string` | `""` | no |
| <a name="input_codebuild_image"></a> [codebuild\_image](#input\_codebuild\_image) | n/a | `string` | `"aws/codebuild/amazonlinux2-aarch64-standard:3.0"` | no |
| <a name="input_codebuild_name"></a> [codebuild\_name](#input\_codebuild\_name) | (Optional) custom name for CodeBuild project | `string` | `""` | no |
| <a name="input_codebuild_privileged_mode"></a> [codebuild\_privileged\_mode](#input\_codebuild\_privileged\_mode) | n/a | `bool` | `false` | no |
| <a name="input_codebuild_type"></a> [codebuild\_type](#input\_codebuild\_type) | n/a | `string` | `"ARM_CONTAINER"` | no |
| <a name="input_codepipeline_cross_account_ids"></a> [codepipeline\_cross\_account\_ids](#input\_codepipeline\_cross\_account\_ids) | (Optional) account IDs that will be granted access to codepipeline bucket | `list(string)` | `[]` | no |
| <a name="input_codepipeline_cross_account_role_arn"></a> [codepipeline\_cross\_account\_role\_arn](#input\_codepipeline\_cross\_account\_role\_arn) | (Optional) role ARN that CodePipeline service role will be granted access to assume | `string` | `null` | no |
| <a name="input_codepipeline_kms_key_arn"></a> [codepipeline\_kms\_key\_arn](#input\_codepipeline\_kms\_key\_arn) | (Optional) ARN of KMS key used to encrypt CodePipeline artifacts uploaded to S3 | `string` | `null` | no |
| <a name="input_codepipeline_name"></a> [codepipeline\_name](#input\_codepipeline\_name) | (Optional) custom name for pipeline | `string` | `""` | no |
| <a name="input_cross_account_branchname"></a> [cross\_account\_branchname](#input\_cross\_account\_branchname) | n/a | `string` | `null` | no |
| <a name="input_ecr_repository_arns"></a> [ecr\_repository\_arns](#input\_ecr\_repository\_arns) | ECR repository ARNs to be used by CodeBuild project | `list(string)` | `[]` | no |
| <a name="input_eventbridge_cross_account_ids"></a> [eventbridge\_cross\_account\_ids](#input\_eventbridge\_cross\_account\_ids) | (Optional) account IDs we allow our eventbridge role to PutEvents to (for triggering cross account pipeline execution) | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `""` | no |
| <a name="input_poll_for_source_changes"></a> [poll\_for\_source\_changes](#input\_poll\_for\_source\_changes) | Whether to poll for source changes in CodeCommit repository | `string` | `"false"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"us-west-2"` | no |
| <a name="input_repository_arn"></a> [repository\_arn](#input\_repository\_arn) | n/a | `string` | `null` | no |
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name) | n/a | `string` | `null` | no |
| <a name="input_secondary_artifact"></a> [secondary\_artifact](#input\_secondary\_artifact) | Secondary artifact names for CodeBuild project | <pre>list(object({<br>    name      = string<br>    type      = optional(string)<br>    path      = optional(string)<br>    bucket    = optional(string)<br>    packaging = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_secondary_sources"></a> [secondary\_sources](#input\_secondary\_sources) | Secondary sources for CodeBuild project | <pre>list(object({<br>    name                    = optional(string)<br>    category                = optional(string)<br>    owner                   = optional(string)<br>    provider                = optional(string)<br>    version                 = optional(string)<br>    output_artifact         = optional(string)<br>    repository_name         = optional(string)<br>    branch_name             = optional(string)<br>    poll_for_source_changes = optional(string)<br>    location                = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_skip_default_pipeline"></a> [skip\_default\_pipeline](#input\_skip\_default\_pipeline) | Skip creation of default pipeline. Useful for creating pipelines that do not use CodeCommit as a source. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_tf_buildspec"></a> [tf\_buildspec](#input\_tf\_buildspec) | Terraform buildspec file | `string` | `""` | no |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | Custom VPC definitions to host the build servers. Omit if using default VPC and no need to access resources, object properties are not really optional if including this config. | <pre>object({<br>    security_group_ids = optional(list(string))<br>    subnets            = optional(list(string))<br>    vpc_id             = optional(string)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_build_role_name"></a> [iam\_build\_role\_name](#output\_iam\_build\_role\_name) | IAM role name for CodeBuild |
| <a name="output_iam_pipeline_role_name"></a> [iam\_pipeline\_role\_name](#output\_iam\_pipeline\_role\_name) | IAM role name for CodePipeline |
<!-- END_TF_DOCS -->

```hcl
module "test_build_pipeline" {
  source = "git::https://github.com/ucopacme/terraform-aws-build-pipeline.git?ref=v0.1.0"

  name                    = examplepipeline
  allowed_s3_bucket_names = [ module.s3_provenance_bucket.bucket_id[0] ]
  aws_account_id          = data.aws_caller_identity.current.account_id
  region                  = "us-west-2"

  APP_ENVIRONMENT = prod
  APP_NAME        = chs-tools

  cloudwatch_event_rule_state = "ENABLED"

  codebuild_compute_type    = "BUILD_GENERAL1_MEDIUM"
  codebuild_image           = "944706592399.dkr.ecr.us-west-2.amazonaws.com/windows-2019-build:v0.0.1"
  codebuild_privileged_mode = false
  codebuild_type            = "WINDOWS_SERVER_2019_CONTAINER"

  branchname      = "master"
  repository_arn  = "arn:aws:codecommit:us-west-2:${data.aws_caller_identity.current.account_id}:demo-dotnet"
  repository_name = "demo-dotnet"

  skip_default_pipeline = false
  secondary_artifact = [{
    name = "provenance"
    type = "S3"
    path = chs/prod/build/provenance/binaries
    bucket = module.s3_provenance_bucket.bucket_id[0]
  }]
  
  tf_buildspec = "buildspec.yml"

  secondary_sources = [{
    name = "dependencies"
    repository_name = "kk-test"
    branch_name = "master"
    location = "arn:aws:codecommit:us-west-2:${data.aws_caller_identity.current.account_id}:kk-test"
    output_artifact = "dependencies"
  }]

  tags = local.tags
}
```