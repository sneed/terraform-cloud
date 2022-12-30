# security group for alb, to allow access from any where on port 80 for http traffic
resource "aws_security_group_rule" "inbound-alb-http" {
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.IML["ext-alb-sg"].id
}


resource "aws_security_group_rule" "inbound-alb-https" {
  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.IML["ext-alb-sg"].id
}

# security group for compute module
resource "aws_security_group_rule" "inbound-bastion-ssh-compute" {
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
  type              = "ingress"
  source_security_group_id = aws_security_group.IML["bastion-sg"].id
  security_group_id = aws_security_group.IML["compute-sg"].id
}

resource "aws_security_group_rule" "inbound-port-artifactory" {
  from_port         = 8081
  protocol          = "tcp"
  to_port           = 8081
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.IML["compute-sg"].id
}

resource "aws_security_group_rule" "inbound-port-jenkins" {
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.IML["compute-sg"].id
}

resource "aws_security_group_rule" "inbound-port-sonarqube" {
  from_port         = 9000
  protocol          = "tcp"
  to_port           = 9000
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.IML["ext-alb-sg"].id
}

# security group rule for bastion to allow ssh access fro your local machine
resource "aws_security_group_rule" "inbound-ssh-bastion" {
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.IML["bastion-sg"].id
}


# security group for nginx reverse proxy, to allow access only from the external load balancer and bastion instance

resource "aws_security_group_rule" "inbound-nginx-http" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.IML["ext-alb-sg"].id
  security_group_id        = aws_security_group.IML["nginx-sg"].id
}


resource "aws_security_group_rule" "inbound-bastion-ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.IML["bastion-sg"].id
  security_group_id        = aws_security_group.IML["nginx-sg"].id
}



# security group for ialb, to have access only from nginx reverser proxy server

resource "aws_security_group_rule" "inbound-ialb-https" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.IML["nginx-sg"].id
  security_group_id        = aws_security_group.IML["int-alb-sg"].id
}



# security group for webservers, to have access only from the internal load balancer and bastion instance

resource "aws_security_group_rule" "inbound-web-https" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.IML["int-alb-sg"].id
  security_group_id        = aws_security_group.IML["webserver-sg"].id
}

resource "aws_security_group_rule" "inbound-web-ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.IML["bastion-sg"].id
  security_group_id        = aws_security_group.IML["webserver-sg"].id
}



# security group for datalayer to allow traffic from webserver on nfs and mysql port and bastion host on mysql port
resource "aws_security_group_rule" "inbound-nfs-port" {
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.IML["webserver-sg"].id
  security_group_id        = aws_security_group.IML["datalayer-sg"].id
}

resource "aws_security_group_rule" "inbound-mysql-bastion" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.IML["bastion-sg"].id
  security_group_id        = aws_security_group.IML["datalayer-sg"].id
}

resource "aws_security_group_rule" "inbound-mysql-webserver" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.IML["webserver-sg"].id
  security_group_id        = aws_security_group.IML["datalayer-sg"].id
}



