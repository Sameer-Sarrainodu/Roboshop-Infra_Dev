module "mongodb" {
    # source = "../../terraform-aws-sg"
    source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment
    sg_description = "sg for mongodb"
    sg_name="mongodb"
    vpc_id=local.vpc_id
  
}
module "redis" {
    # source = "../../terraform-aws-sg"
    source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment
    sg_description = "sg for redis"
    sg_name="redis"
    vpc_id=local.vpc_id
  
}
module "mysql" {
    # source = "../../terraform-aws-sg"
    source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment
    sg_description = "sg for mysql"
    sg_name="mysql"
    vpc_id=local.vpc_id
  
}
module "rabbitmq" {
    # source = "../../terraform-aws-sg"
    source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment
    sg_description = "sg for rabbitmq"
    sg_name="rabbitmq"
    vpc_id=local.vpc_id
  
}
module "catalogue" {
    # source = "../../terraform-aws-sg"
    source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment
    sg_description = "sg for catalogue"
    sg_name="catalogue"
    vpc_id=local.vpc_id
  
}
module "user" {
    # source = "../../terraform-aws-sg"
    source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment
    sg_description = "sg for user"
    sg_name="user"
    vpc_id=local.vpc_id
  
}
module "cart" {
    # source = "../../terraform-aws-sg"
    source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment
    sg_description = "sg for cart"
    sg_name="cart"
    vpc_id=local.vpc_id
  
}
module "shipping" {
    # source = "../../terraform-aws-sg"
    source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment
    sg_description = "sg for shipping"
    sg_name="shipping"
    vpc_id=local.vpc_id
  
}
module "payment" {
    # source = "../../terraform-aws-sg"
    source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment
    sg_description = "sg for payment"
    sg_name="payment"
    vpc_id=local.vpc_id
  
}


module "frontend" {
    # source = "../../terraform-aws-sg"
    source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment
    sg_description = var.frontend_sg_description
    sg_name=var.frontend_sg_name
    vpc_id=local.vpc_id
  
}
module "frontend_alb"{
    source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "frontend_alb"
    sg_description = "sg for frontend alb"
    vpc_id = local.vpc_id
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
module "bastion" {
    # source = "../../terraform-aws-sg"
    source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment
    sg_description = "sg for bastion"
    sg_name= "bastion"
    vpc_id=local.vpc_id
  
}
module "vpn" {
    # source = "../../terraform-aws-sg"
    source = "git::https://github.com/Sameer-Sarrainodu/Terraform-Aws-Sg.git?ref=main"
    project = var.project
    environment = var.environment
    sg_description = "sg for vpn"
    sg_name= "vpn"
    vpc_id=local.vpc_id
  
}

# mongogdb

resource "aws_security_group_rule" "mongodb_vpn" {
  count = length(var.mongodb_ports)
  type = "ingress"
  from_port = var.mongodb_ports[count.index]
  to_port = var.mongodb_ports[count.index]
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.mongodb.sg_id
  
}
resource "aws_security_group_rule" "mongodb_bastion" {
  count = length(var.mongodb_ports)
  type = "ingress"
  from_port = var.mongodb_ports[count.index]
  to_port = var.mongodb_ports[count.index]
  protocol = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.mongodb.sg_id
  
}
resource "aws_security_group_rule" "mongodb_catalogue" {
  type = "ingress"
  from_port = 27017
  to_port = 27017 
  protocol = "tcp"
  source_security_group_id = module.catalogue.sg_id
  security_group_id = module.mongodb.sg_id
  
}

resource "aws_security_group_rule" "mongodb_user" {
  type = "ingress"
  from_port = 27017
  to_port = 27017 
  protocol = "tcp"
  source_security_group_id = module.user.sg_id
  security_group_id = module.mongodb.sg_id
  
}

resource "aws_security_group_rule" "redis_vpn" {
  count = length(var.redis_ports)
  type = "ingress"
  from_port = var.redis_ports[count.index]
  to_port = var.redis_ports[count.index]
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.redis.sg_id
  
}
resource "aws_security_group_rule" "redis_bastion" {
  count = length(var.redis_ports)
  type = "ingress"
  from_port = var.redis_ports[count.index]
  to_port = var.redis_ports[count.index]
  protocol = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.redis.sg_id
  
}

resource "aws_security_group_rule" "redis_user" {
  type = "ingress"
  from_port = 6379
  to_port = 6379
  protocol = "tcp"
  source_security_group_id = module.user.sg_id
  security_group_id = module.redis.sg_id
  
}
resource "aws_security_group_rule" "redis_cart" {
  type = "ingress"
  from_port = 6379
  to_port = 6379
  protocol = "tcp"
  source_security_group_id = module.cart.sg_id
  security_group_id = module.redis.sg_id
  
}


resource "aws_security_group_rule" "mysql_vpn" {
  count = length(var.mysql_ports)
  type = "ingress"
  from_port = var.mysql_ports[count.index]
  to_port = var.mysql_ports[count.index]
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.mysql.sg_id
  
}
resource "aws_security_group_rule" "mysql_bastion" {
  count = length(var.mysql_ports)
  type = "ingress"
  from_port = var.mysql_ports[count.index]
  to_port = var.mysql_ports[count.index]
  protocol = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.mysql.sg_id
  
}
resource "aws_security_group_rule" "mysql_shipping" {
  type = "ingress"
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  source_security_group_id = module.shipping.sg_id
  security_group_id = module.mysql.sg_id
  
}

resource "aws_security_group_rule" "rabbitmq_vpn" {
  count = length(var.rabbitmq_ports)
  type = "ingress"
  from_port = var.rabbitmq_ports[count.index]
  to_port = var.rabbitmq_ports[count.index]
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.rabbitmq.sg_id
  
}
resource "aws_security_group_rule" "rabbitmq_bastion" {
  count = length(var.rabbitmq_ports)
  type = "ingress"
  from_port = var.rabbitmq_ports[count.index]
  to_port = var.rabbitmq_ports[count.index]
  protocol = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.rabbitmq.sg_id
  
}
resource "aws_security_group_rule" "rabbitmq_payment" {
  type = "ingress"
  from_port = 5672 
  to_port =5672
  protocol = "tcp"
  source_security_group_id = module.payment.sg_id
  security_group_id = module.rabbitmq.sg_id
  
}

# bastion

resource "aws_security_group_rule" "bastion_laptop" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}


