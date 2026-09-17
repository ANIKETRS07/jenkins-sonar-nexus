output "VPC-id" {
  value = aws_vpc.myvpc.id
}

output "Instance-id" {
  value = aws_instance.jenkins-server.id
}

output "jenkins-ip" {
  value = aws_instance.jenkins-server.public_ip
}

output "nexus-ip" {
  value = aws_instance.nexus-server.public_ip
}

output "sonar-ip" {
  value = aws_instance.sonar-server.public_ip
}