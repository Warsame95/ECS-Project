variable "vpc_id" {
  type = string
}

variable "alb_sg_id" {
  type = string
}

variable "name" {
  type = string
}

variable "MEMOS_DSN" {
  type = string
  default = "needs to be removed"
}

variable "region" {
  type = string
}

variable "container_image" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "target_group_arn" {
  type = string
}

variable "db_username" {
  type = string
  default = "admin"
}

variable "db_password" {
  type = string
}

variable "db_host" { 
  type = string 
  
}
variable "db_name" { 
  type = string 
  
}