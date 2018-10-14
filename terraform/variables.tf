variable "region" {
    type = "string"
    default = "us-west-2"
}

variable "project_name" {
    type = "string"
    default = "sjw-example"
}

variable "environment" {
    type = "string"
    default = "dev"
}

variable "rds_user" {
    type = "string"
    default = "root"
}

variable "rds_password" {
    type = "string"
    default = "password"
}
