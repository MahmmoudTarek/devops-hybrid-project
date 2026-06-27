resource "aws_security_group" "devops_sg" {

  name = "devops-sg"
  vpc_id = aws_vpc.devops_vpc.id

  ingress {

    from_port = 22
    to_port = 22
    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }


  ingress {

    from_port = 80
    to_port = 80
    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }


  ingress {

    from_port = 9100
    to_port = 9100
    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }


  egress {

    from_port = 0
    to_port = 0
    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }
}




resource "aws_instance" "web1" {

  ami = var.ami

  instance_type = var.instance_type

  subnet_id = aws_subnet.public_subnet.id


  key_name = aws_key_pair.devops_key.key_name


  vpc_security_group_ids = [
    aws_security_group.devops_sg.id
  ]


  tags = {

    Name = "devops-web1"

  }

}

resource "aws_instance" "web2" {

  ami = var.ami

  instance_type = var.instance_type

  subnet_id = aws_subnet.public_subnet.id


  key_name = aws_key_pair.devops_key.key_name


  vpc_security_group_ids = [
    aws_security_group.devops_sg.id
  ]


  tags = {

    Name = "devops-web2"

  }

}

resource "aws_instance" "web3" {

  ami = var.ami

  instance_type = var.instance_type

  subnet_id = aws_subnet.public_subnet.id


  key_name = aws_key_pair.devops_key.key_name


  vpc_security_group_ids = [
    aws_security_group.devops_sg.id
  ]


  tags = {

    Name = "devops-web3"

  }

}

