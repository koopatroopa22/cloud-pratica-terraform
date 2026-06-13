resource "aws_sqs_queue" "slack_metrics_dlq" {
  max_message_size           = 1048576
  message_retention_seconds  = 345600
  name                       = "slack-metrics-dlq-stg"
  sqs_managed_sse_enabled    = true
  visibility_timeout_seconds = 30
}

resource "aws_sqs_queue_policy" "slack_metrics_dlq" {
  queue_url = aws_sqs_queue.slack_metrics_dlq.id
  policy = jsonencode({
    Statement = [{
      Action = "SQS:*"
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::947612421265:root"
      }
      Resource = "arn:aws:sqs:ap-northeast-1:947612421265:slack-metrics-dlq-stg"
    }]
    Version = "2012-10-17"
  })
}

resource "aws_sqs_queue" "slack_metrics" {
  max_message_size           = 1048576
  message_retention_seconds  = 86400
  name                       = "slack-metrics-stg"
  sqs_managed_sse_enabled    = true
  visibility_timeout_seconds = 10
  receive_wait_time_seconds  = 20
}

resource "aws_sqs_queue_policy" "slack_metrics" {
  queue_url = aws_sqs_queue.slack_metrics.id
  policy = jsonencode({
    Statement = [{
      Action = "SQS:*"
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:sts::947612421265:federated-user/root"
      }
      Resource = "arn:aws:sqs:ap-northeast-1:947612421265:slack-metrics-stg"
    }]
    Version = "2012-10-17"
  })
}
