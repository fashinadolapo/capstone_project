# Launch EC2 instances in different AZs
resource "aws_instance" "example" {
  count = length(var.subnet_ids)

  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_ids[count.index]
  key_name      = aws_key_pair.tf_key_pair.key_name
  tags = {
    Name = var.instance_names[count.index]
  }
}

# RSA key of size 4096 bits
resource "tls_private_key" "rsa-4096-example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# create key pairs
resource "aws_key_pair" "tf_key_pair" {
  key_name   = var.keyname
  public_key = tls_private_key.rsa-4096-example.public_key_openssh
}



