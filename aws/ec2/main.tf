variable "name" {}
variable "ami" {}
variable "subnet_id" {}
variable "vpc_security_group_id" {}

resource "aws_key_pair" "tpot" {
  key_name   = var.name
  public_key = file("${path.root}/keys/id_rsa.pub")
}

resource "aws_instance" "tpot" {
  ami           = var.ami
  instance_type = "t3.xlarge" # 4 vCPU, 16 GiB RAM
  subnet_id     = var.subnet_id
  key_name      = aws_key_pair.tpot.key_name
  tags = {
    Name = var.name
  }
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }
  vpc_security_group_ids      = [var.vpc_security_group_id]
  associate_public_ip_address = true
}
