output "ALB-sg" {
  value = aws_security_group.IML["ext-alb-sg"].id
}


output "IALB-sg" {
  value = aws_security_group.IML["int-alb-sg"].id
}


output "bastion-sg" {
  value = aws_security_group.IML["bastion-sg"].id
}


output "nginx-sg" {
  value = aws_security_group.IML["nginx-sg"].id
}


output "web-sg" {
  value = aws_security_group.IML["webserver-sg"].id
}


output "datalayer-sg" {
  value = aws_security_group.IML["datalayer-sg"].id
}