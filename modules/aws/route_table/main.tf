resource "aws_route_table" "cp-rtb-public" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
  tags = {
    Name = "cp-rtb-public-${var.env}"
  }
  vpc_id = var.vpc_id
}

resource "aws_route_table_association" "public" {
  for_each       = toset(var.public_subnet_ids)
  route_table_id = aws_route_table.cp-rtb-public.id
  subnet_id      = each.value
}
