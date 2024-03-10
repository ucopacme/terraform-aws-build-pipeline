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
  type    = string
  default = ""
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
