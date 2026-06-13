resource "aws_security_group" "db_migrator" {
  name        = "db-migrator-${var.env}"
  description = "db migrator sg"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "db_migrator" {
  security_group_id = aws_security_group.db_migrator.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_security_group" "cp_bastion" {
  name        = "cp-bastion-${var.env}"
  description = "bastion sg"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "cp_bastion" {
  security_group_id = aws_security_group.cp_bastion.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_security_group" "cp_alb" {
  name        = "cp-alb-${var.env}"
  description = "alb sg"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "cp_alb" {
  security_group_id = aws_security_group.cp_alb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "cp_alb" {
  for_each = toset(["0.0.0.0/0"])

  security_group_id = aws_security_group.cp_alb.id
  cidr_ipv4         = each.value
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_security_group" "cp_nat" {
  name        = "cp-nat-${var.env}"
  description = "net sg"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "cp_nat" {
  security_group_id = aws_security_group.cp_nat.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "nat" {
  for_each = toset(var.private_subnet_cidr_blocks)

  security_group_id = aws_security_group.cp_nat.id
  cidr_ipv4         = each.value
  ip_protocol       = "-1"
}

resource "aws_security_group" "cp_slack_metrics_backend" {
  name        = "cp-slack-metrics-backend-${var.env}"
  description = "backend sg"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "cp_slack_metrics_backend" {
  security_group_id = aws_security_group.cp_slack_metrics_backend.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "cp_slack_metrics_backend" {
  security_group_id            = aws_security_group.cp_slack_metrics_backend.id
  referenced_security_group_id = aws_security_group.cp_alb.id
  from_port                    = 8080
  to_port                      = 8080
  ip_protocol                  = "tcp"
}

resource "aws_security_group" "cp_db" {
  name        = "cp-db-${var.env}"
  description = "rds sg"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "cp_db" {
  security_group_id = aws_security_group.cp_db.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "cp_db" {
  for_each = {
    bastion               = aws_security_group.cp_bastion.id
    slack_metrics_backend = aws_security_group.cp_slack_metrics_backend.id
    db_migrator           = aws_security_group.db_migrator.id
  }

  security_group_id            = aws_security_group.cp_db.id
  referenced_security_group_id = each.value
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
}
