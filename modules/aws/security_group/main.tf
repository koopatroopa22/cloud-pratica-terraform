resource "aws_security_group" "db-migrator" {
  name        = "db-migrator-${var.env}"
  description = "db migrator sg"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "db-migrator-egress" {
  security_group_id = aws_security_group.db-migrator.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
