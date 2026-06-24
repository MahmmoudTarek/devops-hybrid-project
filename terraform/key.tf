resource "aws_key_pair" "devops_key" {

  key_name = "devops-key"


  public_key = file("/home/jhin/.ssh/id_ed25519.pub")
}
