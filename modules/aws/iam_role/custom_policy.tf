resource "aws_iam_policy" "secrets_manager_read" {
  name = "secrets-manager-read-stg"
  policy = jsonencode({
    Statement = [{
      Action   = ["secretsmanager:GetSecretValue", "secretsmanager:DescribeSecret"]
      Effect   = "Allow"
      Resource = "*"
      Sid      = "VisualEditor0"
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_policy" "s3_read" {
  name = "s3-read-stg"
  policy = jsonencode({
    Statement = [{
      Action = [
        "s3:GetObject",
        "s3:ListBucket",
        "s3:GetObjectVersion"
      ]
      Effect   = "Allow"
      Resource = "*"
      Sid      = "VisualEditor0"
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_policy" "ses_send_email" {
  name = "ses-send-email-stg"
  policy = jsonencode({
    Statement = [{
      Action = [
        "ses:SendEmail",
        "ses:SendRawEmail"
      ]
      Effect   = "Allow"
      Resource = "*"
      Sid      = "VisualEditor0"
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_policy" "sqs_read_write" {
  name = "sqs-read-write-stg"
  policy = jsonencode({
    Statement = [{
      Action = [
        "sqs:DeleteMessage",
        "sqs:ReceiveMessage",
        "sqs:SendMessage",
        "sqs:GetQueueAttributes"
      ]
      Effect   = "Allow"
      Resource = "*"
      Sid      = "VisualEditor0"
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_policy" "cloud_watch_logs_write" {
  name = "cloud-watch-logs-write-stg"
  policy = jsonencode({
    Statement = [{
      Action = [
        "logs:CreateLogStream",
        "logs:CreateLogGroup",
        "logs:PutLogEvents"
      ]
      Effect   = "Allow"
      Resource = "*"
      Sid      = "VisualEditor0"
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_policy" "ecs_run_task" {
  name = "ecs-run-task-stg"
  policy = jsonencode({
    Statement = [{
      Action   = "ecs:RunTask"
      Effect   = "Allow"
      Resource = "*"
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_policy" "pass_role" {
  name = "pass-role-stg"
  policy = jsonencode({
    Statement = [{
      Action   = "iam:PassRole"
      Effect   = "Allow"
      Resource = "*"
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_policy" "ec2_start_stop" {
  name = "ec2-start-stop-stg"
  policy = jsonencode({
    Statement = [{
      Action = [
        "ec2:StartInstances",
        "ec2:StopInstances"
      ]
      Effect   = "Allow"
      Resource = "*"
      Sid      = "VisualEditor0"
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_policy" "ecs_write" {
  name = "ecs-write-stg"
  policy = jsonencode({
    Statement = [{
      Action = [
        "ecs:UpdateService",
        "ecs:RunTask"
      ]
      Effect   = "Allow"
      Resource = "*"
      Sid      = "VisualEditor0"
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_policy" "rds_start_stop" {
  name = "rds-start-stop-stg"
  policy = jsonencode({
    Statement = [{
      Action = [
        "rds:StopDBInstance",
        "rds:StartDBInstance"
      ]
      Effect   = "Allow"
      Resource = "*"
      Sid      = "VisualEditor0"
    }]
    Version = "2012-10-17"
  })
}

