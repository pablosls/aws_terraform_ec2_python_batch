resource "aws_instance" "myec2" {
  ami           = "ami-08f3d892de259504d" # us-west-2
  instance_type = "t2.medium"
  subnet_id = aws_subnet.Public_subnet.id
  user_data = file("install.sh")
  vpc_security_group_ids = [aws_security_group.sg_do_pablo.id]

}

output "DNS" {
  value = aws_instance.myec2.public_dns
}