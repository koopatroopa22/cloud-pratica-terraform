resource "aws_security_group" "db-migrator" {
  name        = "db-migrator-${var.env}"
  description = "db migrator sg"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "db_migrator" {
  security_group_id = aws_security_group.db-migrator.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_security_group" "cp-bastion" {
  name        = "cp-bastion-${var.env}"
  description = "bastion sg"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "cp_bastion" {
  security_group_id = aws_security_group.cp-bastion.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_security_group" "cp-alb" {
  name        = "cp-alb-${var.env}"
  description = "alb sg"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "cp_alb" {
  security_group_id = aws_security_group.cp-alb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "cp_alb" {
  security_group_id = aws_security_group.cp-alb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}
