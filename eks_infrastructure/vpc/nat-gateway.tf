resource "aws_nat_gateway" "vpc_nat_gateway" {
  allocation_id = aws_eip.vpc_elastic_ip.id
  subnet_id     = aws_subnet.public_subnets[0].id

  tags = {
    Name = "${var.vpc_name}-${var.env}-NAT-GATEWAY"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.vpc_igw]
}