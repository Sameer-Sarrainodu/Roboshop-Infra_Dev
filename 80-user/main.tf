module "user"{
    source = "git::https://github.com/Sameer-Sarrainodu/terraform-aws-roboshop.git?ref=main"
    component="user"
    priority=20
}