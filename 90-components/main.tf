module "component"{
    for_each=var.components
    source = "git::https://github.com/Sameer-Sarrainodu/terraform-aws-roboshop.git?ref=main"
    component=each.key
    priority=each.value.priority
}