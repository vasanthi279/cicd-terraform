output "apacheip" {
    value = aws_instance.apache.public_ip
  
}
output "apachepubdns" {
    value = aws_instance.apache.public_dns
  
}
output "cicdip" {
    value = aws_instance.cicd.public_ip
  
}
output "cicddnsip" {
    value = aws_instance.cicd.public_dns
  
}