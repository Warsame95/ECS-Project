variable "vpc_id" {
  type = string
}

variable "ecs_sg_id" {
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

variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

