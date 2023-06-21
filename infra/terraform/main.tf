resource "aws_instance" "ems_ops" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  tags = {
    Name        = "EMS-OPS-Demo"
    Environment = var.environment
  }
}
