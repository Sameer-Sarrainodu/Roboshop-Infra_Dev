module "frontend" {
    # source = "../../terraform-aws-sg"
    source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment
    sg_description = var.frontend_sg_description
    sg_name=var.frontend_sg_name
    vpc_id=local.vpc_id
  
}

module "bastion" {
    # source = "../../terraform-aws-sg"
    source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment
    sg_description = "sg for bastion"
    sg_name= "bastion"
    vpc_id=local.vpc_id
  
}

resource "aws_security_group_rule" "bastion_laptop" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}

