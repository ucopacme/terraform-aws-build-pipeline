locals {
  codebuild_name        = var.codebuild_name != "" ? var.codebuild_name : var.name
  codebuild_description = var.codebuild_description != "" ? var.codebuild_description : "Codebuild for ${var.name}"
}

data "aws_iam_policy_document" "assume_by_codebuild" {
  statement {
    sid     = "AllowAssumeByCodebuild"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "codebuild" {
  name               = "${local.codebuild_name}-codebuild"
  assume_role_policy = data.aws_iam_policy_document.assume_by_codebuild.json
  tags               = var.tags
}

data "aws_iam_policy_document" "codebuild_base" {
  statement {
    sid    = "AllowActions"
    effect = "Allow"

    actions = [
#      "ecr:GetAuthorizationToken",
#      "secretsmanager:GetSecretValue",
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel",
    ]

    resources = ["*"]
  }

  statement {
    sid       = "AllowS3BucketActions"
    effect    = "Allow"
    resources = contains(var.allowed_s3_bucket_names, "*") ? ["*"] : [for bucket in concat([aws_s3_bucket.pipeline.id], var.allowed_s3_bucket_names) : "arn:aws:s3:::${bucket}"]

    actions = [
      "s3:ListBucket",
    ]
  }

  statement {
    sid       = "AllowS3ObjectActions"
    effect    = "Allow"
    resources = contains(var.allowed_s3_bucket_names, "*") ? ["*"] : [for bucket in concat([aws_s3_bucket.pipeline.id], var.allowed_s3_bucket_names) : "arn:aws:s3:::${bucket}/*"]

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:PutObject",
    ]
  }

  dynamic "statement" {
    for_each = length(var.ecr_repository_arns) > 0 ? [1] : []
    content {
      sid       = "AllowECR"
      effect    = "Allow"
      resources = var.ecr_repository_arns

      actions = [
        "ecr:BatchCheckLayerAvailability",
        "ecr:BatchGetImage",
        "ecr:BatchImportUpstreamImage",
        "ecr:CompleteLayerUpload",
        "ecr:GetDownloadUrlForLayer",
        "ecr:InitiateLayerUpload",
        "ecr:PutImage",
        "ecr:UploadLayerPart",
      ]
    }
  }

  statement {
    sid       = "AllowCloudWatchLogsCreateLogGroupsAndLogStreams"
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:log-group:/aws/codebuild/*"]

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
    ]
  }

  statement {
    sid       = "AllowCloudWatchLogsPutLogEvents"
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:log-group:/aws/codebuild/*:log-stream:*"]

    actions = ["logs:PutLogEvents"]
  }
}

data "aws_iam_policy_document" "codebuild_kms" {
  count = var.codepipeline_kms_key_arn != null ? 1 : 0
  statement {
    sid       = "AllowKMSActions"
    effect    = "Allow"
    resources = [var.codepipeline_kms_key_arn]

    actions = [
      "kms:DescribeKey",
      "kms:GenerateDataKey",
      "kms:Encrypt",
      "kms:Decrypt",
    ]
  }
}

data "aws_iam_policy_document" "codebuild" {
  source_policy_documents = var.codepipeline_kms_key_arn == null ? [
    data.aws_iam_policy_document.codebuild_base.json
    ] : [
    data.aws_iam_policy_document.codebuild_base.json,
    data.aws_iam_policy_document.codebuild_kms[0].json
  ]
}

resource "aws_iam_role_policy" "codebuild" {
  role   = aws_iam_role.codebuild.name
  policy = data.aws_iam_policy_document.codebuild.json
}

resource "aws_codebuild_project" "this" {
  name         = "${local.codebuild_name}-codebuild"
  description  = local.codebuild_description
  service_role = aws_iam_role.codebuild.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  dynamic "vpc_config" {
    for_each = (
      var.vpc_config != null && 
      length(keys(var.vpc_config)) > 0 &&
      try(var.vpc_config.vpc_id, null) != null &&
      try(var.vpc_config.security_group_ids, null) != null &&
      try(var.vpc_config.subnets, null) != null
    ) ? [var.vpc_config] : []

    content {
      security_group_ids = vpc_config.value.security_group_ids
      subnets            = vpc_config.value.subnets
      vpc_id             = vpc_config.value.vpc_id
    }
  }
  dynamic "secondary_artifacts" {
    for_each = var.secondary_artifact != null ? var.secondary_artifact : []

    content {
      artifact_identifier = "provenance"
      name = secondary_artifacts.value.name
      type = secondary_artifacts.value.type != null ? secondary_artifacts.value.type : "CODEPIPELINE"
      namespace_type = "BUILD_ID"
      path = secondary_artifacts.value.path != null ? secondary_artifacts.value.path : join("/", [var.APP_NAME, var.APP_ENVIRONMENT, "build", "provenance"])
      location = secondary_artifacts.value.type == "S3" ? secondary_artifacts.value.bucket : null
      packaging = secondary_artifacts.value.type == "S3" ? secondary_artifacts.value.packaging : "ZIP"
    }
  }

  environment {
    compute_type    = var.codebuild_compute_type
    image           = var.codebuild_image
    type            = var.codebuild_type
    privileged_mode = var.codebuild_privileged_mode

    environment_variable {
      name  = "APP_NAME"
      value = var.APP_NAME
    }
    environment_variable {
      name  = "APP_ENVIRONMENT"
      value = var.APP_ENVIRONMENT
    }
    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = var.aws_account_id
    }
    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.region
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = var.tf_buildspec != "" ? file(var.tf_buildspec) : "buildspec.yml"
  }

  tags = var.tags
}
