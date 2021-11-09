module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version = "17.23.0"
  cluster_name    = local.cluster_name
  cluster_version = "1.21"
  subnets         = module.vpc.private_subnets

  tags = {
  }

  vpc_id = module.vpc.vpc_id

  workers_group_defaults = {
    root_volume_type = "gp3"
  }

  worker_groups = [
    {
      name                          = "node-group-name"
      instance_type                 = "t2.small"
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 1
      additional_security_group_ids = [
        aws_security_group.ssh_security_group.id, 
      ]
    },
  ]
}
