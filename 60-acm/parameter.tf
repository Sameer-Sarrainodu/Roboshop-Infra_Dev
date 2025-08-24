resource "aws_ssm_parameter" "acm_certificate_arn" {
    name  = "/${var.project}-${var.environment}/acm_certificate_arn"
    type  = "String"
    value = aws_lb_listener.sharkdev.arn
  
}