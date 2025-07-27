module "frontend" {
    # source = "../../terraform-aws-sg"
    source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment
    sg_description = var.frontend_sg_description
    sg_name=var.frontend_sg_name
    vpc_id=local.vpc_id
  
}