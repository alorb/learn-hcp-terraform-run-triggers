data "tfe_outputs" "source_workspace" {
  workspace    = var.learn-hcp-terraform-run-triggers
  organization = var.ABCorp
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  vpc_security_group_ids = data.tfe_outputs.source_workspace.nonsensitive_values.instance_security_group_ids
  subnet_id              = data.tfe_outputs.source_workspace.nonsensitive_values.instance_subnet

  tags = {
    Name = var.instance_name
  }
}
