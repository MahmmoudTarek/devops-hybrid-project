output "web1_ip" {

value = aws_instance.web1.public_ip

}


output "web2_ip" {

value = aws_instance.web2.public_ip

}

resource "local_file" "inventory" {

filename = "../ansible/inventory/hosts.ini"


content = <<EOF

[webservers]

${aws_instance.web1.public_ip}

${aws_instance.web2.public_ip}


EOF

}
