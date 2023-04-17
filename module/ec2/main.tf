# Launch EC2 instances in different AZs
resource "aws_instance" "example" {
  count = length(var.subnet_ids)

  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_ids[count.index]

  tags = {
    Name = var.instance_names[count.index]
  }
}

