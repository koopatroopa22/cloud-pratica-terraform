resource "aws_ecr_repository" "db_migrator" {
  image_tag_mutability = "IMMUTABLE"
  name                 = "db-migrator-${var.env}"
}

resource "aws_ecr_repository" "slack_metrics" {
  image_tag_mutability = "IMMUTABLE"
  name                 = "slack-metrics-${var.env}"
}
