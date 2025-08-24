
module "frontend" {

source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = var.frontend_sg_name
    sg_description = var.frontend_sg_description
    vpc_id = local.vpc_id
}

module "bastion" {

source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "bastion" 
    sg_description = "sg for bastion"
    vpc_id = local.vpc_id
}

module "backend_alb" {

source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "backend-alb"
    sg_description = "for backend alb"
    vpc_id = local.vpc_id
}
module "frontend_alb" {

source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "frontend-alb"
    sg_description = "for frontend alb"
    vpc_id = local.vpc_id
}

module "vpn" {

source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "vpn"
    sg_description = "for vpn"
    vpc_id = local.vpc_id
}

module "mongodb" {

source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "mongodb"
    sg_description = "for mongodb"
    vpc_id = local.vpc_id
}

module "redis" {

source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "redis"
    sg_description = "for redis"
    vpc_id = local.vpc_id
}

module "mysql" {

source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "mysql"
    sg_description = "for mysql"
    vpc_id = local.vpc_id
}

module "rabbitmq" {

source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "rabbitmq"
    sg_description = "for rabbitmq"
    vpc_id = local.vpc_id
}

module "catalogue" {

source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "catalogue"
    sg_description = "for catalogue"
    vpc_id = local.vpc_id
}

module "user" {

source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "user"
    sg_description = "for user"
    vpc_id = local.vpc_id
}
module "cart" {

source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "cart"
    sg_description = "for cart"
    vpc_id = local.vpc_id
}
module "shipping" {

source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "shipping"
    sg_description = "for shipping"
    vpc_id = local.vpc_id
}
module "payment" {

source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "payment"
    sg_description = "for payment"
    vpc_id = local.vpc_id
}

#VPN ports 22, 443, 1194, 943

resource "aws_security_group_rule" "ssh_vpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "https_vpn" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "1194_vpn" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "943_vpn" {
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "vpn_backend_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.backend_alb.sg_id
}

resource "aws_security_group_rule" "vpn_frontend" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.frontend.sg_id
}

resource "aws_security_group_rule" "vpn_ssh_mongodb" {
  count = length(var.mongodb_ports_vpn)
  type              = "ingress"
  from_port         = var.mongodb_ports_vpn[count.index]
  to_port           = var.mongodb_ports_vpn[count.index]
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.mongodb.sg_id
}

resource "aws_security_group_rule" "vpn_ssh_redis" {
  count = length(var.redis_ports_vpn)
  type              = "ingress"
  from_port         = var.redis_ports_vpn[count.index]
  to_port           = var.redis_ports_vpn[count.index]
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.redis.sg_id
}

resource "aws_security_group_rule" "vpn_ssh_mysql" {
  count = length(var.mysql_ports_vpn)
  type              = "ingress"
  from_port         = var.mysql_ports_vpn[count.index]
  to_port           = var.mysql_ports_vpn[count.index]
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.mysql.sg_id
}

resource "aws_security_group_rule" "vpn_ssh_rabbitmq" {
  count = length(var.rabbitmq_ports_vpn)
  type              = "ingress"
  from_port         = var.rabbitmq_ports_vpn[count.index]
  to_port           = var.rabbitmq_ports_vpn[count.index]
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.rabbitmq.sg_id
}

resource "aws_security_group_rule" "vpn_ssh_catalogue" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.catalogue.sg_id
}

resource "aws_security_group_rule" "vpn_http_catalogue" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.catalogue.sg_id
}

resource "aws_security_group_rule" "vpn_ssh_user" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.user.sg_id
}

resource "aws_security_group_rule" "vpn_http_user" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.user.sg_id
}

resource "aws_security_group_rule" "vpn_ssh_cart" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.cart.sg_id
}

resource "aws_security_group_rule" "vpn_http_cart" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.cart.sg_id
}

resource "aws_security_group_rule" "vpn_ssh_shipping" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.shipping.sg_id
}

resource "aws_security_group_rule" "vpn_http_shipping" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.shipping.sg_id
}

resource "aws_security_group_rule" "vpn_ssh_payment" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.payment.sg_id
}

resource "aws_security_group_rule" "vpn_http_payment" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.payment.sg_id
}


# bastion


# bastion accepting connections from my laptop
resource "aws_security_group_rule" "bastion_laptop" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}

