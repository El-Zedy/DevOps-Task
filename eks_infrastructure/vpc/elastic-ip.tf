resource "aws_eip" "vpc_elastic_ip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.vpc_igw]
  tags = {
    Name = "${var.vpc_name}-${var.env}-NAT-ELASTIC-IP"
  }
}
