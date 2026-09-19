

resource "aws_instance" "nexus-server" {
  ami           = data.aws_ami.latest.id
  instance_type = "c7i-flex.large"
  subnet_id     = aws_subnet.mypublicsubnet.id
  user_data     = file("./nexus-server.sh")
  key_name      = "jenkins-bhai-chal"

  security_groups = [aws_security_group.my-Security-Group-for-nexus.id]

  root_block_device {
    volume_size = 20
  }

  tags = {
    Name        = "nexus-server"
    environment = var.environment
  }
}