resource "aws_security_group_rule" "bastion_backend_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.backend_alb.sg_id
}
resource "aws_security_group_rule" "bastion_frontend" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.frontend.sg_id
}
resource "aws_security_group_rule" "bastion_mongodb" {
  count = length(var.mongodb_ports_vpn)
  type              = "ingress"
  from_port         = var.mongodb_ports_vpn[count.index]
  to_port           = var.mongodb_ports_vpn[count.index]
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.mongodb.sg_id
}
resource "aws_security_group_rule" "bastion_redis" {
  count = length(var.redis_ports_vpn)
  type              = "ingress"
  from_port         = var.redis_ports_vpn[count.index]
  to_port           = var.redis_ports_vpn[count.index]
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.redis.sg_id
}

resource "aws_security_group_rule" "bastion_mysql" {
  count = length(var.mysql_ports_vpn)
  type              = "ingress"
  from_port         = var.mysql_ports_vpn[count.index]
  to_port           = var.mysql_ports_vpn[count.index]
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.mysql.sg_id
}

resource "aws_security_group_rule" "bastion_rabbitmq" {
  count = length(var.rabbitmq_ports_vpn)
  type              = "ingress"
  from_port         = var.rabbitmq_ports_vpn[count.index]
  to_port           = var.rabbitmq_ports_vpn[count.index]
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.rabbitmq.sg_id
}

resource "aws_security_group_rule" "bastion_catalogue" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.catalogue.sg_id
}

resource "aws_security_group_rule" "bastion_user" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.user.sg_id
}

resource "aws_security_group_rule" "bastion_cart" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.cart.sg_id
}

resource "aws_security_group_rule" "bastion_shipping" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.shipping.sg_id
}

resource "aws_security_group_rule" "bastion_payment" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.payment.sg_id
}

# database and backend connection

resource "aws_security_group_rule" "catalogue_mongodb" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  source_security_group_id = module.catalogue.sg_id
  security_group_id = module.mongodb.sg_id
}

resource "aws_security_group_rule" "user_mongodb" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  source_security_group_id = module.user.sg_id
  security_group_id = module.mongodb.sg_id
}


resource "aws_security_group_rule" "user_redis" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  source_security_group_id = module.user.sg_id
  security_group_id = module.redis.sg_id
}

resource "aws_security_group_rule" "cart_redis" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  source_security_group_id = module.cart.sg_id
  security_group_id = module.redis.sg_id
}

resource "aws_security_group_rule" "shipping_mysql" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.shipping.sg_id
  security_group_id = module.mysql.sg_id
}


resource "aws_security_group_rule" "payment_rabbitmq" {
  type              = "ingress"
  from_port         = 5672
  to_port           = 5672
  protocol          = "tcp"
  source_security_group_id = module.payment.sg_id
  security_group_id = module.rabbitmq.sg_id
}

# backendalb

resource "aws_security_group_rule" "backend_alb_catalogue" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id = module.catalogue.sg_id
}

resource "aws_security_group_rule" "backend_alb_user" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id = module.user.sg_id
}

resource "aws_security_group_rule" "backend_alb_cart" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id = module.cart.sg_id
}

resource "aws_security_group_rule" "backend_alb_shipping" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id = module.shipping.sg_id
}

resource "aws_security_group_rule" "backend_alb_payment" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id = module.payment.sg_id
}


# frontend

resource "aws_security_group_rule" "frontend_backend_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.frontend.sg_id
  security_group_id = module.backend_alb.sg_id
}

# frontend_alb

resource "aws_security_group_rule" "frontend_alb_frontend" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.frontend_alb.sg_id
  security_group_id = module.frontend.sg_id
}

resource "aws_security_group_rule" "http_frontend_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.frontend_alb.sg_id
}

resource "aws_security_group_rule" "https_frontend_alb" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.frontend_alb.sg_id
}

# microservice to microservice

resource "aws_security_group_rule" "cart_backend_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.cart.sg_id
  security_group_id = module.backend_alb.sg_id
}

resource "aws_security_group_rule" "shipping_backend_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.shipping.sg_id
  security_group_id = module.backend_alb.sg_id
}

resource "aws_security_group_rule" "payment_backend_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.payment.sg_id
  security_group_id = module.backend_alb.sg_id
}