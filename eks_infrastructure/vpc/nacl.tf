resource "aws_network_acl" "vpc_nacl" {
  vpc_id = aws_vpc.my_vpc.id

  egress {
    protocol   = "all"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = "0" # To allow all ports
    to_port    = "0"
  }

  ingress {
    protocol   = "all"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = "0" # To allow all ports
    to_port    = "0"
  }
    subnet_ids = concat(
        [for subnet in aws_subnet.public_subnets: subnet.id],
        [for subnet in aws_subnet.private_subnets: subnet.id]
    )

  tags = {
    Name = "${var.vpc_name}-${var.env}-NACL"
  }
}