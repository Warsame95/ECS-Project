// vpc variables

variable "name" {
  type = string
}

variable "vpc_cidr" {
    type = string
  
}

variable "vpc_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "region" {
  type = string
}

variable "az" {
    type = list(string)
    default = ["eu-west-2a", "eu-west-2b"]
}

variable "igw-id" {
  type = string
}

variable "my_ip" {
  type = string
}

variable "db_identifier" {
  type = string
}

variable "db_snapshot_id" {
  type = string
}

variable "db_instance_class" {
  type = string
}

variable "db_subnet_group" {
  type = string
}

variable "MEMOS_DSN" {
  type = string
  default = "will change later"
}

variable "container_image" {
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

variable "repo_name" {
  type = string
}

variable "execution_role_name" {
  type = string
}

variable "policy_arn" {
  type = string
}