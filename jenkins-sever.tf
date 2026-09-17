data "aws_ami" "latest" {
    most_recent = true

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }

    owners = ["099720109477"]
}


resource "aws_instance" "jenkins-server" {
  ami           = data.aws_ami.latest.id
  instance_type = "t3.medium"

  subnet_id = aws_subnet.mypublicsubnet.id

  user_data = file("./jenkins-server.sh")

  key_name = "jenkins-bhai-chal"

  iam_instance_profile = aws_iam_instance_profile.jenkins-instance-profile.name

  security_groups = [aws_security_group.mysecuritygroup.id]

  root_block_device {
    volume_size = 20
  }

  tags = {
    Name        = "jenkins-server"
    environment = var.environment
  }
}

