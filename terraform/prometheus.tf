resource "local_file" "prometheus_config" {

  depends_on = [
    aws_instance.web1,
    aws_instance.web2
    aws_instance.web3
  ]

  filename = "${path.module}/../monitoring/prometheus/prometheus.yml"

  content = templatefile("${path.module}/prometheus.tmpl", {

    web1 = aws_instance.web1.public_ip
    web2 = aws_instance.web2.public_ip
    web3 = aws_instance.web3.public_ip
  })
}

resource "null_resource" "reload_prometheus" {

  depends_on = [
    local_file.prometheus_config
  ]

  provisioner "local-exec" {

    command = "cd ../monitoring && ./reload-prometheus.sh"

  }
}
