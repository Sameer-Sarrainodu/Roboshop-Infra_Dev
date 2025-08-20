resource "aws_ssm_parameter" "backend_alb_listner_arn" {
    name  = "/${var.project}-${var.environment}/backend_alb_arn"
    type  = "String"
    value = module.backend_alb.arn
}