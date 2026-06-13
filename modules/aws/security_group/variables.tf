variable "env" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_cidr_blocks" {
  type = list(string)
}

locals {
  default_egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]
}
