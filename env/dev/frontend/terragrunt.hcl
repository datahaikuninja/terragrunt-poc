include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/frontend/"
}

dependency "network" {
  config_path = "../network/"

  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    vpc_id           = "vpc-0dbdbeede54a7a05d"
    public_subnet_id = "subnet-0158050b6f2d19d0d"
  }
}

inputs = {
  env              = "dev"
  vpc_id           = dependency.network.outputs.vpc_id
  public_subnet_id = dependency.network.outputs.vpc_subnet_public_a_id
}
