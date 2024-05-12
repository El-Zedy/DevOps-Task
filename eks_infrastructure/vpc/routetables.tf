resource "aws_route_table" "vpc_public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "${var.vpc_name}-${var.env}-PUBLIC-ROUTE-TABLE"
  }
}

resource "aws_route" "public_route" {
    route_table_id         = aws_route_table.vpc_public_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.vpc_igw.id
}

resource "aws_route_table_association" "public_subnets_association" {
  count = "${length(aws_subnet.public_subnets)}"
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.vpc_public_route_table.id
}

# --------------

resource "aws_route_table" "vpc_private_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "${var.vpc_name}-${var.env}-PRIVATE-ROUTE-TABLE"
  }
}

resource "aws_route" "private_route" {
    route_table_id         = aws_route_table.vpc_private_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id             = aws_nat_gateway.vpc_nat_gateway.id
}

resource "aws_route_table_association" "private_subnets_association" {
  count = "${length(aws_subnet.private_subnets)}"
  subnet_id = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.vpc_private_route_table.id
}