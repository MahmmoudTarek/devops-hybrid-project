resource "aws_key_pair" "devops_key" {

  key_name = "devops-key"


  public_key = file("keys/id_ed25519.pub")
}
