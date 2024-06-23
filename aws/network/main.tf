variable "name" {}
variable "vpc_cidr" {}
variable "subnet_cidr" {}
variable "admin_ip" {}

resource "aws_vpc" "tpot" {
  cidr_block       = var.vpc_cidr
  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "tpot" {
  vpc_id     = aws_vpc.tpot.id
  cidr_block = var.subnet_cidr
  tags = {
    Name = var.name
  }
}

resource "aws_internet_gateway" "tpot" {
  vpc_id = aws_vpc.tpot.id
  tags = {
    Name = var.name
  }
}

resource "aws_route" "tpot" {
  route_table_id         = aws_route_table.tpot.id
  gateway_id             = aws_internet_gateway.tpot.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table" "tpot" {
  vpc_id = aws_vpc.tpot.id
  tags = {
    Name = var.name
  }
}

resource "aws_route_table_association" "tpot" {
  subnet_id      = aws_subnet.tpot.id
  route_table_id = aws_route_table.tpot.id
}

resource "aws_security_group" "tpot" {
  name        = var.name
  vpc_id      = aws_vpc.tpot.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.name
  }
}

resource "aws_default_network_acl" "tpot" {
  default_network_acl_id = aws_vpc.tpot.default_network_acl_id
  subnet_ids            = [aws_subnet.tpot.id]

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.admin_ip
    from_port  = 64294
    to_port    = 64294
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 101
    action     = "allow"
    cidr_block = var.admin_ip
    from_port  = 64295
    to_port    = 64295
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 102
    action     = "allow"
    cidr_block = var.admin_ip
    from_port  = 64297
    to_port    = 64297
  }

  egress {
    protocol   = "all"
    rule_no    = 103
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 104
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 64294
    to_port    = 64294
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 105
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 64295
    to_port    = 64295
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 106
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 64297
    to_port    = 64297
  }

  ingress {
    protocol   = "all"
    rule_no    = 107
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}
