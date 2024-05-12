resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "${var.vpc_name}-${var.env}-IGW"
  }
}
