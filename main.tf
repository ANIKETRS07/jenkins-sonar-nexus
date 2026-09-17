
resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name        = "myvpc"
    environment = var.environment
  }
}

resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name        = "myigw"
    environment = var.environment
  }
}

resource "aws_subnet" "mypublicsubnet" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.mypublicsubnet_cidr_block
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name        = "mypublicsubnet"
    environment = var.environment
  }
}

resource "aws_subnet" "mypublicsubnet_2" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.mypublicsubnet_2_cidr_block
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name        = "mypublicsubnet_2"
    environment = var.environment
  }
}

resource "aws_subnet" "myprivatesubnet" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.myprivatesubnet_cidr_block
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false
  tags = {
    Name        = "myprivatesubnet"
    environment = var.environment
  }
}

resource "aws_subnet" "myprivatesubnet_2" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.myprivatesubnet_2_cidr_block
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false
  tags = {
    Name        = "myprivatesubnet_2"
    environment = var.environment
  }
}

resource "aws_route_table" "mypublicroutetable" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name        = "mypublicroutetable"
    environment = var.environment
  }
}

resource "aws_route_table" "my-public-route-table2" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name        = "my-Public-Route-Table2"
    environment = var.environment
  }
}

resource "aws_route_table" "myprivateroutetable" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name        = "myprivateroutetable"
    environment = var.environment
  }
}

resource "aws_route_table" "myprivateroutetable_2" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name        = "myprivateroutetable_2"
    environment = var.environment
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.mypublicroutetable.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id              = aws_internet_gateway.myigw.id
}

resource "aws_route" "public_route_2" {
  route_table_id         = aws_route_table.my-public-route-table2.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id              = aws_internet_gateway.myigw.id
}

resource "aws_route_table_association" "mypublicrouteassociation" {
  subnet_id      = aws_subnet.mypublicsubnet.id
  route_table_id = aws_route_table.mypublicroutetable.id
}

resource "aws_route_table_association" "mypublicrouteassociation_2" {
  subnet_id      = aws_subnet.mypublicsubnet_2.id
  route_table_id = aws_route_table.my-public-route-table2.id
}

resource "aws_route_table_association" "myprivaterouteassociation" {
  subnet_id      = aws_subnet.myprivatesubnet.id
  route_table_id = aws_route_table.myprivateroutetable.id
}

resource "aws_route_table_association" "myprivaterouteassociation_2" {
  subnet_id      = aws_subnet.myprivatesubnet_2.id
  route_table_id = aws_route_table.myprivateroutetable_2.id
}

resource "aws_security_group" "mysecuritygroup" {
  name        = "mysecuritygroup"
  description = "my security group"
  vpc_id      = aws_vpc.myvpc.id
  tags = {
    Name        = "mysecuritygroup"
    environment = var.environment
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
    ipv6_cidr_blocks  = ["::/0"]
  }
}

resource "aws_security_group" "my-Security-Group-for-nexus" {
  name        = "my-Security-Group-for-nexus"
  description = "Security Group for Nexus"
  vpc_id      = aws_vpc.myvpc.id

  tags = {
    Name        = "my-Security-Group-for-nexus"
    environment = var.environment
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
    ipv6_cidr_blocks  = ["::/0"]
  }
}

resource "aws_security_group" "my-Security-Group-for-sonar" {
  name        = "my-Security-Group-for-sonar"
  description = "Security Group for SonarQube"
  vpc_id      = aws_vpc.myvpc.id

  tags = {
    Name        = "my-Security-Group-for-sonar"
    environment = var.environment
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
    ipv6_cidr_blocks  = ["::/0"]
  }
}