# vpn

resource "aws_security_group_rule" "vpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
} 

resource "aws_security_group_rule" "vpn_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
} 
resource "aws_security_group_rule" "vpn_1194" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
} 

resource "aws_security_group_rule" "vpn_943" {
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
} 

# catalogue


resource "aws_security_group_rule" "catalogue_vpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.catalogue.sg_id
} 
resource "aws_security_group_rule" "catalogue_vpn_http" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.catalogue.sg_id
} 
resource "aws_security_group_rule" "catalogue_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.catalogue.sg_id

} 
resource "aws_security_group_rule" "catalogue_backend_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id = module.catalogue.sg_id
} 


# user

resource "aws_security_group_rule" "user_vpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.user.sg_id
} 
resource "aws_security_group_rule" "user_vpn_http" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.user.sg_id
} 
resource "aws_security_group_rule" "user_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.user.sg_id

} 

resource "aws_security_group_rule" "user_backend_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id = module.user.sg_id
} 

# cart

resource "aws_security_group_rule" "cart_vpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.cart.sg_id
} 
resource "aws_security_group_rule" "cart_vpn_http" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.cart.sg_id
} 
resource "aws_security_group_rule" "cart_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.cart.sg_id

} 

resource "aws_security_group_rule" "cart_backend_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id = module.cart.sg_id
} 
# shipping

resource "aws_security_group_rule" "shipping_vpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.shipping.sg_id
} 
resource "aws_security_group_rule" "shipping_vpn_http" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.shipping.sg_id
} 
resource "aws_security_group_rule" "shipping_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.shipping.sg_id

} 

resource "aws_security_group_rule" "shipping_backend_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id = module.shipping.sg_id
} 


# payment

resource "aws_security_group_rule" "payment_vpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.payment.sg_id
} 
resource "aws_security_group_rule" "payment_vpn_http" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.payment.sg_id
} 
resource "aws_security_group_rule" "payment_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.payment.sg_id

} 

resource "aws_security_group_rule" "payment_backend_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id = module.payment.sg_id
} 



# backend-alb

resource "aws_security_group_rule" "backend_alb_vpn" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.backend_alb.sg_id
}
resource "aws_security_group_rule" "backend_alb_bastion" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.backend_alb.sg_id
} 
resource "aws_security_group_rule" "backend_alb_frontend" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.frontend.sg_id
  security_group_id = module.backend_alb.sg_id
} 


resource "aws_security_group_rule" "backend_alb_user" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.user.sg_id
  security_group_id = module.backend_alb.sg_id
} 
resource "aws_security_group_rule" "backend_alb_cart" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.cart.sg_id
  security_group_id = module.backend_alb.sg_id
} 


resource "aws_security_group_rule" "backend_alb_shipping" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.shipping.sg_id
  security_group_id = module.backend_alb.sg_id
} 
resource "aws_security_group_rule" "backend_alb_payment" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.payment.sg_id
  security_group_id = module.backend_alb.sg_id
} 


# frontend

resource "aws_security_group_rule" "frontend_vpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.frontend.sg_id
} 


resource "aws_security_group_rule" "frontend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.frontend.sg_id
} 



resource "aws_security_group_rule" "frontend_frontend_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.frontend_alb.sg_id
  security_group_id = module.frontend.sg_id
} 

# frontend_alb

resource "aws_security_group_rule" "frontend_alb_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.frontend_alb.sg_id
}

resource "aws_security_group_rule" "frontend_alb_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.frontend_alb.sg_id
}
