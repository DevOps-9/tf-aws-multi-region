# Subnet VPC
variable "subnet-infra-1a" {
  default = "10.0.32.0/20"
}

# Subnets with AZ-A
resource "aws_subnet" "subnet-infra-1a" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.subnet-infra-1a}"
  availability_zone = "${var.region}a"

  tags = "${merge(map("Name", format("%s", var.app)), var.tags)}"
}

##  route table association
resource "aws_route_table" "route-table-infra-1a" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ig.id}"
  }

  tags = "${merge(map("Name", format("%s", var.app)), var.tags)}"
}

# route table association Zone-A
resource "aws_route_table_association" "route-table-infra-1a" {
  subnet_id      = "${aws_subnet.subnet-infra-1a.id}"
  route_table_id = "${aws_route_table.route-table-infra-1a.id}"
}
