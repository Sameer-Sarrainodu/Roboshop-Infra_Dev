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


module "backend_alb" {
    # source = "../../terraform-aws-sg"
    source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment
    sg_description = "sg for backend_alb"
    sg_name= "backend_alb"
    vpc_id=local.vpc_id
  
}
# backend ALB accepting connections from my bastion host on port no 80
resource "aws_security_group_rule" "backend_alb_bastion" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.backend_alb.sg_id
} 