resource "aws_vpc" "main_vpc" {
  cidr_block = "${var.VPC_PREFIX}.0.0/16"

  tags = {
    Name = "${var.TAG_PREFIX}-vpc"
  }
}

# public subnets
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "${var.VPC_PREFIX}.1.0/24"
  availability_zone       = "${var.AWS_REGION}a"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.TAG_PREFIX}-public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "${var.VPC_PREFIX}.2.0/24"
  availability_zone       = "${var.AWS_REGION}b"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.TAG_PREFIX}-public-subnet-2"
  }
}

# private subnets
resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "${var.VPC_PREFIX}.3.0/24"
  availability_zone       = "${var.AWS_REGION}a"
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.TAG_PREFIX}-private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "${var.VPC_PREFIX}.4.0/24"
  availability_zone       = "${var.AWS_REGION}b"
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.TAG_PREFIX}-private-subnet-2"
  }
}

# internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.TAG_PREFIX}-igw"
  }
}

# public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.TAG_PREFIX}-public-rt"
  }
}

# public subnets route table association
resource "aws_route_table_association" "internet_for_public_subnet_1" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet_1.id
}

resource "aws_route_table_association" "internet_for_public_subnet_2" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet_2.id
}

# EIP for NAT GW1
resource "aws_eip" "eip_for_nat_gw" {
  vpc = true
}

# nat gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip_for_nat_gw.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "${var.TAG_PREFIX}-nat-gw"
  }
}

# private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "${var.TAG_PREFIX}-private-rt"
  }
}

resource "aws_route_table_association" "private_subnet_1_to_nat_gw" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.private_subnet_1.id
}

resource "aws_route_table_association" "private_subnet_2_to_nat_gw" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.private_subnet_2.id
}
