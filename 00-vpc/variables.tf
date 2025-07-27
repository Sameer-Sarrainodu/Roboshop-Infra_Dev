variable "project" {
    type = string
    default = "roboshop"
  
}
variable "environment" {
    type = string
    default = "dev"
  
}
variable "public_cidr_block" {
    type=list(string)
    default = [ "10.0.1.0/24","10.0.2.0/24" ]
  
}
variable "private_cidr_block" {
    type = list(string)
    default = [ "10.0.11.0/24","10.0.12.0/24" ]
  
}
variable "database_cidr_block" {
    type = list(string)
    default = [ "10.0.21.0/24","10.0.22.0/24" ]
  
}