resource "aws_iam_role" "cp_db_migrator" {
  name = "cp-db-migrator-${var.env}"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Sid = ""
    }]
    Version = "2012-10-17"
  })
  description = "Allows ECS tasks to call AWS services on your behalf."
}

resource "aws_iam_role" "cp_bastion" {
  name = "cp-bastion-${var.env}"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  description = "Allows EC2 instances to call AWS services on your behalf."
}

resource "aws_iam_role_policy_attachment" "cp_bastion" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.cp_bastion.name
}

resource "aws_iam_role" "cp_nat" {
  name = "cp-nat-${var.env}"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  description = "Allows EC2 instances to call AWS services on your behalf."
}

resource "aws_iam_role_policy_attachment" "cp_nat" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.cp_nat.name
}

resource "aws_iam_role" "ecs_task_execution" {
  name = "ecs-task-execution-${var.env}"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  description = "Allows ECS tasks to call AWS services on your behalf."
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  for_each = {
    ecs_task_execution   = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
    s3_read_only         = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
    cloudwatch           = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
    secrets_manager_read = "arn:aws:iam::947612421265:policy/secrets-manager-read-stg"
  }
  policy_arn = each.value
  role       = aws_iam_role.ecs_task_execution.name
}

resource "aws_iam_role" "cp_slack_metrics_backend" {
  name = "cp-slack-metrics-backend-${var.env}"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  description = "Allows ECS tasks to call AWS services on your behalf."
}

resource "aws_iam_role_policy_attachment" "cp_slack_metrics_backend" {
  for_each = {
    ssm_manage_core = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    cloudwatch      = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
    s3_read         = aws_iam_policy.s3_read.arn
    ses_send_email  = aws_iam_policy.ses_send_email.arn
    sqs_read_write  = aws_iam_policy.sqs_read_write.arn
  }
  policy_arn = each.value
  role       = aws_iam_role.cp_slack_metrics_backend.name
}

resource "aws_iam_role" "cp_slack_metrics_client" {
  name = "cp-slack-metrics-client-${var.env}"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "amplify.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  description = "Allows Amplify Backend Deployment to access AWS resources on your behalf."
}

resource "aws_iam_role_policy_attachment" "cp_slack_metrics_client" {
  policy_arn = aws_iam_policy.cloud_watch_logs_write.arn
  role       = aws_iam_role.cp_slack_metrics_client.name
}

resource "aws_iam_role" "cp_scheduler_execution" {
  name = "cp-scheduler-execution-${var.env}"
  assume_role_policy = jsonencode({
    Statement = [{
      Condition = {}
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "scheduler.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "cp_scheduler_execution" {
  for_each = {
    ecs_run_task = aws_iam_policy.ecs_run_task.arn
    pass_role    = aws_iam_policy.pass_role.arn
  }
  policy_arn = each.value
  role       = aws_iam_role.cp_scheduler_execution.name
}

resource "aws_iam_role" "cp_scheduler_cost_cutter" {
  name = "cp-scheduler-cost-cutter-${var.env}"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "scheduler.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "cp_scheduler_cost_cutter" {
  for_each = {
    ec2_start_stop = aws_iam_policy.ec2_start_stop.arn
    ecs_write      = aws_iam_policy.ecs_write.arn
    rds_start_stop = aws_iam_policy.rds_start_stop.arn
  }
  policy_arn = each.value
  role       = aws_iam_role.cp_scheduler_cost_cutter.name
}

resource "aws_iam_role" "administrator" {
  name = "administrator-${var.env}"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::043309350350:root"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "administrator" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.administrator.name
}
