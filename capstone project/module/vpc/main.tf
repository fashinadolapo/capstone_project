# Create a VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

# Create public subnets in different AZs
resource "aws_subnet" "public" {
  count = 3
  cidr_block = "10.0.${count.index}.0/24"
  vpc_id = aws_vpc.example.id
  availability_zone = "us-west-2${count.index + 1}"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-${count.index + 1}"
  }
}

# Create private subnets in different AZs
resource "aws_subnet" "private" {
  count = 3
  cidr_block = "10.0.${count.index + 10}.0/24"
  vpc_id = aws_vpc.example.id
  availability_zone = "us-west-2${count.index + 1}"

  tags = {
    Name = "private-${count.index + 1}"
  }
}

# Create internet gateway
resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example.id

  tags = {
    Name = "example"
  }
}

# Attach internet gateway to VPC
resource "aws_vpc_attachment" "example" {
  vpc_id = aws_vpc.example.id
  internet_gateway_id = aws_internet_gateway.example.id
}

# Create route table for public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example.id
  }

  tags = {
    Name = "public"
  }
}

# Create route table for private subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.example.id

  tags = {
    Name = "private"
  }
}

# Associate public subnets with public route table
resource "aws_route_table_association" "public" {
  count = 3
  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Associate private subnets with private route table
resource "aws_route_table_association" "private" {
  count = 3
  subnet_id = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
