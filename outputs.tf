output "iam_build_role_name" {
  description = "IAM role name for CodeBuild"
  value       = aws_iam_role.codebuild.name
}

output "iam_pipeline_role_name" {
  description = "IAM role name for CodePipeline"
  value       = aws_iam_role.pipeline.name
}