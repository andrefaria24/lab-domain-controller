data "terraform_remote_state" "aws-demo-network" {
  backend = "remote"

  config = {
    organization = "acfaria-hashicorp"
    workspaces = {
      name = "aws-demo-network"
    }
  }
}