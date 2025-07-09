variable "name" {
  type    = string
  default = ""
}

variable "allowed_s3_bucket_names" {
  description = "S3 buckets for which access will be granted in IAM policies"
  type        = list(string)
  default     = ["*"]
}

variable "branchname" {
  type    = string
  default = null
}

variable "cloudwatch_event_rule_state" {
  description = "State of event rules that trigger CodePipline. Set to DISABLED if commits should not trigger the pipeline."
  type        = string
  default     = "ENABLED"
}

variable "codebuild_compute_type" {
  type    = string
  default = "BUILD_GENERAL1_SMALL"
}

variable "codebuild_description" {
  description = "(Optional) description for CodeBuild project"
  type        = string
  default     = ""
}

variable "codebuild_image" {
  type    = string
  default = "aws/codebuild/amazonlinux2-aarch64-standard:3.0"
}

variable "codebuild_name" {
  description = "(Optional) custom name for CodeBuild project"
  type        = string
  default     = ""
}

variable "codebuild_type" {
  type    = string
  default = "ARM_CONTAINER"
}

variable "codebuild_privileged_mode" {
  default = false
  type    = bool
}

variable "codepipeline_cross_account_ids" {
  description = "(Optional) account IDs that will be granted access to codepipeline bucket"
  type        = list(string)
  default     = []
}

variable "codepipeline_cross_account_role_arn" {
  description = "(Optional) role ARN that CodePipeline service role will be granted access to assume"
  type        = string
  default     = null
}

variable "codepipeline_name" {
  description = "(Optional) custom name for pipeline"
  type        = string
  default     = ""
}

variable "codepipeline_kms_key_arn" {
  description = "(Optional) ARN of KMS key used to encrypt CodePipeline artifacts uploaded to S3"
  type        = string
  default     = null
}

variable "cross_account_branchname" {
  type    = string
  default = null
}

variable "eventbridge_cross_account_ids" {
  description = "(Optional) account IDs we allow our eventbridge role to PutEvents to (for triggering cross account pipeline execution)"
  type        = list(string)
  default     = []
}

variable "repository_arn" {
  type    = string
  default = null
}

variable "repository_name" {
  type    = string
  default = null
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "APP_ENVIRONMENT" {
  description = "Environment variable for consumption in CodeBuild (usually set to ucop:environment tag)"
  type        = string
  default     = ""
}

variable "APP_NAME" {
  description = "Environment variable for consumption in CodeBuild (usually set to ucop:application tag)"
  type        = string
  default     = ""
}

variable "aws_account_id" {
  type    = string
  default = ""
}

variable "region" {
  type    = string
  default = "us-west-2"
}

variable "skip_default_pipeline" {
  description = "Skip creation of default pipeline. Useful for creating pipelines that do not use CodeCommit as a source."
  type        = bool
  default     = false
}

variable "tf_buildspec" {
  description = "Terraform buildspec file"
  type        = string
  default     = ""
}

variable "secondary_artifact" {
  description = "Secondary artifact names for CodeBuild project"
  type = list(object({
    name      = string
    type      = optional(string)
    path      = optional(string)
    bucket    = optional(string)
    packaging = optional(string)
  }))
  default = []
}

variable "vpc_config" {
  description = "Custom VPC definitions to host the build servers. Omit if using default VPC and no need to access resources, object properties are not really optional if including this config."
  type = object({
    security_group_ids = optional(list(string))
    subnets            = optional(list(string))
    vpc_id             = optional(string)
  })
  default = {}
}

variable "ecr_repository_arns" {
  description = "ECR repository ARNs to be used by CodeBuild project"
  type        = list(string)
  default     = []
}

variable "secondary_sources" {
  description = "Secondary sources for CodeBuild project"
  type = list(object({
    name                    = optional(string)
    category                = optional(string)
    owner                   = optional(string)
    provider                = optional(string)
    version                 = optional(string)
    output_artifact         = optional(string)
    repository_name         = optional(string)
    branch_name             = optional(string)
    poll_for_source_changes = optional(string)
    location                = optional(string)
  }))
  default = []
}

variable "poll_for_source_changes" {
  description = "Whether to poll for source changes in CodeCommit repository"
  type        = string
  default     = "false"
}