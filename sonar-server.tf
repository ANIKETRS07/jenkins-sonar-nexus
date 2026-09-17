


resource "aws_instance" "sonar-server" {
  ami           = data.aws_ami.latest.id
  instance_type = "t3.medium"

  subnet_id = aws_subnet.mypublicsubnet.id

  user_data = file("./sonar-server.sh")

  key_name = "jenkins-bhai-chal"

  security_groups = [aws_security_group.my-Security-Group-for-sonar.id]

  root_block_device {
    volume_size = 20
  }

  tags = {
    Name        = "sonar-server"
    environment = var.environment
  }
}